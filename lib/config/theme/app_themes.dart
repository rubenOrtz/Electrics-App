import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ============================================================================
// COLOR DEFINITIONS
// ============================================================================

// Primary Accent
const Color kPrimaryColor = Color(0xFF135BEC);
const Color kPrimaryHighContrast = Color(0xFF135BEC);

// Light Mode Colors
const Color kBackgroundLight = Color(0xFFF8FAFC);
const Color kSurfaceLight = Color(0xFFFFFFFF);
const Color kBorderLight = Color(0xFFE2E8F0);
const Color kTextPrimaryLight = Color(0xFF0F172A);
const Color kTextSecondaryLight = Color(0xFF64748B);

// Dark Mode Colors
const Color kBackgroundDark = Color(0xFF0F172A);
const Color kSurfaceDark = Color(0xFF1A2436);
const Color kSurfaceElevatedDark = Color(0xFF2D3748);
const Color kBorderDark = Color(0xFF334155);
const Color kTextPrimaryDark = Color(0xFFFFFFFF);
const Color kTextSecondaryDark = Color(0xFF94A3B8);

// High Contrast Light Colors
const Color kBackgroundLightHC = Color(0xFFF5F5F5);
const Color kSurfaceLightHC = Color(0xFFFFFFFF);
const Color kBorderLightHC = Color(0xFFBDBDBD);
const Color kTextPrimaryLightHC = Color(0xFF000000);
const Color kTextSecondaryLightHC = Color(0xFF000000);

// High Contrast Dark Colors
const Color kBackgroundDarkHC = Color(0xFF000000);
const Color kSurfaceDarkHC = Color(0xFF000000);
const Color kBorderDarkHC = Color(0xFFFFFFFF);
const Color kTextPrimaryDarkHC = Color(0xFFFFFFFF);
const Color kTextSecondaryDarkHC = Color(0xFFFFFFFF);

// Legacy (for compatibility)
const Color kTextPrimary = kTextPrimaryLight;
const Color kTextSecondary = kTextSecondaryLight;

// ============================================================================
// LIGHT THEME
// ============================================================================

ThemeData theme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: kBackgroundLight,
    fontFamily: GoogleFonts.notoSans().fontFamily,
    primaryColor: kPrimaryColor,
    colorScheme: const ColorScheme.light(
      primary: kPrimaryColor,
      surface: kSurfaceLight,
      onPrimary: Colors.white,
      onSurface: kTextPrimaryLight,
      // Fix: Distinct background for inputs
      surfaceContainerHighest: Color(0xFFF1F5F9), // Slate-100
      onSurfaceVariant: Color(0xFF64748B), // Slate-500
      // Fix: Project Icons Background
      primaryContainer: Color(0xFFD6E3FF),
      onPrimaryContainer: Color(0xFF001B3D),
    ),
    appBarTheme: appBarTheme(),
    inputDecorationTheme: inputDecorationTheme(
      fillColor: kSurfaceLight,
      borderColor: kBorderLight,
      focusColor: kPrimaryColor,
    ),
    textTheme: textTheme(),
    dividerColor: kBorderLight,
    extensions: <ThemeExtension<dynamic>>[
      DiagramTheme(
        canvasBg: const Color(0xFFF3F4F6),
        panelBg: kSurfaceLight,
        gridLine: Colors.black.withValues(alpha: 0.05),
        nodeBg: kSurfaceLight,
        nodeBorder: const Color(0xFF94A3B8),
        textColor: kTextPrimaryLight,
        accentColor: kPrimaryColor,
        isDark: false,
      ),
    ],
  );
}

// ============================================================================
// DARK THEME
// ============================================================================

