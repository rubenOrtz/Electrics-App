import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/onboarding_cubit.dart';
import '../../../settings/domain/entities/user_profile.dart';

class ProfessionalTypeStep extends StatelessWidget {
  const ProfessionalTypeStep({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tipo Profesional',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '¿Eres autónomo o representas a una empresa?',
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),
          Expanded(
            child: BlocBuilder<OnboardingCubit, OnboardingState>(
              builder: (context, state) {
                return ListView(
                  children: [
                    _buildTypeCard(
                      context,
                      type: ProfessionalType.freelancer,
                      title: 'Autónomo',
                      description: 'Trabajo por cuenta propia',
                      icon: Icons.person_outline,
                      isSelected:
                          state.professionalType == ProfessionalType.freelancer,
                    ),
                    const SizedBox(height: 16),
                    _buildTypeCard(
                      context,
                      type: ProfessionalType.company,
                      title: 'Empresa',
                      description: 'Represento a una empresa',
                      icon: Icons.business_outlined,
                      isSelected:
                          state.professionalType == ProfessionalType.company,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeCard(
    BuildContext context, {
    required ProfessionalType type,
    required String title,
    required String description,
    required IconData icon,
    required bool isSelected,
  }) {
    final theme = Theme.of(context);

    // Use subtler colors for better adaptation to light/dark modes
    final borderColor =
        isSelected ? theme.colorScheme.primary : theme.colorScheme.outline;
    final backgroundColor = isSelected
        ? theme.colorScheme.primary.withValues(alpha: 0.08)
        : Colors.transparent;
    final iconColor =
        isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface;
    final textColor =
        isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface;

    return InkWell(
      onTap: () {
        context.read<OnboardingCubit>().updateProfessionalType(type);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 40,
              color: iconColor,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: theme.colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }
}
