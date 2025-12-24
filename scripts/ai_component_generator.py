import os
import sys
from google import genai
from duckduckgo_search import DDGS

# --- CONFIGURACIÓN ---
API_KEY = os.getenv("AI_API_KEY") 
ISSUE_BODY = os.getenv("ISSUE_BODY", "")
ISSUE_TITLE = os.getenv("ISSUE_TITLE", "")
SOURCE_FILE_PATH = "lib/features/components/data/datasources/component_local_data_source.dart"
INSERTION_MARKER = "// [AI_INSERT_POINT]"

def search_web(query):
    print(f"🔍 Buscando en web: {query}...")
    try:
        # Usamos duckduckgo_search (que internamente avisa del cambio de nombre, pero funciona)
        results = DDGS().text(query, max_results=3)
        context_text = ""
        if results:
            for r in results:
                context_text += f"Title: {r['title']}\nSnippet: {r['body']}\nSource: {r['href']}\n\n"
        else:
            context_text = "No web results found."
        return context_text
    except Exception as e:
        print(f"⚠️ Error en búsqueda web: {e}")
        return "Search failed."

def read_source_file():
    try:
        with open(SOURCE_FILE_PATH, "r", encoding="utf-8") as f:
            return f.read()
    except FileNotFoundError:
        print(f"❌ No se encontró el archivo: {SOURCE_FILE_PATH}")
        sys.exit(1)

def generate_dart_code(source_code, search_context, clean_title):
    client = genai.Client(api_key=API_KEY)
    
    context_snippet = source_code[-4000:]

    prompt = f"""
    Actúa como un Senior Flutter Developer. Genera UNICAMENTE el código Dart para instanciar `ComponentTemplate`.
    
    ESTRUCTURA ACTUAL:
    ```dart
    {context_snippet}
    ```
    
    DATOS TÉCNICOS:
    {search_context}
    
    SOLICITUD: {clean_title}
    {ISSUE_BODY}
    
    REGLAS:
    1. Solo código del constructor. Sin markdown.
    2. Usa Enums exactos del contexto.
    3. Inventa ID único.
    """

    print("⚡ Preguntando a Gemini (Modelo Estable)...")
    try:
        # --- CORRECCIÓN AQUÍ: Usamos 1.5 Flash que sí está en el Free Tier ---
        response = client.models.generate_content(
            model='gemini-3-flash-preview', 
            contents=prompt
        )
        
        code = response.text
        code = code.replace("```dart", "").replace("```", "").strip()
        if code.endswith(";"):
            code = code[:-1]
            
        return code
    except Exception as e:
        print(f"❌ Error Gemini: {e}")
        sys.exit(1)

def inject_code(new_code):
    with open(SOURCE_FILE_PATH, "r", encoding="utf-8") as f:
        content = f.read()
    
    if INSERTION_MARKER not in content:
        print(f"❌ Error: Falta el marcador '{INSERTION_MARKER}'.")
        sys.exit(1)
        
    replacement = f"{new_code},\n      {INSERTION_MARKER}"
    new_content = content.replace(INSERTION_MARKER, replacement)
    
    with open(SOURCE_FILE_PATH, "w", encoding="utf-8") as f:
        f.write(new_content)
    print("✅ Código inyectado.")

def main():
    if not API_KEY:
        print("❌ Error: Falta AI_API_KEY. Revisa los Secrets de GitHub.")
        sys.exit(1)

    clean_title = ISSUE_TITLE.replace("[COMPONENT REQUEST]", "").strip()
    print(f"🚀 Procesando: {clean_title}")

    source_code = read_source_file()
    search_context = search_web(f"{clean_title} datasheet specifications")
    dart_code = generate_dart_code(source_code, search_context, clean_title)
    
    print(f"\nGenerado:\n{dart_code}\n")
    inject_code(dart_code)

if __name__ == "__main__":
    main()