ThemeData darkTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: kBackgroundDark,
    fontFamily: GoogleFonts.notoSans().fontFamily,
    primaryColor: kPrimaryColor,
    colorScheme: const ColorScheme.dark(
      primary: kPrimaryColor,
      surface: kSurfaceDark,
      onPrimary: Colors.white,
      onSurface: kTextPrimaryDark,
      // Fix: Distinct background for inputs in Dark Mode
      surfaceContainerHighest: kSurfaceElevatedDark,
      onSurfaceVariant: Color(0xFF94A3B8), // Slate-400
      // Fix: Project Icons Background (Dark Blue)
      primaryContainer: Color(0xFF00468C),
      onPrimaryContainer: Color(0xFFD6E3FF),
    ),
    appBarTheme: appBarTheme().copyWith(
      backgroundColor: Colors.transparent,
      iconTheme: const IconThemeData(color: kTextPrimaryDark),
      titleTextStyle: GoogleFonts.spaceGrotesk(
          color: kTextPrimaryDark, fontSize: 18, fontWeight: FontWeight.bold),
    ),
    cardColor: kSurfaceDark,
    inputDecorationTheme: inputDecorationTheme(
      fillColor: kSurfaceElevatedDark, // Correct dark fill
      borderColor: kBorderDark,
      focusColor: kPrimaryColor,
    ),
    textTheme: textTheme().apply(
      bodyColor: kTextPrimaryDark,
      displayColor: kTextPrimaryDark,
    ),
    dividerColor: kBorderDark,
    extensions: <ThemeExtension<dynamic>>[
      DiagramTheme(
        canvasBg: const Color(0xFF111827),
        panelBg: kSurfaceDark,
        gridLine: Colors.white.withValues(alpha: 0.05),
        nodeBg: kSurfaceElevatedDark,
        nodeBorder: kBorderDark,
        textColor: kTextPrimaryDark,
        accentColor: kPrimaryColor,
        isDark: true,
      ),
    ],
  );
}

// ============================================================================
// DYNAMIC THEMES (Material You)
// ============================================================================

ThemeData dynamicLightTheme(ColorScheme? lightColorScheme) {
  final baseScheme =
      lightColorScheme ?? const ColorScheme.light(primary: kPrimaryColor);

  return ThemeData(
    useMaterial3: true,
    colorScheme: baseScheme,
    scaffoldBackgroundColor: baseScheme.surface,
    fontFamily: GoogleFonts.notoSans().fontFamily,
    appBarTheme: appBarTheme().copyWith(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: baseScheme.onSurface),
      titleTextStyle: GoogleFonts.spaceGrotesk(
          color: baseScheme.onSurface,
          fontSize: 18,
          fontWeight: FontWeight.bold),
    ),
    inputDecorationTheme: inputDecorationTheme(
      fillColor: baseScheme.surfaceContainerHigh,
      borderColor: baseScheme.outline,
      focusColor: baseScheme.primary,
    ),
    textTheme: textTheme().apply(
      bodyColor: baseScheme.onSurface,
      displayColor: baseScheme.onSurface,
    ),
    extensions: <ThemeExtension<dynamic>>[
      DiagramTheme(
        canvasBg: baseScheme.surfaceContainerLowest,
        panelBg: baseScheme.surface,
        gridLine: baseScheme.onSurface.withValues(alpha: 0.05),
        nodeBg: baseScheme.surfaceContainerHigh,
        nodeBorder: baseScheme.outline,
        textColor: baseScheme.onSurface,
        accentColor: baseScheme.primary,
        isDark: false,
      ),
    ],
  );
}

