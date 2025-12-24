import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/user_profile.dart';
import '../bloc/user_profile_cubit.dart';

/// Bottom sheet for editing user profile
class EditProfileSheet extends StatefulWidget {
  const EditProfileSheet({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const EditProfileSheet(),
    );
  }

  @override
  State<EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<EditProfileSheet> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _dniController;
  late TextEditingController _engineerIdController;
  late TextEditingController _companyNameController;
  late TextEditingController _companyCifController;
  late TextEditingController _companyAddressController;
  late TextEditingController _companyEmailController;
  late TextEditingController _companyPhoneController;

  final _imagePicker = ImagePicker();

  // Local state for professional type to avoid premature updates
  late ProfessionalType _selectedProfessionalType;

  @override
  void initState() {
    super.initState();
    final profile = context.read<UserProfileCubit>().state.profile;

    // Initialize local state
    _selectedProfessionalType =
        profile?.professionalType ?? ProfessionalType.freelancer;

    _nameController = TextEditingController(text: profile?.personalName ?? '');
    _emailController =
        TextEditingController(text: profile?.personalEmail ?? '');
    _phoneController =
        TextEditingController(text: profile?.personalPhone ?? '');
    _dniController = TextEditingController(text: profile?.personalDni ?? '');
    _engineerIdController =
        TextEditingController(text: profile?.engineerId ?? '');
    _companyNameController =
        TextEditingController(text: profile?.companyName ?? '');
    _companyCifController =
        TextEditingController(text: profile?.companyCif ?? '');
    _companyAddressController =
        TextEditingController(text: profile?.companyAddress ?? '');
    _companyEmailController =
        TextEditingController(text: profile?.companyEmail ?? '');
    _companyPhoneController =
        TextEditingController(text: profile?.companyPhone ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dniController.dispose();
    _engineerIdController.dispose();
    _companyNameController.dispose();
    _companyCifController.dispose();
    _companyAddressController.dispose();
    _companyEmailController.dispose();
    _companyPhoneController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );

    if (image != null) {
      final bytes = await image.readAsBytes();
      if (mounted) {
        context.read<UserProfileCubit>().uploadPhoto(bytes);
      }
    }
  }

