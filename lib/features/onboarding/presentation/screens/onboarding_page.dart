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
import 'package:electrician_app/features/onboarding/presentation/widgets/welcome_step.dart';
import 'package:electrician_app/features/settings/domain/entities/user_profile.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          return Column(
            children: [
              // Progress indicator
              LinearProgressIndicator(
                value: (state.currentStep + 1) / state.totalSteps,
              ),

              // Content
              Expanded(
                child: IndexedStack(
                  index: state.currentStep,
                  children: _buildSteps(state),
                ),
              ),

              // Navigation buttons
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: _buildNavigationButtons(context, state),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildSteps(OnboardingState state) {
    final steps = <Widget>[
      const PersonalInfoStep(),
      const ProfessionalTypeStep(),
    ];

    if (state.professionalType == ProfessionalType.company) {
      steps.add(const CompanyInfoStep());
    }

    steps.addAll([
      const PreferencesStep(),
      const WelcomeStep(),
    ]);

    return steps;
  }

  Widget _buildNavigationButtons(BuildContext context, OnboardingState state) {
    final cubit = context.read<OnboardingCubit>();
    final isLastStep = state.currentStep == state.totalSteps - 1;

    return Row(
      children: [
        if (state.currentStep > 0)
          TextButton(
            onPressed: cubit.previousStep,
            child: Text(AppLocalizations.of(context)!.back),
          ),
        const Spacer(),
        FilledButton(
          onPressed: state.isLoading
              ? null
              : () async {
                  if (isLastStep) {
                    // Complete onboarding
                    final success = await cubit.completeOnboarding();
                    if (success && context.mounted) {
                      // Mark onboarding complete in app state
                      context.read<AppStateCubit>().completeOnboarding();
                      // Navigate to dashboard
                      navigationService.navigateToAndClearStack('/dashboard');
                    }
                  } else {
                    // Validate current step before proceeding
                    if (_canProceed(state)) {
                      cubit.nextStep();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              AppLocalizations.of(context)!.completeAllFields),
                        ),
                      );
                    }
                  }
                },
          child: state.isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(isLastStep
                  ? AppLocalizations.of(context)!.start
                  : AppLocalizations.of(context)!.next),
        ),
      ],
    );
  }

  bool _canProceed(OnboardingState state) {
    switch (state.currentStep) {
      case 0: // Personal info
        return state.isPersonalInfoComplete;
      case 1: // Professional type
        return true; // Always can proceed from this step
      case 2: // Company info (if company) or Preferences (if freelancer)
        if (state.professionalType == ProfessionalType.company) {
          return state.isCompanyInfoComplete;
        }
        return true; // Preferences are optional
      default:
        return true;
    }
  }
}
