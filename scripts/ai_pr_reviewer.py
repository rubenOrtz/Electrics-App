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

def get_pr_comments():
    """Obtiene los comentarios existentes de la PR para contexto."""
    if not GITHUB_TOKEN or not REPO_NAME or not PR_NUMBER:
        return None
    
    try:
        g = Github(GITHUB_TOKEN)
        repo = g.get_repo(REPO_NAME)
        pr = repo.get_pull(int(PR_NUMBER))
        
        # Obtener comentarios generales de la PR
        comments = pr.get_issue_comments()
        
        # Obtener comentarios de revisión de código (line-level)
        review_comments = pr.get_review_comments()
        
        formatted_comments = []
        
        # Comentarios generales
        for comment in comments:
            # Evitar incluir comentarios previos del bot
            if not comment.body.startswith("## 🤖 Gemini Code Review"):
                formatted_comments.append(f"""
**User Comment** (by {comment.user.login} on {comment.created_at}):
{comment.body}
""")
        
        # Comentarios de revisión en líneas específicas
        for comment in review_comments:
            formatted_comments.append(f"""
**Code Review Comment** (by {comment.user.login} on line {comment.position} in {comment.path}):
{comment.body}
""")
        
        if formatted_comments:
            return "\n---\n".join(formatted_comments)
        return None
        
    except Exception as e:
        print(f"⚠️ Error obteniendo comentarios de PR: {e}")
        return None

def analyze_code_with_gemini(diff_content, pr_comments=None):
    """Envía el diff y comentarios a Gemini para auditoría."""
    client = genai.Client(api_key=API_KEY)
    
    # Limitamos el diff para no reventar el token limit (aunque Flash aguanta mucho)
    if len(diff_content) > 100000:
        diff_content = diff_content[:100000] + "\n...[TRUNCATED]"

    # Construir sección de comentarios si existen
    comments_section = ""
    if pr_comments:
        comments_section = f"""
    
    EXISTING PR COMMENTS (User Feedback):
    The following comments were made by users on this PR. Take them into account when reviewing:
    
    {pr_comments}
    
    ---
    """

    prompt = f"""
    ACT AS: Senior Flutter & Clean Architecture Tech Lead.
    TASK: Review the following Git Diff for a Flutter project.
    
    RULES:
    1. Focus on CRITICAL bugs, Logic errors, and Clean Architecture violations.
    2. Ignore formatting/linting (we have linter for that).
    3. Look for "Fake implementations" (e.g. hardcoded maps instead of real logic).
    4. Be harsh but constructive.
    5. Output format: Markdown. Use emojis.
    {f'6. **IMPORTANT**: Address or acknowledge the user comments provided below.' if pr_comments else ''}
    {comments_section}
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

    print("💬 Obteniendo comentarios de la PR...")
    pr_comments = get_pr_comments()
    if pr_comments:
        print(f"✅ Se encontraron comentarios de usuarios para contexto.")
    
    print("🧠 Analizando con Gemini...")
    report = analyze_code_with_gemini(diff, pr_comments)
    
    print("📢 Publicando resultados...")
    post_comment_on_pr(report)

if __name__ == "__main__":
    main()
