import 'package:isar/isar.dart';
import '../../domain/entities/user_profile.dart';

part 'user_profile_model.g.dart';

/// Isar data model for UserProfile persistence
@collection
class UserProfileModel {
  /// Isar ID - always 1 since there's only one profile per installation
  Id id = 1;

  // ============================================================================
  // PERSONAL PROFILE (Engineer - Always Required)
  // ============================================================================

  /// Full name of the engineer/professional
  String personalName = '';

  /// Personal email address
  String personalEmail = '';

  /// Personal phone number
  String personalPhone = '';

  /// DNI/NIF (Spanish ID) of the engineer
  String personalDni = '';

  /// Professional engineer ID (colegiado number)
  String engineerId = '';

  /// Profile photo stored as bytes
  List<int>? personalPhotoBytes;

  // ============================================================================
  // PROFESSIONAL TYPE
  // ============================================================================

  /// Whether this profile represents a freelancer or a company
  @Enumerated(EnumType.name)
  ProfessionalType professionalType = ProfessionalType.freelancer;

  // ============================================================================
  // COMPANY DATA (Optional - Only when professionalType == company)
  // ============================================================================

  /// Company CIF (tax identification)
  String? companyCif;

  /// Company legal name (razón social)
  String? companyName;

  /// Company physical address
  String? companyAddress;

  /// Company contact email
  String? companyEmail;

  /// Company contact phone
  String? companyPhone;

  /// Company logo stored as bytes (for PDF generation)
  List<int>? companyLogoBytes;

  /// Converts this Isar model to a domain entity
  UserProfile toEntity() {
    return UserProfile(
      id: id.toString(),
      personalName: personalName,
      personalEmail: personalEmail,
      personalPhone: personalPhone,
      personalDni: personalDni,
      engineerId: engineerId,
      personalPhotoBytes: personalPhotoBytes,
      professionalType: professionalType,
      companyCif: companyCif,
      companyName: companyName,
      companyAddress: companyAddress,
      companyEmail: companyEmail,
      companyPhone: companyPhone,
      companyLogoBytes: companyLogoBytes,
    );
  }

  /// Creates an Isar model from a domain entity
  static UserProfileModel fromEntity(UserProfile profile) {
    return UserProfileModel()
      ..id = int.tryParse(profile.id) ?? 1
      ..personalName = profile.personalName
      ..personalEmail = profile.personalEmail
      ..personalPhone = profile.personalPhone
      ..personalDni = profile.personalDni
      ..engineerId = profile.engineerId
      ..personalPhotoBytes = profile.personalPhotoBytes
      ..professionalType = profile.professionalType
      ..companyCif = profile.companyCif
      ..companyName = profile.companyName
      ..companyAddress = profile.companyAddress
      ..companyEmail = profile.companyEmail
      ..companyPhone = profile.companyPhone
      ..companyLogoBytes = profile.companyLogoBytes;
  }
}
