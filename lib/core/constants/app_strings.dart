/// Application-wide string constants
/// Centralizes all hardcoded strings to facilitate localization
/// TODO: Translate
class AppStrings {
  const AppStrings._();

  // ============================================================================
  // AUTH
  // ============================================================================
  static const String loginTitle = 'Iniciar Sesión';
  static const String registerTitle = 'Crear Cuenta';
  static const String emailLabel = 'Correo Electrónico';
  static const String passwordLabel = 'Contraseña';
  static const String confirmPasswordLabel = 'Confirmar Contraseña';
  static const String loginButton = 'Entrar';
  static const String registerButton = 'Registrarse';
  static const String forgotPassword = '¿Olvidaste tu contraseña?';
  static const String dontHaveAccount = '¿No tienes cuenta?';
  static const String alreadyHaveAccount = '¿Ya tienes cuenta?';

  // ============================================================================
  // DASHBOARD
  // ============================================================================
  static const String dashboardTitle = 'Panel Principal';
  static const String projectsLabel = 'Proyectos';
  static const String newProjectButton = 'Nuevo Proyecto';
  static const String recentProjects = 'Proyectos Recientes';
  static const String calculator = 'Calculadora';
  static const String regulations = 'Normativa';
  static const String help = 'Ayuda';

  // ============================================================================
  // DIAGRAM
  // ============================================================================
  static const String diagramTitle = 'Esquema Unifilar';
  static const String addNode = 'Añadir Componente';
  static const String deleteNode = 'Eliminar';
  static const String editNode = 'Editar';
  static const String validateDiagram = 'Validar Instalación';
  static const String exportPdf = 'Exportar PDF';
  static const String autoLayout = 'Auto-Organizar';
  static const String zoomIn = 'Acercar';
  static const String zoomOut = 'Alejar';
  static const String centerView = 'Centrar Vista';

  // ============================================================================
  // COMPONENTS
  // ============================================================================
  static const String supply = 'Acometida';
  static const String panel = 'Cuadro';
  static const String protection = 'Protección';
  static const String load = 'Carga';
  static const String lighting = 'Alumbrado';
  static const String power = 'Fuerza';
  static const String motor = 'Motor';

  // ============================================================================
  // VALIDATION
  // ============================================================================
  static const String validationSuccess = 'Instalación validada correctamente';
  static const String validationErrors = 'Se encontraron errores de validación';
  static const String calculationComplete = 'Cálculo ejecutado y validado';
  static const String goldenRuleViolation =
      'Violación de regla de oro (Ib ≤ In ≤ Iz)';
  static const String voltageDropExceeded = 'Caída de tensión excedida';
  static const String breakingCapacityInsufficient =
      'Poder de corte insuficiente';
  static const String magneticTripFailure = 'Fallo de disparo magnético';

  // ============================================================================
  // BUDGET
  // ============================================================================
  static const String budgetTitle = 'Presupuesto';
  static const String totalCost = 'Coste Total';
  static const String materials = 'Materiales';
  static const String labor = 'Mano de Obra';
  static const String generateBudget = 'Generar Presupuesto';

  // ============================================================================
  // REPORTS
  // ============================================================================
  static const String technicalMemory = 'Memoria Técnica';
  static const String budgetReport = 'Presupuesto';
  static const String userManual = 'Manual de Usuario';
  static const String generateReport = 'Generar Informe';
  static const String generatingReport = 'Generando informe...';
  static const String reportGenerated = 'Informe generado correctamente';

  // ============================================================================
  // SETTINGS
  // ============================================================================
  static const String settings = 'Ajustes';
  static const String theme = 'Tema';
  static const String language = 'Idioma';
  static const String darkMode = 'Modo Oscuro';
  static const String lightMode = 'Modo Claro';
  static const String highContrast = 'Alto Contraste';
  static const String dynamicColor = 'Color Dinámico';

  // ============================================================================
  // ERRORS
  // ============================================================================
  static const String genericError =
      'Ha ocurrido un error. Inténtalo de nuevo.';
  static const String networkError = 'Error de conexión. Verifica tu internet.';
  static const String validationError =
      'Por favor, corrige los errores del formulario.';
  static const String saveFailed = 'Error al guardar. Inténtalo de nuevo.';
  static const String loadFailed = 'Error al cargar datos.';
  static const String notFound = 'No se encontró el elemento solicitado.';
  static const String unauthorized = 'No tienes permisos para esta acción.';

  // ============================================================================
  // VALIDATION MESSAGES
  // ============================================================================
  static const String emailRequired = 'El correo es obligatorio';
  static const String emailInvalid = 'Correo no válido';
  static const String passwordRequired = 'La contraseña es obligatoria';
  static const String passwordTooShort = 'Mínimo {0} caracteres';
  static const String fieldRequired = '{0} es obligatorio';
  static const String mustBePositive = 'Debe ser un número positivo';
  static const String mustBeInRange = 'Debe estar entre {0} y {1}';

  // ============================================================================
  // SUCCESS MESSAGES
  // ============================================================================
  static const String saveSuccess = 'Guardado correctamente';
  static const String deleteSuccess = 'Eliminado correctamente';
  static const String updateSuccess = 'Actualizado correctamente';
  static const String projectCreated = 'Proyecto creado correctamente';
  static const String projectSaved = 'Proyecto guardado correctamente';

  // ============================================================================
  // CONFIRMATIONS
  // ============================================================================
  static const String confirmDelete =
      '¿Estás seguro de eliminar este elemento?';
  static const String confirmExit = '¿Salir sin guardar los cambios?';
  static const String cancel = 'Cancelar';
  static const String confirm = 'Confirmar';
  static const String yes = 'Sí';
  static const String no = 'No';
  static const String ok = 'Aceptar';

  // ============================================================================
  // HELPERS
  // ============================================================================

  /// Replaces placeholders {0}, {1}, etc. with provided values
  static String format(String template, List<dynamic> values) {
    String result = template;
    for (int i = 0; i < values.length; i++) {
      result = result.replaceAll('{$i}', values[i].toString());
    }
    return result;
  }
}
