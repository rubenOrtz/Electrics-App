import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'Electrician App'**
  String get appTitle;

  /// No description provided for @landingTitle.
  ///
  /// In es, this message translates to:
  /// **'Super-App\nEléctrica'**
  String get landingTitle;

  /// No description provided for @landingSubtitle.
  ///
  /// In es, this message translates to:
  /// **'La herramienta definitiva para el profesional en obra.'**
  String get landingSubtitle;

  /// No description provided for @landingFeatureUnified.
  ///
  /// In es, this message translates to:
  /// **'Unificación Total'**
  String get landingFeatureUnified;

  /// No description provided for @landingFeatureUnifiedSub.
  ///
  /// In es, this message translates to:
  /// **'Cálculo y diseño integrado'**
  String get landingFeatureUnifiedSub;

  /// No description provided for @landingFeatureEfficiency.
  ///
  /// In es, this message translates to:
  /// **'Eficiencia'**
  String get landingFeatureEfficiency;

  /// No description provided for @landingFeatureEfficiencySub.
  ///
  /// In es, this message translates to:
  /// **'Ahorra tiempo en obra'**
  String get landingFeatureEfficiencySub;

  /// No description provided for @landingFeatureRebt.
  ///
  /// In es, this message translates to:
  /// **'Cumplimiento REBT'**
  String get landingFeatureRebt;

  /// No description provided for @landingFeatureRebtSub.
  ///
  /// In es, this message translates to:
  /// **'Siempre actualizado'**
  String get landingFeatureRebtSub;

  /// No description provided for @createAccount.
  ///
  /// In es, this message translates to:
  /// **'Crear Cuenta'**
  String get createAccount;

  /// No description provided for @login.
  ///
  /// In es, this message translates to:
  /// **'Iniciar Sesión'**
  String get login;

  /// No description provided for @orContinueWith.
  ///
  /// In es, this message translates to:
  /// **'O continuar con'**
  String get orContinueWith;

  /// No description provided for @registerTitle.
  ///
  /// In es, this message translates to:
  /// **'Crear Cuenta'**
  String get registerTitle;

  /// No description provided for @registerSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Accede a la herramienta definitiva para instaladores eléctricos.'**
  String get registerSubtitle;

  /// No description provided for @fullName.
  ///
  /// In es, this message translates to:
  /// **'Nombre completo'**
  String get fullName;

  /// No description provided for @email.
  ///
  /// In es, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get password;

  /// No description provided for @acceptTerms.
  ///
  /// In es, this message translates to:
  /// **'Acepto los '**
  String get acceptTerms;

  /// No description provided for @termsAndConditions.
  ///
  /// In es, this message translates to:
  /// **'términos y condiciones'**
  String get termsAndConditions;

  /// No description provided for @andPrivacy.
  ///
  /// In es, this message translates to:
  /// **' y la política de privacidad.'**
  String get andPrivacy;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In es, this message translates to:
  /// **'¿Ya tienes cuenta? '**
  String get alreadyHaveAccount;

  /// No description provided for @loginTitle.
  ///
  /// In es, this message translates to:
  /// **'Bienvenido'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Inicia sesión para continuar con tus proyectos.'**
  String get loginSubtitle;

  /// No description provided for @forgotPassword.
  ///
  /// In es, this message translates to:
  /// **'¿Olvidaste tu contraseña?'**
  String get forgotPassword;

  /// No description provided for @noAccount.
  ///
  /// In es, this message translates to:
  /// **'¿No tienes cuenta? '**
  String get noAccount;

  /// No description provided for @register.
  ///
  /// In es, this message translates to:
  /// **'Regístrate'**
  String get register;

  /// No description provided for @navHome.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get navHome;

  /// No description provided for @navCalculations.
  ///
  /// In es, this message translates to:
  /// **'Cálculos'**
  String get navCalculations;

  /// No description provided for @navProjects.
  ///
  /// In es, this message translates to:
  /// **'Proyectos'**
  String get navProjects;

  /// No description provided for @navProfile.
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get navProfile;

  /// No description provided for @homeWelcome.
  ///
  /// In es, this message translates to:
  /// **'¡Bienvenido de nuevo!'**
  String get homeWelcome;

  /// No description provided for @homeWelcomeUser.
  ///
  /// In es, this message translates to:
  /// **'¡Bienvenido, {name}!'**
  String homeWelcomeUser(String name);

  /// No description provided for @homeGreetingMorning.
  ///
  /// In es, this message translates to:
  /// **'Buenos días'**
  String get homeGreetingMorning;

  /// No description provided for @homeGreetingAfternoon.
  ///
  /// In es, this message translates to:
  /// **'Buenas tardes'**
  String get homeGreetingAfternoon;

  /// No description provided for @homeGreetingEvening.
  ///
  /// In es, this message translates to:
  /// **'Buenas noches'**
  String get homeGreetingEvening;

  /// No description provided for @homeQuickAccess.
  ///
  /// In es, this message translates to:
  /// **'Acceso Rápido'**
  String get homeQuickAccess;

  /// No description provided for @homeComponentLibrary.
  ///
  /// In es, this message translates to:
  /// **'Biblioteca de Componentes'**
  String get homeComponentLibrary;

  /// No description provided for @homeCalculators.
  ///
  /// In es, this message translates to:
  /// **'Calculadoras'**
  String get homeCalculators;

  /// No description provided for @homeDocuments.
  ///
  /// In es, this message translates to:
  /// **'Documentos'**
  String get homeDocuments;

  /// No description provided for @homeRegulations.
  ///
  /// In es, this message translates to:
  /// **'Reglamentos'**
  String get homeRegulations;

  /// No description provided for @projectsTitle.
  ///
  /// In es, this message translates to:
  /// **'Proyectos'**
  String get projectsTitle;

  /// No description provided for @searchPlaceholder.
  ///
  /// In es, this message translates to:
  /// **'Buscar dirección, cliente...'**
  String get searchPlaceholder;

  /// No description provided for @filterAll.
  ///
  /// In es, this message translates to:
  /// **'Todos'**
  String get filterAll;

  /// No description provided for @filterDesign.
  ///
  /// In es, this message translates to:
  /// **'En Diseño'**
  String get filterDesign;

  /// No description provided for @filterPending.
  ///
  /// In es, this message translates to:
  /// **'Pendiente Visado'**
  String get filterPending;

  /// No description provided for @filterFinished.
  ///
  /// In es, this message translates to:
  /// **'Finalizado'**
  String get filterFinished;

  /// No description provided for @clientLabel.
  ///
  /// In es, this message translates to:
  /// **'Cliente: '**
  String get clientLabel;

  /// No description provided for @profileTitle.
  ///
  /// In es, this message translates to:
  /// **'Mi Perfil'**
  String get profileTitle;

  /// No description provided for @editProfile.
  ///
  /// In es, this message translates to:
  /// **'Editar'**
  String get editProfile;

  /// No description provided for @professionalData.
  ///
  /// In es, this message translates to:
  /// **'Datos Profesionales'**
  String get professionalData;

  /// No description provided for @contact.
  ///
  /// In es, this message translates to:
  /// **'Contacto'**
  String get contact;

  /// No description provided for @technicalConfig.
  ///
  /// In es, this message translates to:
  /// **'Configuración Técnica'**
  String get technicalConfig;

  /// No description provided for @saveChanges.
  ///
  /// In es, this message translates to:
  /// **'Guardar Cambios'**
  String get saveChanges;

  /// No description provided for @emailHint.
  ///
  /// In es, this message translates to:
  /// **'correo@ejemplo.com'**
  String get emailHint;

  /// No description provided for @passwordHint.
  ///
  /// In es, this message translates to:
  /// **'••••••••'**
  String get passwordHint;

  /// No description provided for @noAccountPrompt.
  ///
  /// In es, this message translates to:
  /// **'¿No tienes cuenta?'**
  String get noAccountPrompt;

  /// No description provided for @logout.
  ///
  /// In es, this message translates to:
  /// **'Cerrar Sesión'**
  String get logout;

  /// No description provided for @regulationsTitle.
  ///
  /// In es, this message translates to:
  /// **'Biblioteca Normativa'**
  String get regulationsTitle;

  /// No description provided for @searchRegulationsPlaceholder.
  ///
  /// In es, this message translates to:
  /// **'Buscar normativa (ej. ITC-BT-52)...'**
  String get searchRegulationsPlaceholder;

  /// No description provided for @recentUpdates.
  ///
  /// In es, this message translates to:
  /// **'ACTUALIZACIONES RECIENTES'**
  String get recentUpdates;

  /// No description provided for @mainCategories.
  ///
  /// In es, this message translates to:
  /// **'Categorías Principales'**
  String get mainCategories;

  /// No description provided for @categories.
  ///
  /// In es, this message translates to:
  /// **'Categorías'**
  String get categories;

  /// No description provided for @lowVoltage.
  ///
  /// In es, this message translates to:
  /// **'Baja Tensión'**
  String get lowVoltage;

  /// No description provided for @highVoltage.
  ///
  /// In es, this message translates to:
  /// **'Alta Tensión'**
  String get highVoltage;

  /// No description provided for @safety.
  ///
  /// In es, this message translates to:
  /// **'Seguridad'**
  String get safety;

  /// No description provided for @technicalGuides.
  ///
  /// In es, this message translates to:
  /// **'Guías Técnicas'**
  String get technicalGuides;

  /// No description provided for @helpTitle.
  ///
  /// In es, this message translates to:
  /// **'Ayuda y Soporte'**
  String get helpTitle;

  /// No description provided for @searchHelp.
  ///
  /// In es, this message translates to:
  /// **'Buscar dudas, errores, guías...'**
  String get searchHelp;

  /// No description provided for @searchHelpPlaceholder.
  ///
  /// In es, this message translates to:
  /// **'Buscar ayuda...'**
  String get searchHelpPlaceholder;

  /// No description provided for @helpTopics.
  ///
  /// In es, this message translates to:
  /// **'Temas de Ayuda'**
  String get helpTopics;

  /// No description provided for @contactSupport.
  ///
  /// In es, this message translates to:
  /// **'Contactar Soporte'**
  String get contactSupport;

  /// No description provided for @selfHelpResources.
  ///
  /// In es, this message translates to:
  /// **'Recursos de Autoayuda'**
  String get selfHelpResources;

  /// No description provided for @autoHelpResources.
  ///
  /// In es, this message translates to:
  /// **'RECURSOS DE AUTOAYUDA'**
  String get autoHelpResources;

  /// No description provided for @faq.
  ///
  /// In es, this message translates to:
  /// **'Preguntas Frecuentes'**
  String get faq;

  /// No description provided for @userGuides.
  ///
  /// In es, this message translates to:
  /// **'Guías de Uso'**
  String get userGuides;

  /// No description provided for @videoTutorials.
  ///
  /// In es, this message translates to:
  /// **'Video Tutoriales'**
  String get videoTutorials;

  /// No description provided for @contactSupportBtn.
  ///
  /// In es, this message translates to:
  /// **'CONTACTAR SOPORTE TÉCNICO'**
  String get contactSupportBtn;

  /// No description provided for @liveChat.
  ///
  /// In es, this message translates to:
  /// **'Chat en Vivo'**
  String get liveChat;

  /// No description provided for @sendEmail.
  ///
  /// In es, this message translates to:
  /// **'Enviar Email'**
  String get sendEmail;

  /// No description provided for @callSupport.
  ///
  /// In es, this message translates to:
  /// **'Llamar a Soporte'**
  String get callSupport;

  /// No description provided for @toolsTitle.
  ///
  /// In es, this message translates to:
  /// **'Herramientas de Cálculo'**
  String get toolsTitle;

  /// No description provided for @toolEvCharger.
  ///
  /// In es, this message translates to:
  /// **'Cargador Vehículo Eléctrico'**
  String get toolEvCharger;

  /// No description provided for @toolEvChargerSub.
  ///
  /// In es, this message translates to:
  /// **'Cálculo de sección según ITC-BT-52'**
  String get toolEvChargerSub;

  /// No description provided for @toolVoltageDrop.
  ///
  /// In es, this message translates to:
  /// **'Caída de Tensión'**
  String get toolVoltageDrop;

  /// No description provided for @toolVoltageDropSub.
  ///
  /// In es, this message translates to:
  /// **'Cálculo genérico de sección por c.d.t.'**
  String get toolVoltageDropSub;

  /// No description provided for @toolTubeDim.
  ///
  /// In es, this message translates to:
  /// **'Dimensionado de Tubos'**
  String get toolTubeDim;

  /// No description provided for @toolTubeDimSub.
  ///
  /// In es, this message translates to:
  /// **'Según número y sección de conductores'**
  String get toolTubeDimSub;

  /// No description provided for @calculationsTitle.
  ///
  /// In es, this message translates to:
  /// **'Herramientas de Cálculo'**
  String get calculationsTitle;

  /// No description provided for @cableCalculations.
  ///
  /// In es, this message translates to:
  /// **'Cables y Conductores'**
  String get cableCalculations;

  /// No description provided for @ampacity.
  ///
  /// In es, this message translates to:
  /// **'Intensidad Admisible'**
  String get ampacity;

  /// No description provided for @ampacityDesc.
  ///
  /// In es, this message translates to:
  /// **'Capacidad de corriente según tipo de instalación.'**
  String get ampacityDesc;

  /// No description provided for @conduitSize.
  ///
  /// In es, this message translates to:
  /// **'Dimensionado de Tubos'**
  String get conduitSize;

  /// No description provided for @conduitSizeDesc.
  ///
  /// In es, this message translates to:
  /// **'Diámetro de tubos y canalizaciones.'**
  String get conduitSizeDesc;

  /// No description provided for @installations.
  ///
  /// In es, this message translates to:
  /// **'Instalaciones'**
  String get installations;

  /// No description provided for @chargingStation.
  ///
  /// In es, this message translates to:
  /// **'Punto de Recarga VE'**
  String get chargingStation;

  /// No description provided for @chargingStationDesc.
  ///
  /// In es, this message translates to:
  /// **'Calculadora para puntos de recarga de vehículos.'**
  String get chargingStationDesc;

  /// No description provided for @capacitorBank.
  ///
  /// In es, this message translates to:
  /// **'Batería de Condensadores'**
  String get capacitorBank;

  /// No description provided for @capacitorBankDesc.
  ///
  /// In es, this message translates to:
  /// **'Compensación de energía reactiva.'**
  String get capacitorBankDesc;

  /// No description provided for @costs.
  ///
  /// In es, this message translates to:
  /// **'Costes y Presupuestos'**
  String get costs;

  /// No description provided for @budgetEstimator.
  ///
  /// In es, this message translates to:
  /// **'Estimador de Presupuesto'**
  String get budgetEstimator;

  /// No description provided for @budgetEstimatorDesc.
  ///
  /// In es, this message translates to:
  /// **'Generación rápida de presupuestos aproximados.'**
  String get budgetEstimatorDesc;

  /// No description provided for @evChargerTitle.
  ///
  /// In es, this message translates to:
  /// **'Cargador VE'**
  String get evChargerTitle;

  /// No description provided for @housing.
  ///
  /// In es, this message translates to:
  /// **'Vivienda'**
  String get housing;

  /// No description provided for @garage.
  ///
  /// In es, this message translates to:
  /// **'Garaje Com.'**
  String get garage;

  /// No description provided for @publicWay.
  ///
  /// In es, this message translates to:
  /// **'Vía Pública'**
  String get publicWay;

  /// No description provided for @chargingPointData.
  ///
  /// In es, this message translates to:
  /// **'Datos del Punto de Carga'**
  String get chargingPointData;

  /// No description provided for @installationScheme.
  ///
  /// In es, this message translates to:
  /// **'Esquema de Instalación (ITC-BT-52)'**
  String get installationScheme;

  /// No description provided for @powerKw.
  ///
  /// In es, this message translates to:
  /// **'Potencia (kW)'**
  String get powerKw;

  /// No description provided for @lengthM.
  ///
  /// In es, this message translates to:
  /// **'Longitud (m)'**
  String get lengthM;

  /// No description provided for @cableType.
  ///
  /// In es, this message translates to:
  /// **'TIPO DE CABLE'**
  String get cableType;

  /// No description provided for @installationSystem.
  ///
  /// In es, this message translates to:
  /// **'Sistema de Instalación'**
  String get installationSystem;

  /// No description provided for @calculateSection.
  ///
  /// In es, this message translates to:
  /// **'Calcular Sección'**
  String get calculateSection;

  /// No description provided for @calculationResult.
  ///
  /// In es, this message translates to:
  /// **'Resultado del Cálculo'**
  String get calculationResult;

  /// No description provided for @section.
  ///
  /// In es, this message translates to:
  /// **'Sección (mm²)'**
  String get section;

  /// No description provided for @voltageDrop.
  ///
  /// In es, this message translates to:
  /// **'Caída Tensión'**
  String get voltageDrop;

  /// No description provided for @voltageDropDesc.
  ///
  /// In es, this message translates to:
  /// **'Cálculo de caída de tensión en conductores.'**
  String get voltageDropDesc;

  /// No description provided for @protection.
  ///
  /// In es, this message translates to:
  /// **'Protección'**
  String get protection;

  /// No description provided for @configTitle.
  ///
  /// In es, this message translates to:
  /// **'Configuración del Proyecto'**
  String get configTitle;

  /// No description provided for @generalInfo.
  ///
  /// In es, this message translates to:
  /// **'INFORMACIÓN GENERAL'**
  String get generalInfo;

  /// No description provided for @projectName.
  ///
  /// In es, this message translates to:
  /// **'Nombre del Proyecto'**
  String get projectName;

  /// No description provided for @internalRef.
  ///
  /// In es, this message translates to:
  /// **'Referencia Interna'**
  String get internalRef;

  /// No description provided for @location.
  ///
  /// In es, this message translates to:
  /// **'Emplazamiento'**
  String get location;

  /// No description provided for @holderData.
  ///
  /// In es, this message translates to:
  /// **'Datos del Titular'**
  String get holderData;

  /// No description provided for @holderName.
  ///
  /// In es, this message translates to:
  /// **'Titular / Razón Social'**
  String get holderName;

  /// No description provided for @nifCif.
  ///
  /// In es, this message translates to:
  /// **'NIF / CIF'**
  String get nifCif;

  /// No description provided for @electricalParams.
  ///
  /// In es, this message translates to:
  /// **'Parámetros Eléctricos'**
  String get electricalParams;

  /// No description provided for @supplyVoltage.
  ///
  /// In es, this message translates to:
  /// **'Tensión de Suministro'**
  String get supplyVoltage;

  /// No description provided for @installationUse.
  ///
  /// In es, this message translates to:
  /// **'Uso de la Instalación'**
  String get installationUse;

  /// No description provided for @expectedPower.
  ///
  /// In es, this message translates to:
  /// **'Potencia Prevista (kW)'**
  String get expectedPower;

  /// No description provided for @corporateEmail.
  ///
  /// In es, this message translates to:
  /// **'Email Corporativo'**
  String get corporateEmail;

  /// No description provided for @mobilePhone.
  ///
  /// In es, this message translates to:
  /// **'Teléfono Móvil'**
  String get mobilePhone;

  /// No description provided for @powerFactor.
  ///
  /// In es, this message translates to:
  /// **'Factor Potencia'**
  String get powerFactor;

  /// No description provided for @requiresProject.
  ///
  /// In es, this message translates to:
  /// **'Requiere Proyecto Técnico'**
  String get requiresProject;

  /// No description provided for @newLinkInstallation.
  ///
  /// In es, this message translates to:
  /// **'Instalación de Enlace Nueva'**
  String get newLinkInstallation;

  /// No description provided for @saveAndContinue.
  ///
  /// In es, this message translates to:
  /// **'Guardar y Continuar'**
  String get saveAndContinue;

  /// No description provided for @docGenTitle.
  ///
  /// In es, this message translates to:
  /// **'Generar Documentación'**
  String get docGenTitle;

  /// No description provided for @docSelection.
  ///
  /// In es, this message translates to:
  /// **'SELECCIÓN DE DOCUMENTOS'**
  String get docSelection;

  /// No description provided for @techMemory.
  ///
  /// In es, this message translates to:
  /// **'Memoria Técnica'**
  String get techMemory;

  /// No description provided for @singleLinePlan.
  ///
  /// In es, this message translates to:
  /// **'Plano Unifilar'**
  String get singleLinePlan;

  /// No description provided for @installCert.
  ///
  /// In es, this message translates to:
  /// **'Certificado Instalación'**
  String get installCert;

  /// No description provided for @userManual.
  ///
  /// In es, this message translates to:
  /// **'Manual de Usuario'**
  String get userManual;

  /// No description provided for @designCategory.
  ///
  /// In es, this message translates to:
  /// **'Diseño y Planos'**
  String get designCategory;

  /// No description provided for @singleLineTool.
  ///
  /// In es, this message translates to:
  /// **'Editor Esquemas Unifilares'**
  String get singleLineTool;

  /// No description provided for @singleLineToolDesc.
  ///
  /// In es, this message translates to:
  /// **'Diseño visual de cuadros y circuitos.'**
  String get singleLineToolDesc;

  /// No description provided for @exportOptions.
  ///
  /// In es, this message translates to:
  /// **'OPCIONES DE EXPORTACIÓN'**
  String get exportOptions;

  /// No description provided for @format.
  ///
  /// In es, this message translates to:
  /// **'Formato'**
  String get format;

  /// No description provided for @language.
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get language;

  /// No description provided for @includeDigitalSig.
  ///
  /// In es, this message translates to:
  /// **'Incluir Firma Digital'**
  String get includeDigitalSig;

  /// No description provided for @generateDownload.
  ///
  /// In es, this message translates to:
  /// **'Generar y Descargar'**
  String get generateDownload;

  /// No description provided for @diagramTitle.
  ///
  /// In es, this message translates to:
  /// **'Esquema Unifilar'**
  String get diagramTitle;

  /// No description provided for @properties.
  ///
  /// In es, this message translates to:
  /// **'Propiedades'**
  String get properties;

  /// No description provided for @element.
  ///
  /// In es, this message translates to:
  /// **'Elemento'**
  String get element;

  /// No description provided for @reference.
  ///
  /// In es, this message translates to:
  /// **'Referencia'**
  String get reference;

  /// No description provided for @intensity.
  ///
  /// In es, this message translates to:
  /// **'Intensidad'**
  String get intensity;

  /// No description provided for @pole.
  ///
  /// In es, this message translates to:
  /// **'Polo'**
  String get pole;

  /// No description provided for @editDetail.
  ///
  /// In es, this message translates to:
  /// **'Editar Detalle'**
  String get editDetail;

  /// No description provided for @settingsGeneral.
  ///
  /// In es, this message translates to:
  /// **'GENERAL'**
  String get settingsGeneral;

  /// No description provided for @settingsLanguage.
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get settingsLanguage;

  /// No description provided for @settingsNotifications.
  ///
  /// In es, this message translates to:
  /// **'Notificaciones'**
  String get settingsNotifications;

  /// No description provided for @settingsNotificationsSub.
  ///
  /// In es, this message translates to:
  /// **'Alertas de normativa y proyectos'**
  String get settingsNotificationsSub;

  /// No description provided for @settingsAccessibility.
  ///
  /// In es, this message translates to:
  /// **'ACCESIBILIDAD (OBRA)'**
  String get settingsAccessibility;

  /// No description provided for @settingsHighContrast.
  ///
  /// In es, this message translates to:
  /// **'Alto Contraste'**
  String get settingsHighContrast;

  /// No description provided for @settingsHighContrastSub.
  ///
  /// In es, this message translates to:
  /// **'Mejorar visibilidad en exteriores'**
  String get settingsHighContrastSub;

  /// No description provided for @settingsTextSize.
  ///
  /// In es, this message translates to:
  /// **'Tamaño de Texto'**
  String get settingsTextSize;

  /// No description provided for @settingsIdentity.
  ///
  /// In es, this message translates to:
  /// **'CUENTA Y SEGURIDAD'**
  String get settingsIdentity;

  /// No description provided for @settingsPassword.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get settingsPassword;

  /// No description provided for @settingsPrivacy.
  ///
  /// In es, this message translates to:
  /// **'Privacidad y Datos'**
  String get settingsPrivacy;

  /// No description provided for @settingsSupport.
  ///
  /// In es, this message translates to:
  /// **'SOPORTE'**
  String get settingsSupport;

  /// No description provided for @settingsHelp.
  ///
  /// In es, this message translates to:
  /// **'Ayuda'**
  String get settingsHelp;

  /// No description provided for @settingsReport.
  ///
  /// In es, this message translates to:
  /// **'Reportar Problema'**
  String get settingsReport;

  /// No description provided for @settingsPlanPro.
  ///
  /// In es, this message translates to:
  /// **'Plan Pro Activo'**
  String get settingsPlanPro;

  /// No description provided for @settingsPlanBasic.
  ///
  /// In es, this message translates to:
  /// **'Plan Básico'**
  String get settingsPlanBasic;

  /// No description provided for @settingsSignOut.
  ///
  /// In es, this message translates to:
  /// **'Cerrar Sesión'**
  String get settingsSignOut;

  /// No description provided for @comingSoonTitle.
  ///
  /// In es, this message translates to:
  /// **'Próximamente'**
  String get comingSoonTitle;

  /// No description provided for @comingSoonMessage.
  ///
  /// In es, this message translates to:
  /// **'Esta funcionalidad estará disponible dentro de poco, estamos trabajando activamente en ello.'**
  String get comingSoonMessage;

  /// No description provided for @featureUnderDevelopment.
  ///
  /// In es, this message translates to:
  /// **'La funcionalidad {feature} estará disponible dentro de poco, estamos trabajando activamente en ello.'**
  String featureUnderDevelopment(Object feature);

  /// No description provided for @close.
  ///
  /// In es, this message translates to:
  /// **'Cerrar'**
  String get close;

  /// No description provided for @componentConfig.
  ///
  /// In es, this message translates to:
  /// **'Configuración del Componente'**
  String get componentConfig;

  /// No description provided for @measurementsRegistered.
  ///
  /// In es, this message translates to:
  /// **'Mediciones Registradas'**
  String get measurementsRegistered;

  /// No description provided for @noMeasurements.
  ///
  /// In es, this message translates to:
  /// **'Sin mediciones registradas'**
  String get noMeasurements;

  /// No description provided for @noProperties.
  ///
  /// In es, this message translates to:
  /// **'Sin propiedades configuradas'**
  String get noProperties;

  /// No description provided for @sourceInput.
  ///
  /// In es, this message translates to:
  /// **'Fuente / Acometida'**
  String get sourceInput;

  /// No description provided for @panel.
  ///
  /// In es, this message translates to:
  /// **'Cuadro Eléctrico'**
  String get panel;

  /// No description provided for @loadCircuit.
  ///
  /// In es, this message translates to:
  /// **'Carga / Circuito'**
  String get loadCircuit;

  /// No description provided for @measurementSource.
  ///
  /// In es, this message translates to:
  /// **'Medición de Fuente'**
  String get measurementSource;

  /// No description provided for @measurementRcd.
  ///
  /// In es, this message translates to:
  /// **'Test Diferencial (RCD)'**
  String get measurementRcd;

  /// No description provided for @measurementInsulation.
  ///
  /// In es, this message translates to:
  /// **'Resistencia de Aislamiento'**
  String get measurementInsulation;

  /// No description provided for @measurementLoad.
  ///
  /// In es, this message translates to:
  /// **'Medición de Carga (Zs)'**
  String get measurementLoad;

  /// No description provided for @measurementPanel.
  ///
  /// In es, this message translates to:
  /// **'Resistencia de Tierra'**
  String get measurementPanel;

  /// No description provided for @measurementGeneric.
  ///
  /// In es, this message translates to:
  /// **'Medición General'**
  String get measurementGeneric;

  /// No description provided for @voltageLN.
  ///
  /// In es, this message translates to:
  /// **'Tensión L-N'**
  String get voltageLN;

  /// No description provided for @voltageLL.
  ///
  /// In es, this message translates to:
  /// **'Tensión L-L'**
  String get voltageLL;

  /// No description provided for @frequency.
  ///
  /// In es, this message translates to:
  /// **'Frecuencia'**
  String get frequency;

  /// No description provided for @externalZe.
  ///
  /// In es, this message translates to:
  /// **'Ze Externa'**
  String get externalZe;

  /// No description provided for @tripTime.
  ///
  /// In es, this message translates to:
  /// **'Tiempo de Disparo'**
  String get tripTime;

  /// No description provided for @tripCurrent.
  ///
  /// In es, this message translates to:
  /// **'Corriente de Disparo'**
  String get tripCurrent;

  /// No description provided for @contactVoltage.
  ///
  /// In es, this message translates to:
  /// **'Tensión de Contacto'**
  String get contactVoltage;

  /// No description provided for @mechanicalTest.
  ///
  /// In es, this message translates to:
  /// **'Test Mecánico (Botón T)'**
  String get mechanicalTest;

  /// No description provided for @passed.
  ///
  /// In es, this message translates to:
  /// **'PASADO'**
  String get passed;

  /// No description provided for @failed.
  ///
  /// In es, this message translates to:
  /// **'FALLIDO'**
  String get failed;

  /// No description provided for @phaseEarthR.
  ///
  /// In es, this message translates to:
  /// **'R Fase-Tierra'**
  String get phaseEarthR;

  /// No description provided for @phaseNeutralR.
  ///
  /// In es, this message translates to:
  /// **'R Fase-Neutro'**
  String get phaseNeutralR;

  /// No description provided for @continuityPE.
  ///
  /// In es, this message translates to:
  /// **'Continuidad PE'**
  String get continuityPE;

  /// No description provided for @yes.
  ///
  /// In es, this message translates to:
  /// **'SÍ'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In es, this message translates to:
  /// **'NO'**
  String get no;

  /// No description provided for @loopImpedance.
  ///
  /// In es, this message translates to:
  /// **'Impedancia Bucle (Zs)'**
  String get loopImpedance;

  /// No description provided for @voltageLoad.
  ///
  /// In es, this message translates to:
  /// **'Tensión en Carga'**
  String get voltageLoad;

  /// No description provided for @polarity.
  ///
  /// In es, this message translates to:
  /// **'Polaridad'**
  String get polarity;

  /// No description provided for @correct.
  ///
  /// In es, this message translates to:
  /// **'CORRECTA'**
  String get correct;

  /// No description provided for @incorrect.
  ///
  /// In es, this message translates to:
  /// **'INCORRECTA'**
  String get incorrect;

  /// No description provided for @earthResistance.
  ///
  /// In es, this message translates to:
  /// **'Resistencia de Tierra (Ra)'**
  String get earthResistance;

  /// No description provided for @notes.
  ///
  /// In es, this message translates to:
  /// **'Notas'**
  String get notes;

  /// No description provided for @maintenanceTitle.
  ///
  /// In es, this message translates to:
  /// **'Mantenimiento y Diagnóstico'**
  String get maintenanceTitle;

  /// No description provided for @activeInspection.
  ///
  /// In es, this message translates to:
  /// **'INSPECCIÓN ACTIVA'**
  String get activeInspection;

  /// No description provided for @scanEquipment.
  ///
  /// In es, this message translates to:
  /// **'Escanear\nEquipo'**
  String get scanEquipment;

  /// No description provided for @manualEntry.
  ///
  /// In es, this message translates to:
  /// **'Entrada Manual'**
  String get manualEntry;

  /// No description provided for @security.
  ///
  /// In es, this message translates to:
  /// **'SEGURIDAD'**
  String get security;

  /// No description provided for @regulationsRebt.
  ///
  /// In es, this message translates to:
  /// **'NORMATIVA REBT'**
  String get regulationsRebt;

  /// No description provided for @verifications.
  ///
  /// In es, this message translates to:
  /// **'VERIFICACIONES'**
  String get verifications;

  /// No description provided for @warnings.
  ///
  /// In es, this message translates to:
  /// **'Avisos'**
  String get warnings;

  /// No description provided for @compliant.
  ///
  /// In es, this message translates to:
  /// **'CUMPLE REBT'**
  String get compliant;

  /// No description provided for @failures.
  ///
  /// In es, this message translates to:
  /// **'Fallos'**
  String get failures;

  /// No description provided for @resultsAndTips.
  ///
  /// In es, this message translates to:
  /// **'Resultados y Consejos'**
  String get resultsAndTips;

  /// No description provided for @insightsCount.
  ///
  /// In es, this message translates to:
  /// **'insights'**
  String get insightsCount;

  /// No description provided for @noProblemsDetected.
  ///
  /// In es, this message translates to:
  /// **'No se detectaron problemas'**
  String get noProblemsDetected;

  /// No description provided for @scanFeatureComingSoon.
  ///
  /// In es, this message translates to:
  /// **'Funcionalidad de escaneo QR/NFC próximamente'**
  String get scanFeatureComingSoon;

  /// No description provided for @measurementSaved.
  ///
  /// In es, this message translates to:
  /// **'Medición guardada'**
  String get measurementSaved;

  /// No description provided for @securityCritical.
  ///
  /// In es, this message translates to:
  /// **'Crítica'**
  String get securityCritical;

  /// No description provided for @securityLow.
  ///
  /// In es, this message translates to:
  /// **'Baja'**
  String get securityLow;

  /// No description provided for @securityMedium.
  ///
  /// In es, this message translates to:
  /// **'Media'**
  String get securityMedium;

  /// No description provided for @securityHigh.
  ///
  /// In es, this message translates to:
  /// **'Alta'**
  String get securityHigh;

  /// No description provided for @installationState.
  ///
  /// In es, this message translates to:
  /// **'Estado de la Instalación'**
  String get installationState;

  /// No description provided for @viewScheme.
  ///
  /// In es, this message translates to:
  /// **'VER ESQUEMA'**
  String get viewScheme;

  /// No description provided for @calculatedOnComponents.
  ///
  /// In es, this message translates to:
  /// **'Calculado sobre {count} componentes'**
  String calculatedOnComponents(Object count);

  /// No description provided for @insightCritical.
  ///
  /// In es, this message translates to:
  /// **'CRÍTICO'**
  String get insightCritical;

  /// No description provided for @insightNormative.
  ///
  /// In es, this message translates to:
  /// **'NORMATIVA'**
  String get insightNormative;

  /// No description provided for @paletteProtections.
  ///
  /// In es, this message translates to:
  /// **'Protecciones'**
  String get paletteProtections;

  /// No description provided for @paletteWiring.
  ///
  /// In es, this message translates to:
  /// **'Cableado'**
  String get paletteWiring;

  /// No description provided for @paletteReceivers.
  ///
  /// In es, this message translates to:
  /// **'Receptores'**
  String get paletteReceivers;

  /// No description provided for @paletteMeasurement.
  ///
  /// In es, this message translates to:
  /// **'Medida'**
  String get paletteMeasurement;

  /// No description provided for @elemGrid.
  ///
  /// In es, this message translates to:
  /// **'Red'**
  String get elemGrid;

  /// No description provided for @elemBreaker.
  ///
  /// In es, this message translates to:
  /// **'Automático'**
  String get elemBreaker;

  /// No description provided for @elemDifferential.
  ///
  /// In es, this message translates to:
  /// **'Diferencial'**
  String get elemDifferential;

  /// No description provided for @elemLoad.
  ///
  /// In es, this message translates to:
  /// **'Carga'**
  String get elemLoad;

  /// No description provided for @elemSubpanel.
  ///
  /// In es, this message translates to:
  /// **'Subcuadro'**
  String get elemSubpanel;

  /// No description provided for @elemCable.
  ///
  /// In es, this message translates to:
  /// **'Cable'**
  String get elemCable;

  /// No description provided for @elemJunction.
  ///
  /// In es, this message translates to:
  /// **'Caja'**
  String get elemJunction;

  /// No description provided for @propVoltage.
  ///
  /// In es, this message translates to:
  /// **'Tensión'**
  String get propVoltage;

  /// No description provided for @propCurrent.
  ///
  /// In es, this message translates to:
  /// **'Intensidad'**
  String get propCurrent;

  /// No description provided for @propDrop.
  ///
  /// In es, this message translates to:
  /// **'Caída'**
  String get propDrop;

  /// No description provided for @propPower.
  ///
  /// In es, this message translates to:
  /// **'Potencia'**
  String get propPower;

  /// No description provided for @propCosPhi.
  ///
  /// In es, this message translates to:
  /// **'cos φ'**
  String get propCosPhi;

  /// No description provided for @propDesignCurrent.
  ///
  /// In es, this message translates to:
  /// **'Ib (diseño)'**
  String get propDesignCurrent;

  /// No description provided for @propVoltageNode.
  ///
  /// In es, this message translates to:
  /// **'V (nodo)'**
  String get propVoltageNode;

  /// No description provided for @propDropVolts.
  ///
  /// In es, this message translates to:
  /// **'ΔU'**
  String get propDropVolts;

  /// No description provided for @propIcc.
  ///
  /// In es, this message translates to:
  /// **'ICC'**
  String get propIcc;

  /// No description provided for @propRating.
  ///
  /// In es, this message translates to:
  /// **'Rating'**
  String get propRating;

  /// No description provided for @propCurve.
  ///
  /// In es, this message translates to:
  /// **'Curva'**
  String get propCurve;

  /// No description provided for @propPoles.
  ///
  /// In es, this message translates to:
  /// **'Polos'**
  String get propPoles;

  /// No description provided for @propBreakingCap.
  ///
  /// In es, this message translates to:
  /// **'Pdc'**
  String get propBreakingCap;

  /// No description provided for @propSensitivity.
  ///
  /// In es, this message translates to:
  /// **'Sensib.'**
  String get propSensitivity;

  /// No description provided for @propSection.
  ///
  /// In es, this message translates to:
  /// **'Sección'**
  String get propSection;

  /// No description provided for @propLength.
  ///
  /// In es, this message translates to:
  /// **'Longitud'**
  String get propLength;

  /// No description provided for @propMaterial.
  ///
  /// In es, this message translates to:
  /// **'Material'**
  String get propMaterial;

  /// No description provided for @propCalculateIcc.
  ///
  /// In es, this message translates to:
  /// **'Icc (calc)'**
  String get propCalculateIcc;

  /// No description provided for @propLoopImp.
  ///
  /// In es, this message translates to:
  /// **'Zs'**
  String get propLoopImp;

  /// No description provided for @propAdmissibleI.
  ///
  /// In es, this message translates to:
  /// **'Iz (cable)'**
  String get propAdmissibleI;

  /// No description provided for @circuitCalculation.
  ///
  /// In es, this message translates to:
  /// **'Configuración de Carga'**
  String get circuitCalculation;

  /// No description provided for @loadType.
  ///
  /// In es, this message translates to:
  /// **'Tipo de Carga'**
  String get loadType;

  /// No description provided for @lighting.
  ///
  /// In es, this message translates to:
  /// **'Iluminación'**
  String get lighting;

  /// No description provided for @power.
  ///
  /// In es, this message translates to:
  /// **'Potencia'**
  String get power;

  /// No description provided for @motor.
  ///
  /// In es, this message translates to:
  /// **'Motor'**
  String get motor;

  /// No description provided for @singlePhase.
  ///
  /// In es, this message translates to:
  /// **'Monofásico (230V)'**
  String get singlePhase;

  /// No description provided for @threePhase.
  ///
  /// In es, this message translates to:
  /// **'Trifásico (400V)'**
  String get threePhase;

  /// No description provided for @cableSection.
  ///
  /// In es, this message translates to:
  /// **'SECCIÓN DE CABLE'**
  String get cableSection;

  /// No description provided for @automaticOptimized.
  ///
  /// In es, this message translates to:
  /// **'AUTOMÁTICO (Optimizado)'**
  String get automaticOptimized;

  /// No description provided for @lineLength.
  ///
  /// In es, this message translates to:
  /// **'LONGITUD DE LÍNEA'**
  String get lineLength;

  /// No description provided for @installationMethod.
  ///
  /// In es, this message translates to:
  /// **'MÉTODO DE INSTALACIÓN'**
  String get installationMethod;

  /// No description provided for @validateDesign.
  ///
  /// In es, this message translates to:
  /// **'Guardar Configuración'**
  String get validateDesign;

  /// No description provided for @resultsEstimated.
  ///
  /// In es, this message translates to:
  /// **'Resultados (Estimado)'**
  String get resultsEstimated;

  /// No description provided for @notCompliant.
  ///
  /// In es, this message translates to:
  /// **'NO CUMPLE'**
  String get notCompliant;

  /// No description provided for @reset.
  ///
  /// In es, this message translates to:
  /// **'Restablecer'**
  String get reset;

  /// No description provided for @insulation.
  ///
  /// In es, this message translates to:
  /// **'Aislamiento'**
  String get insulation;

  /// No description provided for @configProtection.
  ///
  /// In es, this message translates to:
  /// **'Configurar Protección'**
  String get configProtection;

  /// No description provided for @presetProtection.
  ///
  /// In es, this message translates to:
  /// **'PROTECCIÓN PREDEFINIDA'**
  String get presetProtection;

  /// No description provided for @inputCable.
  ///
  /// In es, this message translates to:
  /// **'CABLE DE ALIMENTACIÓN'**
  String get inputCable;

  /// No description provided for @componentType.
  ///
  /// In es, this message translates to:
  /// **'TIPO DE COMPONENTE'**
  String get componentType;

  /// No description provided for @switchType.
  ///
  /// In es, this message translates to:
  /// **'Interruptor'**
  String get switchType;

  /// No description provided for @fuseType.
  ///
  /// In es, this message translates to:
  /// **'Fusible'**
  String get fuseType;

  /// No description provided for @saveProtection.
  ///
  /// In es, this message translates to:
  /// **'Guardar Protección'**
  String get saveProtection;

  /// No description provided for @cancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @calibre.
  ///
  /// In es, this message translates to:
  /// **'CALIBRE (A)'**
  String get calibre;

  /// No description provided for @poles.
  ///
  /// In es, this message translates to:
  /// **'Polos'**
  String get poles;

  /// No description provided for @curveLabel.
  ///
  /// In es, this message translates to:
  /// **'CURVA'**
  String get curveLabel;

  /// No description provided for @breakingCapacity.
  ///
  /// In es, this message translates to:
  /// **'Poder de Corte (kA)'**
  String get breakingCapacity;

  /// No description provided for @sensitivityLabel.
  ///
  /// In es, this message translates to:
  /// **'SENSIBILIDAD'**
  String get sensitivityLabel;

  /// No description provided for @standardHousing.
  ///
  /// In es, this message translates to:
  /// **'Clase AC (Estándar Vivienda)'**
  String get standardHousing;

  /// No description provided for @presetCustom.
  ///
  /// In es, this message translates to:
  /// **'Personalizada'**
  String get presetCustom;

  /// No description provided for @presetDefault.
  ///
  /// In es, this message translates to:
  /// **'Predefinida'**
  String get presetDefault;

  /// No description provided for @selectedElement.
  ///
  /// In es, this message translates to:
  /// **'Elemento Seleccionado'**
  String get selectedElement;

  /// No description provided for @fromLabel.
  ///
  /// In es, this message translates to:
  /// **'DESDE: '**
  String get fromLabel;

  /// No description provided for @singleLineDiagram.
  ///
  /// In es, this message translates to:
  /// **'Diagrama Unifilar'**
  String get singleLineDiagram;

  /// No description provided for @budgetComingSoon.
  ///
  /// In es, this message translates to:
  /// **'Presupuesto (Próximamente)'**
  String get budgetComingSoon;

  /// No description provided for @whatComponentMeasure.
  ///
  /// In es, this message translates to:
  /// **'¿Qué componente mediste?'**
  String get whatComponentMeasure;

  /// No description provided for @tapComponentMeasure.
  ///
  /// In es, this message translates to:
  /// **'Toca el componente en el diagrama para registrar su medición'**
  String get tapComponentMeasure;

  /// No description provided for @deleteNotImplemented.
  ///
  /// In es, this message translates to:
  /// **'Borrado no implementado'**
  String get deleteNotImplemented;

  /// No description provided for @editNotAvailable.
  ///
  /// In es, this message translates to:
  /// **'Edición no disponible'**
  String get editNotAvailable;

  /// No description provided for @acometida.
  ///
  /// In es, this message translates to:
  /// **'Acometida'**
  String get acometida;

  /// No description provided for @manual.
  ///
  /// In es, this message translates to:
  /// **'Manual'**
  String get manual;

  /// No description provided for @generalConfig.
  ///
  /// In es, this message translates to:
  /// **'Configuración General'**
  String get generalConfig;

  /// No description provided for @sensitivity.
  ///
  /// In es, this message translates to:
  /// **'Sensibilidad (mA)'**
  String get sensitivity;

  /// No description provided for @save.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get save;

  /// No description provided for @type.
  ///
  /// In es, this message translates to:
  /// **'Tipo'**
  String get type;

  /// No description provided for @circuitBreaker.
  ///
  /// In es, this message translates to:
  /// **'Interruptor Automático'**
  String get circuitBreaker;

  /// No description provided for @differential.
  ///
  /// In es, this message translates to:
  /// **'Diferencial'**
  String get differential;

  /// No description provided for @fuse.
  ///
  /// In es, this message translates to:
  /// **'Fusible'**
  String get fuse;

  /// No description provided for @ratingAmps.
  ///
  /// In es, this message translates to:
  /// **'Calibre (A)'**
  String get ratingAmps;

  /// No description provided for @curve.
  ///
  /// In es, this message translates to:
  /// **'Curva'**
  String get curve;

  /// No description provided for @cableMaterial.
  ///
  /// In es, this message translates to:
  /// **'Material del Cable'**
  String get cableMaterial;

  /// No description provided for @profileSetup.
  ///
  /// In es, this message translates to:
  /// **'Configurar Perfil'**
  String get profileSetup;

  /// No description provided for @profileSetupSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Toca editar para comenzar'**
  String get profileSetupSubtitle;

  /// No description provided for @profileNoName.
  ///
  /// In es, this message translates to:
  /// **'Sin nombre'**
  String get profileNoName;

  /// No description provided for @profileEngineerId.
  ///
  /// In es, this message translates to:
  /// **'ID Ingeniero no configurado'**
  String get profileEngineerId;

  /// No description provided for @professionalEngineer.
  ///
  /// In es, this message translates to:
  /// **'Ingeniero Técnico'**
  String get professionalEngineer;

  /// No description provided for @freelancer.
  ///
  /// In es, this message translates to:
  /// **'Autónomo'**
  String get freelancer;

  /// No description provided for @company.
  ///
  /// In es, this message translates to:
  /// **'Empresa'**
  String get company;

  /// No description provided for @editProfileTitle.
  ///
  /// In es, this message translates to:
  /// **'Editar Perfil'**
  String get editProfileTitle;

  /// No description provided for @personalData.
  ///
  /// In es, this message translates to:
  /// **'Datos Personales'**
  String get personalData;

  /// No description provided for @companyData.
  ///
  /// In es, this message translates to:
  /// **'Datos de Empresa'**
  String get companyData;

  /// No description provided for @freelancerLabel.
  ///
  /// In es, this message translates to:
  /// **'Autónomo'**
  String get freelancerLabel;

  /// No description provided for @companyLabel.
  ///
  /// In es, this message translates to:
  /// **'Empresa'**
  String get companyLabel;

  /// No description provided for @logoForPDFs.
  ///
  /// In es, this message translates to:
  /// **'Logo para PDFs'**
  String get logoForPDFs;

  /// No description provided for @tapToUpload.
  ///
  /// In es, this message translates to:
  /// **'Toca para subir'**
  String get tapToUpload;

  /// No description provided for @tapToChange.
  ///
  /// In es, this message translates to:
  /// **'Toca para cambiar'**
  String get tapToChange;

  /// No description provided for @fullNameLabel.
  ///
  /// In es, this message translates to:
  /// **'Nombre completo'**
  String get fullNameLabel;

  /// No description provided for @emailLabel.
  ///
  /// In es, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @phoneLabel.
  ///
  /// In es, this message translates to:
  /// **'Teléfono'**
  String get phoneLabel;

  /// No description provided for @dniLabel.
  ///
  /// In es, this message translates to:
  /// **'DNI/NIF'**
  String get dniLabel;

  /// No description provided for @engineerIdLabel.
  ///
  /// In es, this message translates to:
  /// **'ID Ingeniero'**
  String get engineerIdLabel;

  /// No description provided for @companyNameLabel.
  ///
  /// In es, this message translates to:
  /// **'Razón Social'**
  String get companyNameLabel;

  /// No description provided for @cifLabel.
  ///
  /// In es, this message translates to:
  /// **'CIF'**
  String get cifLabel;

  /// No description provided for @addressLabel.
  ///
  /// In es, this message translates to:
  /// **'Dirección'**
  String get addressLabel;

  /// No description provided for @companyEmailLabel.
  ///
  /// In es, this message translates to:
  /// **'Email Empresa'**
  String get companyEmailLabel;

  /// No description provided for @companyPhoneLabel.
  ///
  /// In es, this message translates to:
  /// **'Teléfono Empresa'**
  String get companyPhoneLabel;

  /// No description provided for @settingsTitle.
  ///
  /// In es, this message translates to:
  /// **'Ajustes'**
  String get settingsTitle;

  /// No description provided for @closeLabel.
  ///
  /// In es, this message translates to:
  /// **'Cerrar'**
  String get closeLabel;

  /// No description provided for @languageSpanish.
  ///
  /// In es, this message translates to:
  /// **'Español (España)'**
  String get languageSpanish;

  /// No description provided for @languageEnglish.
  ///
  /// In es, this message translates to:
  /// **'English (US)'**
  String get languageEnglish;

  /// No description provided for @notifications.
  ///
  /// In es, this message translates to:
  /// **'Notificaciones'**
  String get notifications;

  /// No description provided for @notificationsSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Alertas de normativa y proyectos'**
  String get notificationsSubtitle;

  /// No description provided for @accessibility.
  ///
  /// In es, this message translates to:
  /// **'ACCESIBILIDAD'**
  String get accessibility;

  /// No description provided for @highContrast.
  ///
  /// In es, this message translates to:
  /// **'Alto Contraste'**
  String get highContrast;

  /// No description provided for @highContrastSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Mejorar visibilidad en exteriores'**
  String get highContrastSubtitle;

  /// No description provided for @textSize.
  ///
  /// In es, this message translates to:
  /// **'Tamaño de Texto'**
  String get textSize;

  /// No description provided for @textSizeSmall.
  ///
  /// In es, this message translates to:
  /// **'Pequeño'**
  String get textSizeSmall;

  /// No description provided for @textSizeMedium.
  ///
  /// In es, this message translates to:
  /// **'Mediano'**
  String get textSizeMedium;

  /// No description provided for @textSizeLarge.
  ///
  /// In es, this message translates to:
  /// **'Grande'**
  String get textSizeLarge;

  /// No description provided for @textSizeExtraLarge.
  ///
  /// In es, this message translates to:
  /// **'Muy Grande'**
  String get textSizeExtraLarge;

  /// No description provided for @support.
  ///
  /// In es, this message translates to:
  /// **'SOPORTE'**
  String get support;

  /// No description provided for @helpAndFaq.
  ///
  /// In es, this message translates to:
  /// **'Ayuda y FAQ'**
  String get helpAndFaq;

  /// No description provided for @reportProblem.
  ///
  /// In es, this message translates to:
  /// **'Reportar Problema'**
  String get reportProblem;

  /// No description provided for @versionInfo.
  ///
  /// In es, this message translates to:
  /// **'Versión 2.4.1 (Build 2043)\\n© 2025 ElectricianApp Pro'**
  String get versionInfo;

  /// No description provided for @analyzingActively.
  ///
  /// In es, this message translates to:
  /// **'Analizando Activamente'**
  String get analyzingActively;

  /// No description provided for @projectElectric.
  ///
  /// In es, this message translates to:
  /// **'Proyecto Eléctrico'**
  String get projectElectric;

  /// No description provided for @healthScore.
  ///
  /// In es, this message translates to:
  /// **'Puntuación de Salud'**
  String get healthScore;

  /// No description provided for @complianceStatus.
  ///
  /// In es, this message translates to:
  /// **'Estado de Cumplimiento'**
  String get complianceStatus;

  /// No description provided for @safetyStatus.
  ///
  /// In es, this message translates to:
  /// **'Seguridad'**
  String get safetyStatus;

  /// No description provided for @efficiencyStatus.
  ///
  /// In es, this message translates to:
  /// **'Eficiencia'**
  String get efficiencyStatus;

  /// No description provided for @viewAll.
  ///
  /// In es, this message translates to:
  /// **'VER TODOS'**
  String get viewAll;

  /// No description provided for @exportReport.
  ///
  /// In es, this message translates to:
  /// **'Exportar Informe'**
  String get exportReport;

  /// No description provided for @quickActions.
  ///
  /// In es, this message translates to:
  /// **'Acciones Rápidas'**
  String get quickActions;

  /// No description provided for @fieldMeasurements.
  ///
  /// In es, this message translates to:
  /// **'Mediciones de Campo'**
  String get fieldMeasurements;

  /// No description provided for @protectionsOk.
  ///
  /// In es, this message translates to:
  /// **'Protecciones OK'**
  String get protectionsOk;

  /// No description provided for @reviewSections.
  ///
  /// In es, this message translates to:
  /// **'Revisar secciones'**
  String get reviewSections;

  /// No description provided for @components.
  ///
  /// In es, this message translates to:
  /// **'Componentes'**
  String get components;

  /// No description provided for @noComponentsInDiagram.
  ///
  /// In es, this message translates to:
  /// **'No hay componentes en el diagrama'**
  String get noComponentsInDiagram;

  /// No description provided for @projectConfigTitle.
  ///
  /// In es, this message translates to:
  /// **'Configuración del Proyecto'**
  String get projectConfigTitle;

  /// No description provided for @projectNameLabel.
  ///
  /// In es, this message translates to:
  /// **'Nombre del Proyecto'**
  String get projectNameLabel;

  /// No description provided for @internalReference.
  ///
  /// In es, this message translates to:
  /// **'Referencia Interna'**
  String get internalReference;

  /// No description provided for @ownerData.
  ///
  /// In es, this message translates to:
  /// **'Datos del Titular'**
  String get ownerData;

  /// No description provided for @ownerName.
  ///
  /// In es, this message translates to:
  /// **'Titular / Razón Social'**
  String get ownerName;

  /// No description provided for @ownerId.
  ///
  /// In es, this message translates to:
  /// **'NIF / CIF'**
  String get ownerId;

  /// No description provided for @regulationsAndCalculation.
  ///
  /// In es, this message translates to:
  /// **'Normativa y Cálculo'**
  String get regulationsAndCalculation;

  /// No description provided for @electricalRegulations.
  ///
  /// In es, this message translates to:
  /// **'Normativa Eléctrica'**
  String get electricalRegulations;

  /// No description provided for @installationUsage.
  ///
  /// In es, this message translates to:
  /// **'Uso de la Instalación'**
  String get installationUsage;

  /// No description provided for @requiresTechProject.
  ///
  /// In es, this message translates to:
  /// **'Requiere Proyecto Técnico'**
  String get requiresTechProject;

  /// No description provided for @projectSavedSuccess.
  ///
  /// In es, this message translates to:
  /// **'Proyecto guardado correctamente'**
  String get projectSavedSuccess;

  /// No description provided for @highContrastMode.
  ///
  /// In es, this message translates to:
  /// **'Modo Alto Contraste (Exterior)'**
  String get highContrastMode;

  /// No description provided for @ownerPhone.
  ///
  /// In es, this message translates to:
  /// **'Teléfono'**
  String get ownerPhone;

  /// No description provided for @ownerEmail.
  ///
  /// In es, this message translates to:
  /// **'Email del Titular'**
  String get ownerEmail;

  /// No description provided for @componentLibraryTitle.
  ///
  /// In es, this message translates to:
  /// **'Biblioteca de Componentes'**
  String get componentLibraryTitle;

  /// No description provided for @selectComponent.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar Componente'**
  String get selectComponent;

  /// No description provided for @filterProtection.
  ///
  /// In es, this message translates to:
  /// **'Protecciones'**
  String get filterProtection;

  /// No description provided for @filterCable.
  ///
  /// In es, this message translates to:
  /// **'Cables'**
  String get filterCable;

  /// No description provided for @filterSource.
  ///
  /// In es, this message translates to:
  /// **'Fuentes'**
  String get filterSource;

  /// No description provided for @searchComponents.
  ///
  /// In es, this message translates to:
  /// **'Buscar componentes...'**
  String get searchComponents;

  /// No description provided for @noComponentsFound.
  ///
  /// In es, this message translates to:
  /// **'No se encontraron componentes'**
  String get noComponentsFound;

  /// No description provided for @createFirstComponent.
  ///
  /// In es, this message translates to:
  /// **'Crea tu primer componente personalizado'**
  String get createFirstComponent;

  /// No description provided for @newComponent.
  ///
  /// In es, this message translates to:
  /// **'Nuevo Componente'**
  String get newComponent;

  /// No description provided for @componentDetail.
  ///
  /// In es, this message translates to:
  /// **'Detalle de Componente'**
  String get componentDetail;

  /// No description provided for @protectionSpecs.
  ///
  /// In es, this message translates to:
  /// **'ESPECIFICACIONES DE PROTECCIÓN'**
  String get protectionSpecs;

  /// No description provided for @cableSpecs.
  ///
  /// In es, this message translates to:
  /// **'ESPECIFICACIONES DE CABLE'**
  String get cableSpecs;

  /// No description provided for @sourceSpecs.
  ///
  /// In es, this message translates to:
  /// **'ESPECIFICACIONES DE FUENTE'**
  String get sourceSpecs;

  /// No description provided for @manufacturer.
  ///
  /// In es, this message translates to:
  /// **'Fabricante'**
  String get manufacturer;

  /// No description provided for @series.
  ///
  /// In es, this message translates to:
  /// **'Serie'**
  String get series;

  /// No description provided for @price.
  ///
  /// In es, this message translates to:
  /// **'Precio (€)'**
  String get price;

  /// No description provided for @ratedCurrent.
  ///
  /// In es, this message translates to:
  /// **'Corriente Nominal (A)'**
  String get ratedCurrent;

  /// No description provided for @deviceType.
  ///
  /// In es, this message translates to:
  /// **'Tipo de Dispositivo'**
  String get deviceType;

  /// No description provided for @material.
  ///
  /// In es, this message translates to:
  /// **'Material'**
  String get material;

  /// No description provided for @maxTemp.
  ///
  /// In es, this message translates to:
  /// **'Temp. Máx (°C)'**
  String get maxTemp;

  /// No description provided for @installMethod.
  ///
  /// In es, this message translates to:
  /// **'Método de Instalación'**
  String get installMethod;

  /// No description provided for @voltage.
  ///
  /// In es, this message translates to:
  /// **'Tensión (V)'**
  String get voltage;

  /// No description provided for @maxIcc.
  ///
  /// In es, this message translates to:
  /// **'Icc Máx (kA)'**
  String get maxIcc;

  /// No description provided for @saveComponent.
  ///
  /// In es, this message translates to:
  /// **'Guardar Componente'**
  String get saveComponent;

  /// No description provided for @fieldRequired.
  ///
  /// In es, this message translates to:
  /// **'Campo requerido'**
  String get fieldRequired;

  /// No description provided for @invalidNumber.
  ///
  /// In es, this message translates to:
  /// **'Número inválido'**
  String get invalidNumber;

  /// No description provided for @deleteComponent.
  ///
  /// In es, this message translates to:
  /// **'Eliminar Componente'**
  String get deleteComponent;

  /// No description provided for @confirmDeleteComponent.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de que deseas eliminar este componente?'**
  String get confirmDeleteComponent;

  /// No description provided for @retry.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get retry;

  /// No description provided for @deviceTypeCircuitBreaker.
  ///
  /// In es, this message translates to:
  /// **'Magnetotérmico'**
  String get deviceTypeCircuitBreaker;

  /// No description provided for @deviceTypeFuse.
  ///
  /// In es, this message translates to:
  /// **'Fusible'**
  String get deviceTypeFuse;

  /// No description provided for @cableMaterialCopper.
  ///
  /// In es, this message translates to:
  /// **'Cobre'**
  String get cableMaterialCopper;

  /// No description provided for @cableMaterialAluminum.
  ///
  /// In es, this message translates to:
  /// **'Aluminio'**
  String get cableMaterialAluminum;

  /// No description provided for @configuration.
  ///
  /// In es, this message translates to:
  /// **'Configuración'**
  String get configuration;

  /// No description provided for @betaWarningTitle.
  ///
  /// In es, this message translates to:
  /// **'Funcionalidad Beta'**
  String get betaWarningTitle;

  /// No description provided for @betaWarningMessage.
  ///
  /// In es, this message translates to:
  /// **'Esta característica está en desarrollo. Puede contener errores, funcionalidades incompletas o no terminadas.'**
  String get betaWarningMessage;

  /// No description provided for @back.
  ///
  /// In es, this message translates to:
  /// **'Atrás'**
  String get back;

  /// No description provided for @next.
  ///
  /// In es, this message translates to:
  /// **'Siguiente'**
  String get next;

  /// No description provided for @start.
  ///
  /// In es, this message translates to:
  /// **'Comenzar'**
  String get start;

  /// No description provided for @completeAllFields.
  ///
  /// In es, this message translates to:
  /// **'Por favor, completa todos los campos'**
  String get completeAllFields;

  /// No description provided for @modules.
  ///
  /// In es, this message translates to:
  /// **'Módulos'**
  String get modules;

  /// No description provided for @synchronized.
  ///
  /// In es, this message translates to:
  /// **'Sincronizado'**
  String get synchronized;

  /// No description provided for @activeAlerts.
  ///
  /// In es, this message translates to:
  /// **'{count} Alertas Activas'**
  String activeAlerts(int count);

  /// No description provided for @searchPlaceholderFull.
  ///
  /// In es, this message translates to:
  /// **'Buscar proyecto, norma o cálculo...'**
  String get searchPlaceholderFull;

  /// No description provided for @controlPanel.
  ///
  /// In es, this message translates to:
  /// **'Panel de Control'**
  String get controlPanel;

  /// No description provided for @delete.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get delete;

  /// No description provided for @projectPlaceholder.
  ///
  /// In es, this message translates to:
  /// **'Nave Industrial B'**
  String get projectPlaceholder;

  /// No description provided for @locationPlaceholder.
  ///
  /// In es, this message translates to:
  /// **'Cuadro General • Madrid'**
  String get locationPlaceholder;

  /// No description provided for @sheetLabel.
  ///
  /// In es, this message translates to:
  /// **'HOJA'**
  String get sheetLabel;

  /// No description provided for @pageCount.
  ///
  /// In es, this message translates to:
  /// **'1 de 1'**
  String get pageCount;

  /// No description provided for @user.
  ///
  /// In es, this message translates to:
  /// **'Usuario'**
  String get user;

  /// No description provided for @tapToStart.
  ///
  /// In es, this message translates to:
  /// **'Toca editar para comenzar'**
  String get tapToStart;

  /// No description provided for @unnamed.
  ///
  /// In es, this message translates to:
  /// **'Sin nombre'**
  String get unnamed;

  /// No description provided for @phone.
  ///
  /// In es, this message translates to:
  /// **'Teléfono'**
  String get phone;

  /// No description provided for @address.
  ///
  /// In es, this message translates to:
  /// **'Dirección'**
  String get address;

  /// No description provided for @theme.
  ///
  /// In es, this message translates to:
  /// **'Tema'**
  String get theme;

  /// No description provided for @notificationsDesc.
  ///
  /// In es, this message translates to:
  /// **'Alertas de normativa y proyectos'**
  String get notificationsDesc;

  /// No description provided for @brightnessBoost.
  ///
  /// In es, this message translates to:
  /// **'Mejorar visibilidad en exteriores'**
  String get brightnessBoost;

  /// No description provided for @themeLight.
  ///
  /// In es, this message translates to:
  /// **'Claro'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In es, this message translates to:
  /// **'Oscuro'**
  String get themeDark;

  /// No description provided for @themeAuto.
  ///
  /// In es, this message translates to:
  /// **'Automático'**
  String get themeAuto;

  /// No description provided for @selfConsumption.
  ///
  /// In es, this message translates to:
  /// **'Autoconsumo'**
  String get selfConsumption;

  /// No description provided for @modification.
  ///
  /// In es, this message translates to:
  /// **'Modificación'**
  String get modification;

  /// No description provided for @draft.
  ///
  /// In es, this message translates to:
  /// **'Borrador'**
  String get draft;

  /// No description provided for @interpretation.
  ///
  /// In es, this message translates to:
  /// **'Interpretación'**
  String get interpretation;

  /// No description provided for @settings.
  ///
  /// In es, this message translates to:
  /// **'Configuración'**
  String get settings;

  /// No description provided for @errorDeletingProject.
  ///
  /// In es, this message translates to:
  /// **'Error al eliminar el proyecto'**
  String get errorDeletingProject;

  /// No description provided for @projectDeletedSuccess.
  ///
  /// In es, this message translates to:
  /// **'Proyecto eliminado correctamente'**
  String get projectDeletedSuccess;

  /// No description provided for @housingType.
  ///
  /// In es, this message translates to:
  /// **'Vivienda'**
  String get housingType;

  /// No description provided for @industrialType.
  ///
  /// In es, this message translates to:
  /// **'Industrial'**
  String get industrialType;

  /// No description provided for @othersType.
  ///
  /// In es, this message translates to:
  /// **'Otros'**
  String get othersType;

  /// No description provided for @category.
  ///
  /// In es, this message translates to:
  /// **'Categoría'**
  String get category;

  /// No description provided for @specialistInstaller.
  ///
  /// In es, this message translates to:
  /// **'Instalador Especialista'**
  String get specialistInstaller;

  /// No description provided for @defaultRegulation.
  ///
  /// In es, this message translates to:
  /// **'Normativa por defecto'**
  String get defaultRegulation;

  /// No description provided for @regulationDesc.
  ///
  /// In es, this message translates to:
  /// **'Utilizada en cálculos automáticos'**
  String get regulationDesc;

  /// No description provided for @rebt2002.
  ///
  /// In es, this message translates to:
  /// **'REBT 2002'**
  String get rebt2002;

  /// No description provided for @quickSecureAccess.
  ///
  /// In es, this message translates to:
  /// **'Acceso rápido seguro'**
  String get quickSecureAccess;

  /// No description provided for @readyToStart.
  ///
  /// In es, this message translates to:
  /// **'Todo listo para empezar a usar la aplicación'**
  String get readyToStart;

  /// No description provided for @eliminateComponent.
  ///
  /// In es, this message translates to:
  /// **'Eliminar Componente'**
  String get eliminateComponent;

  /// No description provided for @initializing.
  ///
  /// In es, this message translates to:
  /// **'Inicializando...'**
  String get initializing;

  /// No description provided for @initializationError.
  ///
  /// In es, this message translates to:
  /// **'Error de Inicialización'**
  String get initializationError;

  /// No description provided for @unknownError.
  ///
  /// In es, this message translates to:
  /// **'Error inesperado durante la inicialización'**
  String get unknownError;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
