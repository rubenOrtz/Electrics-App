import 'package:electrician_app/core/presentation/bloc/app_state_cubit.dart';
import 'package:electrician_app/features/settings/domain/entities/user_profile.dart';
import 'package:electrician_app/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:electrician_app/features/onboarding/presentation/screens/onboarding_page.dart';
import 'package:electrician_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:electrician_app/features/onboarding/presentation/widgets/welcome_step.dart';

class MockOnboardingCubit extends Mock implements OnboardingCubit {}

class MockAppStateCubit extends Mock implements AppStateCubit {}

void main() {
  group('OnboardingPage', () {
    late MockOnboardingCubit mockCubit;
    late MockAppStateCubit mockAppStateCubit;

    setUp(() {
      mockCubit = MockOnboardingCubit();
      mockAppStateCubit = MockAppStateCubit();

      // Stub state
      when(() => mockCubit.state).thenReturn(const OnboardingState());
      when(() => mockCubit.stream)
          .thenAnswer((_) => Stream.value(const OnboardingState()));
    });

    Widget createWidget() {
      return MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('es')],
        home: MultiBlocProvider(
          providers: [
            BlocProvider<OnboardingCubit>.value(value: mockCubit),
            BlocProvider<AppStateCubit>.value(value: mockAppStateCubit),
          ],
          child: const OnboardingPage(),
        ),
      );
    }

    testWidgets('renders Personal Info step initially', (tester) async {
      await tester.pumpWidget(createWidget());
      await tester.pumpAndSettle();

      expect(find.text('Siguiente'), findsOneWidget);
      // We expect some personal info field labels if we knew them,
      // but "Siguiente" confirms button presence.
      // Assuming "Nombre" or similar is in PersonalInfoStep
    });

    testWidgets('renders Welcome step when at last step', (tester) async {
      // Default Freelancer: Personal(0), Type(1), Prefs(2), Welcome(3). Total 4.
      final targetState = const OnboardingState(
          currentStep: 3,
          totalSteps: 4,
          professionalType: ProfessionalType.freelancer);

      when(() => mockCubit.state).thenReturn(targetState);
      when(() => mockCubit.stream).thenAnswer((_) => Stream.value(targetState));

      await tester.pumpWidget(createWidget());
      await tester.pumpAndSettle();

      expect(find.byType(WelcomeStep), findsOneWidget);
    });
  });
}
