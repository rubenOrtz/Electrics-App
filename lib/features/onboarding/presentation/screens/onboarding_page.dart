import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electrician_app/l10n/app_localizations.dart';
import 'package:electrician_app/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:electrician_app/core/presentation/bloc/app_state_cubit.dart';
import 'package:electrician_app/core/navigation/navigation.dart';
import 'package:electrician_app/features/onboarding/presentation/widgets/personal_info_step.dart';
import 'package:electrician_app/features/onboarding/presentation/widgets/professional_type_step.dart';
import 'package:electrician_app/features/onboarding/presentation/widgets/company_info_step.dart';
import 'package:electrician_app/features/onboarding/presentation/widgets/preferences_step.dart';
import 'package:electrician_app/features/onboarding/presentation/screens/welcome_intro_screen.dart';

import 'package:electrician_app/features/onboarding/presentation/widgets/welcome_step.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  // We use this local state to show the intro screen first
  bool _showIntro = true;

  @override
  Widget build(BuildContext context) {
    if (_showIntro) {
      return WelcomeIntroScreen(
        onStart: () => setState(() => _showIntro = false),
      );
    }

    return Scaffold(
      body: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          final currentStepIndex = state.currentStep;
          final totalSteps = state.totalSteps;

          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    children: [
                      if (currentStepIndex > 0)
                        IconButton(
                          onPressed: () =>
                              context.read<OnboardingCubit>().previousStep(),
                          icon: const Icon(Icons.arrow_back_rounded),
                          tooltip: AppLocalizations.of(context)!.back,
                        )
                      else
                        IconButton(
                          onPressed: () => setState(() => _showIntro = true),
                          icon: const Icon(Icons.close_rounded),
                          tooltip: 'Salir',
                        ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: TweenAnimationBuilder<double>(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            tween: Tween<double>(
                                begin: 0,
                                end: (currentStepIndex + 1) / totalSteps),
                            builder: (context, value, _) =>
                                LinearProgressIndicator(
                              value: value,
                              minHeight: 8,
                              backgroundColor: Theme.of(context)
                                  .disabledColor
                                  .withValues(alpha: 0.1),
                              valueColor: AlwaysStoppedAnimation(
                                  Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "${currentStepIndex + 1}/$totalSteps",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).disabledColor,
                            ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.05, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: KeyedSubtree(
                      key: ValueKey(currentStepIndex),
                      child: _buildCurrentStep(state),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: state.isLoading
                              ? null
                              : () => _handleNext(context, state),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: state.isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Colors.white,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _isLastStep(state)
                                          ? AppLocalizations.of(context)!
                                              .start
                                              .toUpperCase()
                                          : AppLocalizations.of(context)!
                                              .next
                                              .toUpperCase(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.0),
                                    ),
                                    if (!_isLastStep(state)) ...[
                                      const SizedBox(width: 8),
                                      const Icon(Icons.arrow_forward_rounded,
                                          size: 20),
                                    ]
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCurrentStep(OnboardingState state) {
    final config = state.stepConfigs[state.currentStep];

    switch (config) {
      case OnboardingStepConfig.personalInfo:
        return const PersonalInfoStep();
      case OnboardingStepConfig.professionalType:
        return const ProfessionalTypeStep();
      case OnboardingStepConfig.companyInfo:
        return const CompanyInfoStep();
      case OnboardingStepConfig.preferences:
        return const PreferencesStep();
      case OnboardingStepConfig.welcome:
        return const WelcomeStep();
    }
  }

  bool _isLastStep(OnboardingState state) {
    return state.currentStep == state.totalSteps - 1;
  }

  void _handleNext(BuildContext context, OnboardingState state) async {
    final cubit = context.read<OnboardingCubit>();

    if (_isLastStep(state)) {
      final success = await cubit.completeOnboarding();
      if (success && context.mounted) {
        context.read<AppStateCubit>().completeOnboarding();
        navigationService.navigateToAndClearStack('/dashboard');
      }
    } else {
      if (_canProceed(state)) {
        cubit.nextStep();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white),
                const SizedBox(width: 8),
                Text(AppLocalizations.of(context)!.completeAllFields),
              ],
            ),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    }
  }

  bool _canProceed(OnboardingState state) {
    final config = state.stepConfigs[state.currentStep];

    switch (config) {
      case OnboardingStepConfig.personalInfo:
        return state.isPersonalInfoComplete;
      case OnboardingStepConfig.professionalType:
        return true;
      case OnboardingStepConfig.companyInfo:
        return state.isCompanyInfoComplete;
      case OnboardingStepConfig.preferences:
      case OnboardingStepConfig.welcome:
        return true;
    }
  }
}
