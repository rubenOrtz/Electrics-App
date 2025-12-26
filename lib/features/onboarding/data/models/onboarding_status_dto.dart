import 'package:isar/isar.dart';

part 'onboarding_status_dto.g.dart';

@collection
class OnboardingStatusDto {
  Id id = 0;

  bool isComplete = false;
  DateTime? completedAt;
}