ThemeData dynamicDarkTheme(ColorScheme? darkColorScheme) {
  final baseScheme =
      darkColorScheme ?? const ColorScheme.dark(primary: kPrimaryColor);

  return ThemeData(
    useMaterial3: true,
    colorScheme: baseScheme,
    scaffoldBackgroundColor: baseScheme.surface,
    fontFamily: GoogleFonts.notoSans().fontFamily,
    brightness: Brightness.dark,
    appBarTheme: appBarTheme().copyWith(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: baseScheme.onSurface),
      titleTextStyle: GoogleFonts.spaceGrotesk(
          color: baseScheme.onSurface,
          fontSize: 18,
          fontWeight: FontWeight.bold),
    ),
    inputDecorationTheme: inputDecorationTheme(
      fillColor:
          baseScheme.surfaceContainerHigh, // Adapts to dynamic dark surface
      borderColor: baseScheme.outline,
      focusColor: baseScheme.primary,
    ),
    textTheme: textTheme().apply(
      bodyColor: baseScheme.onSurface,
      displayColor: baseScheme.onSurface,
    ),
    extensions: <ThemeExtension<dynamic>>[
      DiagramTheme(
        canvasBg: baseScheme.surfaceContainerLowest,
        panelBg: baseScheme.surfaceContainerLow,
        gridLine: baseScheme.onSurface.withValues(alpha: 0.05),
        nodeBg: baseScheme.surfaceContainerHigh,
        nodeBorder: baseScheme.outline,
        textColor: baseScheme.onSurface,
        accentColor: baseScheme.primary,
        isDark: true,
      ),
    ],
  );
}

// ... (appBarTheme and inputDecorationTheme unchanged) ...

TextTheme textTheme() {
  final displayFont = GoogleFonts.spaceGrotesk;
  final bodyFont = GoogleFonts.notoSans;

  return TextTheme(
    // Headlines - M3 Expressive
    displayLarge: displayFont(
        fontSize: 57, fontWeight: FontWeight.normal, color: kTextPrimaryLight),
    displayMedium: displayFont(
        fontSize: 45, fontWeight: FontWeight.normal, color: kTextPrimaryLight),
    displaySmall: displayFont(
        fontSize: 36, fontWeight: FontWeight.normal, color: kTextPrimaryLight),

    headlineLarge: displayFont(
        fontSize: 32, fontWeight: FontWeight.bold, color: kTextPrimaryLight),
    headlineMedium: displayFont(
        fontSize: 28, fontWeight: FontWeight.bold, color: kTextPrimaryLight),
    headlineSmall: displayFont(
        fontSize: 24, fontWeight: FontWeight.bold, color: kTextPrimaryLight),

    // Titles - M3 Expressive
    titleLarge: bodyFont(
        fontSize: 22, fontWeight: FontWeight.w600, color: kTextPrimaryLight),
    titleMedium: bodyFont(
        fontSize: 16, fontWeight: FontWeight.w600, color: kTextPrimaryLight),
    titleSmall: bodyFont(
        fontSize: 14, fontWeight: FontWeight.w600, color: kTextPrimaryLight),

    // Body Text - M3 Expressive
    bodyLarge: bodyFont(fontSize: 16, color: kTextPrimaryLight),
    bodyMedium: bodyFont(fontSize: 14, color: kTextSecondaryLight),
    bodySmall: bodyFont(fontSize: 12, color: kTextSecondaryLight),

    // Labels - M3 Expressive
    labelLarge: bodyFont(
        fontSize: 14, fontWeight: FontWeight.bold, color: kTextPrimaryLight),
    labelMedium: bodyFont(
        fontSize: 12, fontWeight: FontWeight.w600, color: kTextPrimaryLight),
    labelSmall: bodyFont(
        fontSize: 11, fontWeight: FontWeight.normal, color: kTextPrimaryLight),
  );
}

// ============================================================================
// HIGH CONTRAST LIGHT THEME
// ============================================================================

