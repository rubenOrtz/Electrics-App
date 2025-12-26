// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Electrician App';

  @override
  String get landingTitle => 'Electrician\nSuper-App';

  @override
  String get landingSubtitle =>
      'The ultimate tool for the professional on site.';

  @override
  String get landingFeatureUnified => 'Total Unification';

  @override
  String get landingFeatureUnifiedSub => 'Integrated calculation and design';

  @override
  String get landingFeatureEfficiency => 'Efficiency';

  @override
  String get landingFeatureEfficiencySub => 'Save time on site';

  @override
  String get landingFeatureRebt => 'REBT Compliance';

  @override
  String get landingFeatureRebtSub => 'Always up to date';

  @override
  String get createAccount => 'Create Account';

  @override
  String get login => 'Login';

  @override
  String get orContinueWith => 'Or continue with';

  @override
  String get registerTitle => 'Create Account';

  @override
  String get registerSubtitle =>
      'Access the definitive tool for electrical installers.';

  @override
  String get fullName => 'Full Name';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get acceptTerms => 'I accept the ';

  @override
  String get termsAndConditions => 'terms and conditions';

  @override
  String get andPrivacy => ' and privacy policy.';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get loginTitle => 'Welcome';

  @override
  String get loginSubtitle => 'Log in to continue with your projects.';

  @override
  String get forgotPassword => 'Forgot your password?';

  @override
  String get noAccount => 'Don\'t have an account? ';

  @override
  String get register => 'Register';

  @override
  String get navHome => 'Home';

  @override
  String get navCalculations => 'Calculations';

  @override
  String get navProjects => 'Projects';

  @override
  String get navProfile => 'Profile';

  @override
  String get homeWelcome => 'Welcome back!';

  @override
  String homeWelcomeUser(String name) {
    return 'Welcome, $name!';
  }

  @override
  String get homeGreetingMorning => 'Good morning';

  @override
  String get homeGreetingAfternoon => 'Good afternoon';

  @override
  String get homeGreetingEvening => 'Good evening';

  @override
  String get homeQuickAccess => 'Quick Access';

  @override
  String get homeComponentLibrary => 'Component Library';

  @override
  String get homeCalculators => 'Calculators';

  @override
  String get homeDocuments => 'Documents';

  @override
  String get homeRegulations => 'Regulations';

  @override
  String get projectsTitle => 'Projects';

  @override
  String get searchPlaceholder => 'Search address, client...';

  @override
  String get filterAll => 'All';

  @override
  String get filterDesign => 'In Design';

  @override
  String get filterPending => 'Pending Visa';

  @override
  String get filterFinished => 'Finished';

  @override
  String get clientLabel => 'Client: ';

  @override
  String get profileTitle => 'My Profile';

  @override
  String get editProfile => 'Edit';

  @override
  String get professionalData => 'Professional Data';

  @override
  String get contact => 'Contact';

  @override
  String get technicalConfig => 'Technical Config';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get emailHint => 'email@example.com';

  @override
  String get passwordHint => '••••••••';

  @override
  String get noAccountPrompt => 'Don\'t have an account?';

  @override
  String get logout => 'Logout';

  @override
  String get regulationsTitle => 'Regulations Library';

  @override
  String get searchRegulationsPlaceholder =>
      'Search regulations (e.g. ITC-BT-52)...';

  @override
  String get recentUpdates => 'RECENT UPDATES';

  @override
  String get mainCategories => 'Main Categories';

  @override
  String get categories => 'Categories';

  @override
  String get lowVoltage => 'Low Voltage';

  @override
  String get highVoltage => 'High Voltage';

  @override
  String get safety => 'Safety';

  @override
  String get technicalGuides => 'Technical Guides';

  @override
  String get helpTitle => 'Help & Support';

  @override
  String get searchHelp => 'Search doubts, errors, guides...';

  @override
  String get searchHelpPlaceholder => 'Search help...';

  @override
  String get helpTopics => 'Help Topics';

  @override
  String get contactSupport => 'Contact Support';

  @override
  String get selfHelpResources => 'Self Help Resources';

  @override
  String get autoHelpResources => 'SELF HELP RESOURCES';

  @override
  String get faq => 'FAQ';

  @override
  String get userGuides => 'User Guides';

  @override
  String get videoTutorials => 'Video Tutorials';

  @override
  String get contactSupportBtn => 'CONTACT TECH SUPPORT';

  @override
  String get liveChat => 'Live Chat';

  @override
  String get sendEmail => 'Send Email';

  @override
  String get callSupport => 'Call Support';

  @override
  String get toolsTitle => 'Calculation Tools';

  @override
  String get toolEvCharger => 'EV Charger';

  @override
  String get toolEvChargerSub => 'Section calculation per ITC-BT-52';

  @override
  String get toolVoltageDrop => 'Voltage Drop';

  @override
  String get toolVoltageDropSub => 'Generic section calculation by v.d.';

  @override
  String get toolTubeDim => 'Tube Sizing';

  @override
  String get toolTubeDimSub => 'Based on number and section of conductors';

  @override
  String get calculationsTitle => 'Calculation Tools';

  @override
  String get cableCalculations => 'Cables and Conductors';

  @override
  String get ampacity => 'Ampacity';

  @override
  String get ampacityDesc => 'Current capacity based on installation type.';

  @override
  String get conduitSize => 'Tube Sizing';

  @override
  String get conduitSizeDesc => 'Diameter of tubes and conduits.';

  @override
  String get installations => 'Installations';

  @override
  String get chargingStation => 'EV Charging Point';

  @override
  String get chargingStationDesc => 'Calculator for vehicle charging points.';

  @override
  String get capacitorBank => 'Capacitor Bank';

  @override
  String get capacitorBankDesc => 'Reactive energy compensation.';

  @override
  String get costs => 'Costs and Budgets';

  @override
  String get budgetEstimator => 'Budget Estimator';

  @override
  String get budgetEstimatorDesc => 'Quick generation of approximate budgets.';

  @override
  String get evChargerTitle => 'EV Charger';

  @override
  String get housing => 'Housing';

  @override
  String get garage => 'Comm. Garage';

  @override
  String get publicWay => 'Public Way';

  @override
  String get chargingPointData => 'Charging Point Data';

  @override
  String get installationScheme => 'Installation Scheme (ITC-BT-52)';

  @override
  String get powerKw => 'Power (kW)';

  @override
  String get lengthM => 'Length (m)';

  @override
  String get cableType => 'CABLE TYPE';

  @override
  String get installationSystem => 'Installation System';

  @override
  String get calculateSection => 'Calculate Section';

  @override
  String get calculationResult => 'Calculation Result';

  @override
  String get section => 'Section (mm²)';

  @override
  String get voltageDrop => 'Voltage Drop';

  @override
  String get voltageDropDesc => 'Voltage drop calculation in conductors.';

  @override
  String get protection => 'Protection';

  @override
  String get configTitle => 'Project Config';

  @override
  String get generalInfo => 'GENERAL INFORMATION';

  @override
  String get projectName => 'Project Name';

  @override
  String get internalRef => 'Internal Reference';

  @override
  String get location => 'Location';

  @override
  String get holderData => 'Holder Data';

  @override
  String get holderName => 'Holder / Company Name';

  @override
  String get nifCif => 'Tax ID';

  @override
  String get electricalParams => 'Electrical Parameters';

  @override
  String get supplyVoltage => 'Supply Voltage';

  @override
  String get installationUse => 'Installation Use';

  @override
  String get expectedPower => 'Expected Power (kW)';

  @override
  String get corporateEmail => 'Corporate Email';

  @override
  String get mobilePhone => 'Mobile Phone';

  @override
  String get powerFactor => 'Power Factor';

  @override
  String get requiresProject => 'Requires Technical Project';

  @override
  String get newLinkInstallation => 'New Link Installation';

  @override
  String get saveAndContinue => 'Save and Continue';

  @override
  String get docGenTitle => 'Generate Documentation';

  @override
  String get docSelection => 'DOCUMENT SELECTION';

  @override
  String get techMemory => 'Technical Memory';

  @override
  String get singleLinePlan => 'Single Line Plan';

  @override
  String get installCert => 'Installation Certificate';

  @override
  String get userManual => 'User Manual';

  @override
  String get designCategory => 'Design & Plans';

  @override
  String get singleLineTool => 'Single Line Schema Editor';

  @override
  String get singleLineToolDesc => 'Visual design of panels and circuits.';

  @override
  String get exportOptions => 'EXPORT OPTIONS';

  @override
  String get format => 'Format';

  @override
  String get language => 'Language';

  @override
  String get includeDigitalSig => 'Include Digital Signature';

  @override
  String get generateDownload => 'Generate and Download';

  @override
  String get diagramTitle => 'Single Line Diagram';

  @override
  String get properties => 'Properties';

  @override
  String get element => 'Element';

  @override
  String get reference => 'Reference';

  @override
  String get intensity => 'Intensity';

  @override
  String get pole => 'Pole';

  @override
  String get editDetail => 'Edit Detail';

  @override
  String get settingsGeneral => 'GENERAL';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsNotificationsSub => 'Regulations and project alerts';

  @override
  String get settingsAccessibility => 'ACCESSIBILITY (SITE)';

  @override
  String get settingsHighContrast => 'High Contrast';

  @override
  String get settingsHighContrastSub => 'Improve outdoor visibility';

  @override
  String get settingsTextSize => 'Text Size';

  @override
  String get settingsIdentity => 'ACCOUNT & SECURITY';

  @override
  String get settingsPassword => 'Password';

  @override
  String get settingsPrivacy => 'Privacy & Data';

  @override
  String get settingsSupport => 'SUPPORT';

  @override
  String get settingsHelp => 'Help';

  @override
  String get settingsReport => 'Report Issue';

  @override
  String get settingsPlanPro => 'Pro Plan Active';

  @override
  String get settingsPlanBasic => 'Basic Plan';

  @override
  String get settingsSignOut => 'Sign Out';

  @override
  String get comingSoonTitle => 'Coming Soon';

  @override
  String get comingSoonMessage =>
      'This feature will be available soon, we are actively working on it.';

  @override
  String featureUnderDevelopment(Object feature) {
    return 'The functionality $feature will be available soon, we are actively working on it.';
  }

  @override
  String get close => 'Close';

  @override
  String get componentConfig => 'Component Configuration';

  @override
  String get measurementsRegistered => 'Registered Measurements';

  @override
  String get noMeasurements => 'No measurements registered';

  @override
  String get noProperties => 'No properties configured';

  @override
  String get sourceInput => 'Source / Supply';

  @override
  String get panel => 'Electrical Panel';

  @override
  String get loadCircuit => 'Load / Circuit';

  @override
  String get measurementSource => 'Source Measurement';

  @override
  String get measurementRcd => 'RCD Test';

  @override
  String get measurementInsulation => 'Insulation Resistance';

  @override
  String get measurementLoad => 'Load Measurement (Zs)';

  @override
  String get measurementPanel => 'Earth Resistance';

  @override
  String get measurementGeneric => 'General Measurement';

  @override
  String get voltageLN => 'Voltage L-N';

  @override
  String get voltageLL => 'Voltage L-L';

  @override
  String get frequency => 'Frequency';

  @override
  String get externalZe => 'External Ze';

  @override
  String get tripTime => 'Trip Time';

  @override
  String get tripCurrent => 'Trip Current';

  @override
  String get contactVoltage => 'Contact Voltage';

  @override
  String get mechanicalTest => 'Mechanical Test (T Button)';

  @override
  String get passed => 'PASSED';

  @override
  String get failed => 'FAILED';

  @override
  String get phaseEarthR => 'R Phase-Earth';

  @override
  String get phaseNeutralR => 'R Phase-Neutral';

  @override
  String get continuityPE => 'PE Continuity';

  @override
  String get yes => 'YES';

  @override
  String get no => 'NO';

  @override
  String get loopImpedance => 'Loop Impedance (Zs)';

  @override
  String get voltageLoad => 'Load Voltage';

  @override
  String get polarity => 'Polarity';

  @override
  String get correct => 'CORRECT';

  @override
  String get incorrect => 'INCORRECT';

  @override
  String get earthResistance => 'Earth Resistance (Ra)';

  @override
  String get notes => 'Notes';

  @override
  String get maintenanceTitle => 'Maintenance & Diagnosis';

  @override
  String get activeInspection => 'ACTIVE INSPECTION';

  @override
  String get scanEquipment => 'Scan\nEquipment';

  @override
  String get manualEntry => 'Manual Entry';

  @override
  String get security => 'SECURITY';

  @override
  String get regulationsRebt => 'REGULATIONS';

  @override
  String get verifications => 'VERIFICATIONS';

  @override
  String get warnings => 'Warnings';

  @override
  String get compliant => 'COMPLIANT';

  @override
  String get failures => 'Failures';

  @override
  String get resultsAndTips => 'Results and Tips';

  @override
  String get insightsCount => 'insights';

  @override
  String get noProblemsDetected => 'No problems detected';

  @override
  String get scanFeatureComingSoon => 'QR/NFC scanning feature coming soon';

  @override
  String get measurementSaved => 'Measurement saved';

  @override
  String get securityCritical => 'Critical';

  @override
  String get securityLow => 'Low';

  @override
  String get securityMedium => 'Medium';

  @override
  String get securityHigh => 'High';

  @override
  String get installationState => 'Installation Status';

  @override
  String get viewScheme => 'VIEW SCHEME';

  @override
  String calculatedOnComponents(Object count) {
    return 'Calculated on $count components';
  }

  @override
  String get insightCritical => 'CRITICAL';

  @override
  String get insightNormative => 'REGULATIONS';

  @override
  String get paletteProtections => 'Protections';

  @override
  String get paletteWiring => 'Wiring';

  @override
  String get paletteReceivers => 'Receivers';

  @override
  String get paletteMeasurement => 'Measure';

  @override
  String get elemGrid => 'Grid';

  @override
  String get elemBreaker => 'Breaker';

  @override
  String get elemDifferential => 'RCD';

  @override
  String get elemLoad => 'Load';

  @override
  String get elemSubpanel => 'Subpanel';

  @override
  String get elemCable => 'Cable';

  @override
  String get elemJunction => 'Junction';

  @override
  String get propVoltage => 'Voltage';

  @override
  String get propCurrent => 'Current';

  @override
  String get propDrop => 'Drop';

  @override
  String get propPower => 'Power';

  @override
  String get propCosPhi => 'cos φ';

  @override
  String get propDesignCurrent => 'Ib (design)';

  @override
  String get propVoltageNode => 'V (node)';

  @override
  String get propDropVolts => 'ΔU';

  @override
  String get propIcc => 'ICC';

  @override
  String get propRating => 'Rating';

  @override
  String get propCurve => 'Curve';

  @override
  String get propPoles => 'Poles';

  @override
  String get propBreakingCap => 'Pdc';

  @override
  String get propSensitivity => 'Sensitivity';

  @override
  String get propSection => 'Section';

  @override
  String get propLength => 'Length';

  @override
  String get propMaterial => 'Material';

  @override
  String get propCalculateIcc => 'Icc (calc)';

  @override
  String get propLoopImp => 'Zs';

  @override
  String get propAdmissibleI => 'Iz (cable)';

  @override
  String get circuitCalculation => 'Load Configuration';

  @override
  String get loadType => 'Load Type';

  @override
  String get lighting => 'Lighting';

  @override
  String get power => 'Power';

  @override
  String get motor => 'Motor';

  @override
  String get singlePhase => 'Single Phase (230V)';

  @override
  String get threePhase => 'Three Phase (400V)';

  @override
  String get cableSection => 'CABLE SECTION';

  @override
  String get automaticOptimized => 'AUTOMATIC (Optimized)';

  @override
  String get lineLength => 'LINE LENGTH';

  @override
  String get installationMethod => 'INSTALLATION METHOD';

  @override
  String get validateDesign => 'Save Configuration';

  @override
  String get resultsEstimated => 'Results (Estimated)';

  @override
  String get notCompliant => 'NOT COMPLIANT';

  @override
  String get reset => 'Reset';

  @override
  String get insulation => 'Insulation';

  @override
  String get configProtection => 'Configure Protection';

  @override
  String get presetProtection => 'PRESET PROTECTION';

  @override
  String get inputCable => 'FEEDER CABLE';

  @override
  String get componentType => 'COMPONENT TYPE';

  @override
  String get switchType => 'Switch';

  @override
  String get fuseType => 'Fuse';

  @override
  String get saveProtection => 'Save Protection';

  @override
  String get cancel => 'Cancel';

  @override
  String get calibre => 'RATING (A)';

  @override
  String get poles => 'Poles';

  @override
  String get curveLabel => 'CURVE';

  @override
  String get breakingCapacity => 'Breaking Capacity (kA)';

  @override
  String get sensitivityLabel => 'SENSITIVITY';

  @override
  String get standardHousing => 'Class AC (Standard Housing)';

  @override
  String get presetCustom => 'Custom';

  @override
  String get presetDefault => 'Preset';

  @override
  String get selectedElement => 'Selected Element';

  @override
  String get fromLabel => 'FROM: ';

  @override
  String get singleLineDiagram => 'Single Line Diagram';

  @override
  String get budgetComingSoon => 'Budget (Coming Soon)';

  @override
  String get whatComponentMeasure => 'What component did you measure?';

  @override
  String get tapComponentMeasure =>
      'Tap the component in the diagram to register its measurement';

  @override
  String get deleteNotImplemented => 'Delete not implemented';

  @override
  String get editNotAvailable => 'Edit not available';

  @override
  String get acometida => 'Supply';

  @override
  String get manual => 'Manual';

  @override
  String get generalConfig => 'General Configuration';

  @override
  String get sensitivity => 'Sensitivity (mA)';

  @override
  String get save => 'Save';

  @override
  String get type => 'Type';

  @override
  String get circuitBreaker => 'Circuit Breaker';

  @override
  String get differential => 'Differential';

  @override
  String get fuse => 'Fuse';

  @override
  String get ratingAmps => 'Rating (A)';

  @override
  String get curve => 'Curve';

  @override
  String get cableMaterial => 'Cable Material';

  @override
  String get profileSetup => 'Setup Profile';

  @override
  String get profileSetupSubtitle => 'Tap edit to begin';

  @override
  String get profileNoName => 'No name';

  @override
  String get profileEngineerId => 'Engineer ID not set';

  @override
  String get professionalEngineer => 'Technical Engineer';

  @override
  String get freelancer => 'Freelancer';

  @override
  String get company => 'Company';

  @override
  String get editProfileTitle => 'Edit Profile';

  @override
  String get personalData => 'Personal Data';

  @override
  String get companyData => 'Company Data';

  @override
  String get freelancerLabel => 'Freelancer';

  @override
  String get companyLabel => 'Company';

  @override
  String get logoForPDFs => 'Logo for PDFs';

  @override
  String get tapToUpload => 'Tap to upload';

  @override
  String get tapToChange => 'Tap to change';

  @override
  String get fullNameLabel => 'Full name';

  @override
  String get emailLabel => 'Email';

  @override
  String get phoneLabel => 'Phone';

  @override
  String get dniLabel => 'Tax ID / SSN';

  @override
  String get engineerIdLabel => 'Engineer ID';

  @override
  String get companyNameLabel => 'Company Name';

  @override
  String get cifLabel => 'Tax ID';

  @override
  String get addressLabel => 'Address';

  @override
  String get companyEmailLabel => 'Company Email';

  @override
  String get companyPhoneLabel => 'Company Phone';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get closeLabel => 'Close';

  @override
  String get languageSpanish => 'Español (España)';

  @override
  String get languageEnglish => 'English (US)';

  @override
  String get notifications => 'Notifications';

  @override
  String get notificationsSubtitle => 'Regulation and project alerts';

  @override
  String get accessibility => 'ACCESSIBILITY';

  @override
  String get highContrast => 'High Contrast';

  @override
  String get highContrastSubtitle => 'Improve outdoor visibility';

  @override
  String get textSize => 'Text Size';

  @override
  String get textSizeSmall => 'Small';

  @override
  String get textSizeMedium => 'Medium';

  @override
  String get textSizeLarge => 'Large';

  @override
  String get textSizeExtraLarge => 'Extra Large';

  @override
  String get support => 'SUPPORT';

  @override
  String get helpAndFaq => 'Help & FAQ';

  @override
  String get reportProblem => 'Report Problem';

  @override
  String get versionInfo =>
      'Version 2.4.1 (Build 2043)\\n© 2025 ElectricianApp Pro';

  @override
  String get analyzingActively => 'Actively Analyzing';

  @override
  String get projectElectric => 'Electric Project';

  @override
  String get healthScore => 'Health Score';

  @override
  String get complianceStatus => 'Compliance Status';

  @override
  String get safetyStatus => 'Safety';

  @override
  String get efficiencyStatus => 'Efficiency';

  @override
  String get viewAll => 'VIEW ALL';

  @override
  String get exportReport => 'Export Report';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get fieldMeasurements => 'Field Measurements';

  @override
  String get protectionsOk => 'Protections OK';

  @override
  String get reviewSections => 'Review sections';

  @override
  String get components => 'Components';

  @override
  String get noComponentsInDiagram => 'No components in diagram';

  @override
  String get projectConfigTitle => 'Project Configuration';

  @override
  String get projectNameLabel => 'Project Name';

  @override
  String get internalReference => 'Internal Reference';

  @override
  String get ownerData => 'Owner Data';

  @override
  String get ownerName => 'Owner / Company Name';

  @override
  String get ownerId => 'Tax ID';

  @override
  String get regulationsAndCalculation => 'Regulations & Calculation';

  @override
  String get electricalRegulations => 'Electrical Regulations';

  @override
  String get installationUsage => 'Installation Usage';

  @override
  String get requiresTechProject => 'Requires Technical Project';

  @override
  String get projectSavedSuccess => 'Project saved successfully';

  @override
  String get highContrastMode => 'High Contrast Mode (Outdoor)';

  @override
  String get ownerPhone => 'Phone';

  @override
  String get ownerEmail => 'Owner Email';

  @override
  String get componentLibraryTitle => 'Component Library';

  @override
  String get selectComponent => 'Select Component';

  @override
  String get filterProtection => 'Protections';

  @override
  String get filterCable => 'Cables';

  @override
  String get filterSource => 'Sources';

  @override
  String get searchComponents => 'Search components...';

  @override
  String get noComponentsFound => 'No components found';

  @override
  String get createFirstComponent => 'Create your first custom component';

  @override
  String get newComponent => 'New Component';

  @override
  String get componentDetail => 'Component Detail';

  @override
  String get protectionSpecs => 'PROTECTION SPECS';

  @override
  String get cableSpecs => 'CABLE SPECS';

  @override
  String get sourceSpecs => 'SOURCE SPECS';

  @override
  String get manufacturer => 'Manufacturer';

  @override
  String get series => 'Series';

  @override
  String get price => 'Price (€)';

  @override
  String get ratedCurrent => 'Rated Current (A)';

  @override
  String get deviceType => 'Device Type';

  @override
  String get material => 'Material';

  @override
  String get maxTemp => 'Max Temp (°C)';

  @override
  String get installMethod => 'Installation Method';

  @override
  String get voltage => 'Voltage (V)';

  @override
  String get maxIcc => 'Max Icc (kA)';

  @override
  String get saveComponent => 'Save Component';

  @override
  String get fieldRequired => 'Field required';

  @override
  String get invalidNumber => 'Invalid number';

  @override
  String get deleteComponent => 'Delete Component';

  @override
  String get confirmDeleteComponent =>
      'Are you sure you want to delete this component?';

  @override
  String get retry => 'Retry';

  @override
  String get deviceTypeCircuitBreaker => 'Circuit Breaker';

  @override
  String get deviceTypeFuse => 'Fuse';

  @override
  String get cableMaterialCopper => 'Copper';

  @override
  String get cableMaterialAluminum => 'Aluminum';

  @override
  String get configuration => 'Configuration';

  @override
  String get betaWarningTitle => 'Beta Feature';

  @override
  String get betaWarningMessage =>
      'This feature is under development. It may contain errors, incomplete functionality or is not finished.';

  @override
  String get back => 'Back';

  @override
  String get next => 'Next';

  @override
  String get start => 'Start';

  @override
  String get completeAllFields => 'Please complete all fields';

  @override
  String get modules => 'Modules';

  @override
  String get synchronized => 'Synchronized';

  @override
  String activeAlerts(int count) {
    return '$count Active Alerts';
  }

  @override
  String get searchPlaceholderFull =>
      'Search project, regulation or calculation...';

  @override
  String get controlPanel => 'Control Panel';

  @override
  String get delete => 'Delete';

  @override
  String get projectPlaceholder => 'Industrial Warehouse B';

  @override
  String get locationPlaceholder => 'Main Panel • Madrid';

  @override
  String get sheetLabel => 'SHEET';

  @override
  String get pageCount => '1 of 1';

  @override
  String get user => 'User';

  @override
  String get tapToStart => 'Tap edit to get started';

  @override
  String get unnamed => 'Unnamed';

  @override
  String get phone => 'Phone';

  @override
  String get address => 'Address';

  @override
  String get theme => 'Theme';

  @override
  String get notificationsDesc => 'Regulation and project alerts';

  @override
  String get brightnessBoost => 'Improve outdoor visibility';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeAuto => 'Automatic';

  @override
  String get selfConsumption => 'Self-consumption';

  @override
  String get modification => 'Modification';

  @override
  String get draft => 'Draft';

  @override
  String get interpretation => 'Interpretation';

  @override
  String get settings => 'Settings';

  @override
  String get errorDeletingProject => 'Error deleting project';

  @override
  String get projectDeletedSuccess => 'Project deleted successfully';

  @override
  String get housingType => 'Housing';

  @override
  String get industrialType => 'Industrial';

  @override
  String get othersType => 'Others';

  @override
  String get category => 'Category';

  @override
  String get specialistInstaller => 'Specialist Installer';

  @override
  String get defaultRegulation => 'Default Regulation';

  @override
  String get regulationDesc => 'Used in automatic calculations';

  @override
  String get rebt2002 => 'REBT 2002';

  @override
  String get quickSecureAccess => 'Quick secure access';

  @override
  String get readyToStart => 'Ready to start using the application';

  @override
  String get eliminateComponent => 'Remove Component';

  @override
  String get initializing => 'Initializing...';

  @override
  String get initializationError => 'Initialization Error';

  @override
  String get unknownError => 'Unexpected error during initialization';
}
