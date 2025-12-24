import os
import sys
import google.generativeai as genai
from duckduckgo_search import DDGS

# --- CONFIGURACIÓN ---
API_KEY = os.getenv("AI_API_KEY") # Nombre actualizado
ISSUE_BODY = os.getenv("ISSUE_BODY", "")
ISSUE_TITLE = os.getenv("ISSUE_TITLE", "")
SOURCE_FILE_PATH = "lib/features/components/data/datasources/component_local_data_source.dart"
INSERTION_MARKER = "// [AI_INSERT_POINT]"

def search_web(query):
    """Busca especificaciones técnicas."""
    print(f"🔍 Buscando en web: {query}...")
    try:
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
    """Usa Gemini 1.5 Flash para generar el código."""
    
    # Configuración de Gemini
    genai.configure(api_key=API_KEY)
    
    # Configuración del modelo (Flash es rápido y barato/gratis)
    model = genai.GenerativeModel('gemini-1.5-flash')

    # Contexto del código existente
    context_snippet = source_code[-4000:] # Gemini tiene gran ventana, podemos darle más contexto

    prompt = f"""
    Actúa como un Senior Flutter Developer experto en Clean Architecture.
    
    OBJETIVO:
    Generar UNICAMENTE el código Dart para instanciar un objeto `ComponentTemplate` basado en la solicitud.
    
    ESTRUCTURA DEL CÓDIGO ACTUAL (Úsalo como ejemplo exacto):
    ```dart
    {context_snippet}
    ```
    
    DATOS TÉCNICOS ENCONTRADOS EN WEB:
    {search_context}
    
    SOLICITUD DEL USUARIO (ISSUE):
    Título: {clean_title}
    Detalles: {ISSUE_BODY}
    
    REGLAS OBLIGATORIAS:
    1. Devuelve SOLO el código del constructor (ej: `const ComponentTemplate.protection(...)`).
    2. NO incluyas markdown (```dart), ni explicaciones, ni saludos. Solo código.
    3. Usa los Enums exactos que ves en el código (`ProtectionDeviceType`, `CableMaterial`).
    4. Inventa un ID único lógico (ej: 'marca-modelo-specs').
    5. Si faltan datos numéricos (precio), pon 0.0 o un estimado realista.
    """

    print("⚡ Preguntando a Gemini 1.5 Flash...")
    try:
        response = model.generate_content(prompt)
        code = response.text
        
        # Limpieza agresiva por si Gemini es muy hablador
        code = code.replace("```dart", "").replace("```", "").strip()
        if code.endswith(";"):
            code = code[:-1]
            
        return code
    except Exception as e:
        print(f"❌ Error llamando a Gemini: {e}")
        sys.exit(1)

def inject_code(new_code):
    with open(SOURCE_FILE_PATH, "r", encoding="utf-8") as f:
        content = f.read()
    
    if INSERTION_MARKER not in content:
        print(f"❌ Error: Falta el marcador '{INSERTION_MARKER}' en el archivo Dart.")
        sys.exit(1)
        
    replacement = f"{new_code},\n      {INSERTION_MARKER}"
    new_content = content.replace(INSERTION_MARKER, replacement)
    
    with open(SOURCE_FILE_PATH, "w", encoding="utf-8") as f:
        f.write(new_content)
    print("✅ Código inyectado correctamente.")

def main():
    if not API_KEY:
        print("❌ Error: Falta GEMINI_API_KEY.")
        sys.exit(1)

    clean_title = ISSUE_TITLE.replace("[COMPONENT REQUEST]", "").strip()
    print(f"🚀 Procesando: {clean_title}")

    # 1. Contexto y Búsqueda
    source_code = read_source_file()
    search_context = search_web(f"{clean_title} datasheet technical specifications")

    # 2. Generación con Gemini
    dart_code = generate_dart_code(source_code, search_context, clean_title)
    
    print("\n--- CÓDIGO GEMINI ---\n")
    print(dart_code)
    print("\n---------------------\n")

    # 3. Inyección
    inject_code(dart_code)

if __name__ == "__main__":
    main()