ThemeData highContrastLightTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: kBackgroundLightHC,
    fontFamily: GoogleFonts.notoSans().fontFamily,
    primaryColor: kPrimaryColor,
    colorScheme: const ColorScheme.light(
      primary: kPrimaryColor,
      surface: kSurfaceLightHC,
      onPrimary: Colors.white,
      onSurface: kTextPrimaryLightHC,
      surfaceContainerHighest: Color(0xFFE0E0E0),
      onSurfaceVariant: Colors.black,
      primaryContainer: Color(0xFF0000FF), // Pure Blue for Max Contrast
      onPrimaryContainer: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: kSurfaceLightHC,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: kTextPrimaryLightHC, size: 28),
      titleTextStyle: GoogleFonts.spaceGrotesk(
        color: kTextPrimaryLightHC,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      toolbarHeight: 64,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(kPrimaryColor),
      trackColor: WidgetStateProperty.all(kBorderLightHC),
      materialTapTargetSize: MaterialTapTargetSize.padded,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: kSurfaceLightHC,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kBorderLightHC, width: 5),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kPrimaryColor, width: 6),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: kBorderLightHC, width: 3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    textTheme: textTheme().apply(
      bodyColor: kTextPrimaryLightHC,
      displayColor: kTextPrimaryLightHC,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: const Size(88, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: kBorderLightHC, width: 4),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: kPrimaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        minimumSize: const Size(64, 52),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: kTextPrimaryLightHC,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: const Size(88, 56),
        side: const BorderSide(color: kBorderLightHC, width: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
      iconSize: 32,
      sizeConstraints: BoxConstraints.tightFor(width: 68, height: 68),
    ),
    iconTheme: const IconThemeData(color: kTextPrimaryLightHC, size: 28),
    dividerColor: kBorderLightHC,
    dividerTheme:
        const DividerThemeData(color: kBorderLightHC, thickness: 2, space: 32),
    cardTheme: CardThemeData(
      color: kSurfaceLightHC,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: kBorderLightHC, width: 5),
      ),
      margin: const EdgeInsets.all(12),
    ),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      minLeadingWidth: 64,
      minVerticalPadding: 16,
      iconColor: kPrimaryColor,
      textColor: kTextPrimaryLightHC,
    ),
    extensions: <ThemeExtension<dynamic>>[
      DiagramTheme(
        canvasBg: const Color(0xFFFAFAFA),
        panelBg: kSurfaceLightHC,
        gridLine: Colors.black.withValues(alpha: 0.20),
        nodeBg: kSurfaceLightHC,
        nodeBorder: kBorderLightHC,
        textColor: kTextPrimaryLightHC,
        accentColor: kPrimaryColor,
        isDark: false,
      ),
    ],
  );
}

// ============================================================================
// HIGH CONTRAST DARK THEME
// ============================================================================

ThemeData highContrastDarkTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: kBackgroundDarkHC,
    fontFamily: GoogleFonts.notoSans().fontFamily,
    primaryColor: kPrimaryHighContrast,
    colorScheme: const ColorScheme.dark(
      primary: kPrimaryHighContrast,
      surface: kSurfaceDarkHC,
      onPrimary: Colors.black,
      onSurface: kTextPrimaryDarkHC,
      surfaceContainerHighest: Color(0xFF303030),
      onSurfaceVariant: Colors.white,
      primaryContainer:
          Color(0xFF82B1FF), // Light Blue for contrast against dark
      onPrimaryContainer: Colors.black,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: kBackgroundDarkHC,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: kPrimaryHighContrast, size: 28),
      titleTextStyle: GoogleFonts.spaceGrotesk(
        color: kPrimaryHighContrast,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      toolbarHeight: 64,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(kPrimaryHighContrast),
      trackColor: WidgetStateProperty.all(Colors.grey),
      materialTapTargetSize: MaterialTapTargetSize.padded,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: kBackgroundDarkHC,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kBorderDarkHC, width: 3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kPrimaryHighContrast, width: 4),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: kBorderDarkHC, width: 3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    textTheme: textTheme().apply(
      bodyColor: kTextPrimaryDarkHC,
      displayColor: kTextPrimaryDarkHC,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryHighContrast,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: const Size(88, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: kBorderDarkHC, width: 4),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: kPrimaryHighContrast,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        minimumSize: const Size(64, 52),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: kPrimaryHighContrast,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: const Size(88, 56),
        side: const BorderSide(color: kBorderDarkHC, width: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: kPrimaryHighContrast,
      foregroundColor: Colors.black,
      iconSize: 32,
      sizeConstraints: BoxConstraints.tightFor(width: 68, height: 68),
    ),
    iconTheme: const IconThemeData(
      color: kTextPrimaryDarkHC,
      size: 28,
    ),
    dividerColor: kBorderDarkHC,
    dividerTheme: const DividerThemeData(
      color: kBorderDarkHC,
      thickness: 2,
      space: 32,
    ),
    cardTheme: CardThemeData(
      color: kSurfaceDarkHC,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: kBorderDarkHC, width: 5),
      ),
      margin: const EdgeInsets.all(12),
    ),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      minLeadingWidth: 64,
      minVerticalPadding: 16,
      iconColor: kPrimaryHighContrast,
      textColor: kTextPrimaryDarkHC,
    ),
    extensions: <ThemeExtension<dynamic>>[
      DiagramTheme(
        canvasBg: kBackgroundDarkHC,
        panelBg: kSurfaceDarkHC,
        gridLine: Colors.white.withValues(alpha: 0.25),
        nodeBg: kSurfaceDarkHC,
        nodeBorder: kBorderDarkHC,
        textColor: kTextPrimaryDarkHC,
        accentColor: kPrimaryHighContrast,
        isDark: true,
      ),
    ],
  );
}