  Future<void> _pickLogo() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 90,
    );

    if (image != null) {
      final bytes = await image.readAsBytes();
      if (mounted) {
        context.read<UserProfileCubit>().uploadLogo(bytes);
      }
    }
  }

  void _saveProfile() {
    final cubit = context.read<UserProfileCubit>();
    final currentProfile = cubit.state.profile;

    if (currentProfile == null) return;

    final updatedProfile = currentProfile.copyWith(
      personalName: _nameController.text,
      personalEmail: _emailController.text,
      personalPhone: _phoneController.text,
      personalDni: _dniController.text,
      engineerId: _engineerIdController.text,
      companyName: _companyNameController.text,
      companyCif: _companyCifController.text,
      companyAddress: _companyAddressController.text,
      companyEmail: _companyEmailController.text,
      companyPhone: _companyPhoneController.text,
      professionalType: _selectedProfessionalType,
    );

    cubit.updateProfile(updatedProfile);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return BlocBuilder<UserProfileCubit, UserProfileState>(
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;
        final profile = state.profile;
        if (profile == null) {
          return const SizedBox();
        }

        return Container(
          height: mediaQuery.size.height * 0.9,
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Header
              _buildHeader(theme),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Photo and Logo section side by side
                      _buildMediaSection(theme, l10n, profile),
                      const SizedBox(height: 24),

                      // Professional type toggle
                      _buildProfessionalTypeToggle(theme, l10n),
                      const SizedBox(height: 24),

                      // Personal data
                      _buildSectionTitle('Datos Personales', theme),
                      const SizedBox(height: 16),
                      _buildTextField(l10n.fullName, _nameController, theme,
                          icon: Icons.person),
                      const SizedBox(height: 12),
                      _buildTextField(l10n.email, _emailController, theme,
                          keyboardType: TextInputType.emailAddress,
                          icon: Icons.email),
                      const SizedBox(height: 12),
                      _buildTextField(l10n.phone, _phoneController, theme,
                          keyboardType: TextInputType.phone, icon: Icons.phone),
                      const SizedBox(height: 12),
                      _buildTextField('DNI/NIF', _dniController, theme,
                          icon: Icons.badge),
                      const SizedBox(height: 12),
                      _buildTextField(
                          'ID Ingeniero', _engineerIdController, theme,
                          icon: Icons.engineering),

                      // Company data (only if company type)
                      if (_selectedProfessionalType ==
                          ProfessionalType.company) ...[
                        const SizedBox(height: 24),
                        _buildSectionTitle('Datos de Empresa', theme),
                        const SizedBox(height: 16),
                        _buildTextField(
                            'Razón Social', _companyNameController, theme,
                            icon: Icons.business),
                        const SizedBox(height: 12),
                        _buildTextField('CIF', _companyCifController, theme,
                            icon: Icons.numbers),
                        const SizedBox(height: 12),
                        _buildTextField(
                            l10n.address, _companyAddressController, theme,
                            icon: Icons.location_on),
                        const SizedBox(height: 12),
                        _buildTextField(
                            'Email Empresa', _companyEmailController, theme,
                            keyboardType: TextInputType.emailAddress,
                            icon: Icons.alternate_email),
                        const SizedBox(height: 12),
                        _buildTextField(
                            'Teléfono Empresa', _companyPhoneController, theme,
                            keyboardType: TextInputType.phone,
                            icon: Icons.phone_in_talk),
                      ],

                      const SizedBox(height: 32),
                      // Save button
                      _buildSaveButton(theme, state),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: 8),
          Text(
            'Editar Perfil',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaSection(
      ThemeData theme, AppLocalizations l10n, UserProfile profile) {
    return Row(
      children: [
        // Photo upload
        Expanded(
          child: _buildMediaCard(
            theme: theme,
            title: 'Foto Personal',
            subtitle: profile.personalPhotoBytes != null
                ? l10n.tapToChange
                : l10n.tapToUpload,
            imageBytes: profile.personalPhotoBytes,
            onTap: _pickPhoto,
            isCircle: true,
            icon: Icons.person,
          ),
        ),
        const SizedBox(width: 16),
        // Logo upload
        Expanded(
          child: _buildMediaCard(
            theme: theme,
            title: 'Logo PDFs',
            subtitle: profile.companyLogoBytes != null
                ? l10n.tapToChange
                : l10n.tapToUpload,
            imageBytes: profile.companyLogoBytes,
            onTap: _pickLogo,
            isCircle: false,
            icon: Icons.business,
          ),
        ),
      ],
    );
  }

  Widget _buildMediaCard({
    required ThemeData theme,
    required String title,
    required String subtitle,
    required List<int>? imageBytes,
    required VoidCallback onTap,
    required bool isCircle,
    required IconData icon,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.cardColor,
          border: Border.all(color: theme.dividerColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                borderRadius: isCircle ? null : BorderRadius.circular(8),
                color: theme.primaryColor.withValues(alpha: 0.1),
                border: Border.all(color: theme.primaryColor, width: 2),
                image: imageBytes != null
                    ? DecorationImage(
                        image: MemoryImage(Uint8List.fromList(imageBytes)),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: imageBytes == null
                  ? Icon(icon, size: 40, color: theme.primaryColor)
                  : null,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: theme.textTheme.bodyLarge?.color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 11,
                color:
                    theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfessionalTypeToggle(ThemeData theme, AppLocalizations l10n) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: _buildTypeOption(
              theme,
              l10n.freelancer,
              Icons.person,
              ProfessionalType.freelancer,
              _selectedProfessionalType,
            ),
          ),
          Expanded(
            child: _buildTypeOption(
              theme,
              l10n.company,
              Icons.business,
              ProfessionalType.company,
              _selectedProfessionalType,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeOption(
    ThemeData theme,
    String label,
    IconData icon,
    ProfessionalType type,
    ProfessionalType currentType,
  ) {
    final isSelected = type == currentType;

    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          setState(() {
            _selectedProfessionalType = type;
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? theme.primaryColor : theme.cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: theme.primaryColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected
                  ? Colors.white
                  : theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.6),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : theme.textTheme.bodyLarge?.color,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    ThemeData theme, {
    TextInputType? keyboardType,
    IconData? icon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(color: theme.textTheme.bodyLarge?.color),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon, size: 20) : null,
        filled: true,
        fillColor: theme.cardColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.primaryColor, width: 2),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  Widget _buildSaveButton(ThemeData theme, UserProfileState state) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: state.isLoading ? null : _saveProfile,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: state.isLoading ? 0 : 2,
        ),
        child: state.isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle_outline, size: 20),
                  const SizedBox(width: 8),
                  const Text(
                    'Guardar Cambios',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
