/// Enum representing the type of professional: freelancer (autónomo) or company (empresa)
enum ProfessionalType {
  freelancer,
  company,
}

/// Domain entity representing a user's professional profile
///
/// This entity contains:
/// - Personal/Engineer data (always required)
/// - Company data (optional, only when professionalType == company)
class UserProfile {
  /// Unique identifier for the profile
  final String id;

  // ============================================================================
  // PERSONAL PROFILE (Engineer - Always Required)
  // ============================================================================

  /// Full name of the engineer/professional
  final String personalName;

  /// Personal email address
  final String personalEmail;

  /// Personal phone number
  final String personalPhone;

  /// DNI/NIF (Spanish ID) of the engineer
  final String personalDni;

  /// Professional engineer ID (colegiado number)
  final String engineerId;

  /// Profile photo stored as bytes (nullable)
  final List<int>? personalPhotoBytes;

  // ============================================================================
  // PROFESSIONAL TYPE
  // ============================================================================

  /// Whether this profile represents a freelancer or a company
  final ProfessionalType professionalType;

  // ============================================================================
  // COMPANY DATA (Optional - Only when professionalType == company)
  // ============================================================================

  /// Company CIF (tax identification)
  final String? companyCif;

  /// Company legal name (razón social)
  final String? companyName;

  /// Company physical address
  final String? companyAddress;

  /// Company contact email
  final String? companyEmail;

  /// Company contact phone
  final String? companyPhone;

  /// Company logo stored as bytes (for PDF generation)
  final List<int>? companyLogoBytes;

  const UserProfile({
    required this.id,
    required this.personalName,
    required this.personalEmail,
    required this.personalPhone,
    required this.personalDni,
    required this.engineerId,
    this.personalPhotoBytes,
    required this.professionalType,
    this.companyCif,
    this.companyName,
    this.companyAddress,
    this.companyEmail,
    this.companyPhone,
    this.companyLogoBytes,
  });

  /// Creates a copy of this profile with updated fields
  UserProfile copyWith({
    String? id,
    String? personalName,
    String? personalEmail,
    String? personalPhone,
    String? personalDni,
    String? engineerId,
    List<int>? personalPhotoBytes,
    ProfessionalType? professionalType,
    String? companyCif,
    String? companyName,
    String? companyAddress,
    String? companyEmail,
    String? companyPhone,
    List<int>? companyLogoBytes,
  }) {
    return UserProfile(
      id: id ?? this.id,
      personalName: personalName ?? this.personalName,
      personalEmail: personalEmail ?? this.personalEmail,
      personalPhone: personalPhone ?? this.personalPhone,
      personalDni: personalDni ?? this.personalDni,
      engineerId: engineerId ?? this.engineerId,
      personalPhotoBytes: personalPhotoBytes ?? this.personalPhotoBytes,
      professionalType: professionalType ?? this.professionalType,
      companyCif: companyCif ?? this.companyCif,
      companyName: companyName ?? this.companyName,
      companyAddress: companyAddress ?? this.companyAddress,
      companyEmail: companyEmail ?? this.companyEmail,
      companyPhone: companyPhone ?? this.companyPhone,
      companyLogoBytes: companyLogoBytes ?? this.companyLogoBytes,
    );
  }

  /// Checks if this profile has complete personal information
  bool get hasCompletePersonalInfo {
    return personalName.isNotEmpty &&
        personalEmail.isNotEmpty &&
        personalPhone.isNotEmpty &&
        personalDni.isNotEmpty &&
        engineerId.isNotEmpty;
  }

  /// Checks if this profile has complete company information
  /// Only relevant when professionalType == company
  bool get hasCompleteCompanyInfo {
    if (professionalType == ProfessionalType.freelancer) {
      return true; // Not applicable for freelancers
    }
    return companyCif != null &&
        companyCif!.isNotEmpty &&
        companyName != null &&
        companyName!.isNotEmpty &&
        companyAddress != null &&
        companyAddress!.isNotEmpty;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserProfile &&
        other.id == id &&
        other.personalName == personalName &&
        other.personalEmail == personalEmail &&
        other.personalPhone == personalPhone &&
        other.personalDni == personalDni &&
        other.engineerId == engineerId &&
        _listEquals(other.personalPhotoBytes, personalPhotoBytes) &&
        other.professionalType == professionalType &&
        other.companyCif == companyCif &&
        other.companyName == companyName &&
        other.companyAddress == companyAddress &&
        other.companyEmail == companyEmail &&
        other.companyPhone == companyPhone &&
        _listEquals(other.companyLogoBytes, companyLogoBytes);
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      personalName,
      personalEmail,
      personalPhone,
      personalDni,
      engineerId,
      personalPhotoBytes,
      professionalType,
      companyCif,
      companyName,
      companyAddress,
      companyEmail,
      companyPhone,
      companyLogoBytes,
    );
  }

  bool _listEquals(List<int>? a, List<int>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