// ============================================================================
// HELPER FUNCTIONS
// ============================================================================

AppBarTheme appBarTheme() {
  return AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    iconTheme: const IconThemeData(color: kTextPrimaryLight),
    titleTextStyle: GoogleFonts.spaceGrotesk(
      color: kTextPrimaryLight,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  );
}

InputDecorationTheme inputDecorationTheme(
    {required Color fillColor,
    required Color borderColor,
    required Color focusColor}) {
  OutlineInputBorder outlineInputBorder(Color border) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: border),
    );
  }

  return InputDecorationTheme(
    filled: true,
    fillColor: fillColor,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    enabledBorder: outlineInputBorder(borderColor),
    focusedBorder: outlineInputBorder(focusColor),
    border: outlineInputBorder(borderColor),
    hintStyle: GoogleFonts.notoSans(
        color: borderColor.withValues(alpha: 0.7)), // Adaptive hint color
  );
}

// ============================================================================
// DIAGRAM THEME EXTENSION
// ============================================================================

@immutable
class DiagramTheme extends ThemeExtension<DiagramTheme> {
  final Color canvasBg;
  final Color panelBg;
  final Color gridLine;
  final Color nodeBg;
  final Color nodeBorder;
  final Color textColor;
  final Color accentColor;
  final bool isDark;

  const DiagramTheme({
    required this.canvasBg,
    required this.panelBg,
    required this.gridLine,
    required this.nodeBg,
    required this.nodeBorder,
    required this.textColor,
    required this.accentColor,
    required this.isDark,
  });

  @override
  DiagramTheme copyWith({
    Color? canvasBg,
    Color? panelBg,
    Color? gridLine,
    Color? nodeBg,
    Color? nodeBorder,
    Color? textColor,
    Color? accentColor,
    bool? isDark,
  }) {
    return DiagramTheme(
      canvasBg: canvasBg ?? this.canvasBg,
      panelBg: panelBg ?? this.panelBg,
      gridLine: gridLine ?? this.gridLine,
      nodeBg: nodeBg ?? this.nodeBg,
      nodeBorder: nodeBorder ?? this.nodeBorder,
      textColor: textColor ?? this.textColor,
      accentColor: accentColor ?? this.accentColor,
      isDark: isDark ?? this.isDark,
    );
  }

  @override
  DiagramTheme lerp(ThemeExtension<DiagramTheme>? other, double t) {
    if (other is! DiagramTheme) {
      return this;
    }
    return DiagramTheme(
      canvasBg: Color.lerp(canvasBg, other.canvasBg, t)!,
      panelBg: Color.lerp(panelBg, other.panelBg, t)!,
      gridLine: Color.lerp(gridLine, other.gridLine, t)!,
      nodeBg: Color.lerp(nodeBg, other.nodeBg, t)!,
      nodeBorder: Color.lerp(nodeBorder, other.nodeBorder, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      accentColor: Color.lerp(accentColor, other.accentColor, t)!,
      isDark: other.isDark,
    );
  }
}
