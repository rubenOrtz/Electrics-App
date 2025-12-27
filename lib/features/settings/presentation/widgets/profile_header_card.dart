import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/user_profile.dart';
import '../bloc/user_profile_cubit.dart';

/// Profile header card displaying user information with edit capability
class ProfileHeaderCard extends StatelessWidget {
  final VoidCallback onEditTap;

  const ProfileHeaderCard({
    super.key,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<UserProfileCubit, UserProfileState>(
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;
        final profile = state.profile;

        // Show loading state
        if (state.isLoading && profile == null) {
          return _buildLoadingCard(theme);
        }

        // Show empty/default state if no profile
        if (profile == null) {
          return _buildEmptyCard(theme, l10n, context);
        }

        return _buildProfileCard(theme, l10n, profile);
      },
    );
  }

  Widget _buildLoadingCard(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildEmptyCard(
      ThemeData theme, AppLocalizations l10n, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Default avatar
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.primaryColor.withValues(alpha: 0.1),
              border: Border.all(color: theme.primaryColor, width: 2),
            ),
            child: Icon(
              Icons.person,
              size: 40,
              color: theme.primaryColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Configurar Perfil',
                  style: TextStyle(
                    color: theme.textTheme.bodyLarge?.color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.tapToStart,
                  style: TextStyle(
                    color: theme.textTheme.bodyMedium?.color
                        ?.withValues(alpha: 0.7),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit, color: theme.colorScheme.primary),
            onPressed: onEditTap,
          )
        ],
      ),
    );
  }

  Widget _buildProfileCard(
      ThemeData theme, AppLocalizations l10n, UserProfile profile) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          _buildAvatar(theme, profile),
          const SizedBox(width: 16),
          // Profile info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.personalName.isNotEmpty
                      ? profile.personalName
                      : l10n.unnamed,
                  style: TextStyle(
                    color: theme.textTheme.bodyLarge?.color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  profile.engineerId.isNotEmpty
                      ? 'Ingeniero Técnico • ID: ${profile.engineerId}'
                      : 'ID Ingeniero no configurado',
                  style: TextStyle(
                    color: theme.textTheme.bodyMedium?.color
                        ?.withValues(alpha: 0.7),
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                // Professional type badge
                _buildProfessionalTypeBadge(theme, profile.professionalType),
              ],
            ),
          ),
          // Edit button
          IconButton(
            icon: Icon(Icons.edit,
                color: theme.colorScheme.primary), // Use colorScheme.primary
            onPressed: onEditTap,
          )
        ],
      ),
    );
  }

  Widget _buildAvatar(ThemeData theme, UserProfile profile) {
    if (profile.personalPhotoBytes != null &&
        profile.personalPhotoBytes!.isNotEmpty) {
      return Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: theme.primaryColor, width: 2),
          image: DecorationImage(
            image: MemoryImage(
              Uint8List.fromList(profile.personalPhotoBytes!),
            ),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      // Default avatar icon
      return Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.primaryColor.withValues(alpha: 0.1),
          border: Border.all(color: theme.primaryColor, width: 2),
        ),
        child: Icon(
          Icons.person,
          size: 40,
          color: theme.primaryColor,
        ),
      );
    }
  }

  Widget _buildProfessionalTypeBadge(ThemeData theme, ProfessionalType type) {
    final isCompany = type == ProfessionalType.company;
    final color = isCompany ? Colors.blue : Colors.green;
    final label = isCompany ? 'EMPRESA' : 'AUTÓNOMO';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
