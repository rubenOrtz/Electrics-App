/// Onboarding step model
class OnboardingStep {
  final int stepNumber;
  final String title;
  final String? description;

  const OnboardingStep({
    required this.stepNumber,
    required this.title,
    this.description,
  });
}

/// Available onboarding steps
class OnboardingSteps {
  static const personalInfo = OnboardingStep(
    stepNumber: 1,
    title: 'Información Personal',
    description: 'Cuéntanos sobre ti',
  );

  static const professionalType = OnboardingStep(
    stepNumber: 2,
    title: 'Tipo Profesional',
    description: 'Autónomo o empresa',
  );

  static const companyInfo = OnboardingStep(
    stepNumber: 3,
    title: 'Datos de Empresa',
    description: 'Información corporativa',
  );

  static const preferences = OnboardingStep(
    stepNumber: 4,
    title: 'Preferencias',
    description: 'Personaliza tu experiencia',
  );

  static const welcome = OnboardingStep(
    stepNumber: 5,
    title: '¡Bienvenido!',
    description: 'Todo listo para empezar',
  );

  static List<OnboardingStep> allSteps = [
    personalInfo,
    professionalType,
    companyInfo,
    preferences,
    welcome,
  ];

  static List<OnboardingStep> freelancerSteps = [
    personalInfo,
    professionalType,
    preferences,
    welcome,
  ];
}
