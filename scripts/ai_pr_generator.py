import os
import sys
import subprocess
from google import genai
from github import Github

# --- CONFIGURACIÓN ---
API_KEY = os.getenv("AI_API_KEY")
GITHUB_TOKEN = os.getenv("GITHUB_TOKEN")
REPO_NAME = os.getenv("GITHUB_REPOSITORY")
PR_NUMBER = os.getenv("PR_NUMBER")

def get_diff():
    """Obtiene las diferencias de código de la PR actual."""
    try:
        # En GitHub Actions, necesitamos fetchear para tener contexto del diff
        subprocess.run(["git", "fetch", "origin", "main"], check=True)
        # Diff entre la rama actual y main
        result = subprocess.run(
            ["git", "diff", "origin/main", "HEAD"],
            capture_output=True, text=True, check=True
        )
        return result.stdout
    except Exception as e:
        print(f"⚠️ Error obteniendo git diff: {e}")
        return None

def analyze_code_with_gemini(diff_content):
    """Envía el diff a Gemini para auditoría."""
    client = genai.Client(api_key=API_KEY)
    
    # Limitamos el diff para no reventar el token limit (aunque Flash aguanta mucho)
    if len(diff_content) > 100000:
        diff_content = diff_content[:100000] + "\n...[TRUNCATED]"

    prompt = f"""
    ACT AS: Senior Flutter & Clean Architecture Tech Lead.
    TASK: Review the following Git Diff for a Flutter project.
    
    RULES:
    1. Focus on CRITICAL bugs, Logic errors, and Clean Architecture violations.
    2. Ignore formatting/linting (we have linter for that).
    3. Look for "Fake implementations" (e.g. hardcoded maps instead of real logic).
    4. Be harsh but constructive.
    5. Output format: Markdown. Use emojis.
    
    GIT DIFF:
    ```diff
    {diff_content}
    ```
    
    REVIEW REPORT:
    """

    try:
        response = client.models.generate_content(
            model='gemini-3-flash-preview', 
            contents=prompt
        )
        return response.text
    except Exception as e:
        return f"❌ Error analizando con Gemini: {e}"

def post_comment_on_pr(report):
    """Publica el reporte como comentario en la PR."""
    if not GITHUB_TOKEN or not REPO_NAME or not PR_NUMBER:
        print("⚠️ Faltan credenciales de GitHub para comentar.")
        print("Reporte generado en consola:\n" + report)
        return

    g = Github(GITHUB_TOKEN)
    repo = g.get_repo(REPO_NAME)
    pr = repo.get_pull(int(PR_NUMBER))
    
    comment_body = f"## 🤖 Gemini Code Review\n\n{report}\n\n_Generated automatically by Gemini Flash Agent_"
    pr.create_issue_comment(comment_body)
    print("✅ Comentario publicado en PR.")

def main():
    if not API_KEY:
        print("❌ Error: Falta AI_API_KEY.")
        sys.exit(1)

    print("🔍 Obteniendo cambios de código...")
    diff = get_diff()
    
    if not diff or len(diff.strip()) == 0:
        print("🤷‍♂️ No hay cambios detectables para revisar.")
        sys.exit(0)

    print("🧠 Analizando con Gemini...")
    report = analyze_code_with_gemini(diff)
    
    print("📢 Publicando resultados...")
    post_comment_on_pr(report)

if __name__ == "__main__":
    main()