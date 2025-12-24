import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/diagram/domain/entities/electrical_node.dart';
import '../../domain/repositories/project_repository.dart';
import '../../domain/entities/project.dart';
import '../../domain/entities/budget_config.dart';

// STATE
class ProjectState extends Equatable {
  final int? projectId;
  final String projectName;
  final String? client;
  final String? reference;

  // New: Root Node of Tree
  final ElectricalNode? root;

  final BudgetConfig? budgetConfig;

  final bool isSaving;
  final String? errorMessage;
  final bool saveSuccess;
  final String? electricalStandardId;

  final String? ownerPhone;
  final String? ownerEmail;
  final String? supplyVoltage;
  final String? installationUsage;
  final double? expectedPower;
  final double? powerFactor;
  final bool? requiresTechProject;
  final bool? isNewLink;

  const ProjectState({
    this.projectId,
    this.projectName = "Nuevo Proyecto",
    this.client,
    this.reference,
    this.ownerPhone,
    this.ownerEmail,
    this.root,
    this.budgetConfig,
    this.isSaving = false,
    this.errorMessage,
    this.saveSuccess = false,
    this.electricalStandardId = 'rebt_spain',
    this.supplyVoltage = '400V III',
    this.installationUsage = 'Local de Pública Concurrencia',
    this.expectedPower = 15.0,
    this.powerFactor = 0.9,
    this.requiresTechProject = true,
    this.isNewLink = false,
  });

  ProjectState copyWith({
    int? projectId,
    String? projectName,
    String? client,
    String? reference,
    String? ownerPhone,
    String? ownerEmail,
    ElectricalNode? root,
    BudgetConfig? budgetConfig,
    bool? isSaving,
    String? errorMessage,
    bool? saveSuccess,
    String? electricalStandardId,
    String? supplyVoltage,
    String? installationUsage,
    double? expectedPower,
    double? powerFactor,
    bool? requiresTechProject,
    bool? isNewLink,
  }) {
    return ProjectState(
      projectId: projectId ?? this.projectId,
      projectName: projectName ?? this.projectName,
      client: client ?? this.client,
      reference: reference ?? this.reference,
      ownerPhone: ownerPhone ?? this.ownerPhone,
      ownerEmail: ownerEmail ?? this.ownerEmail,
      root: root ?? this.root,
      budgetConfig: budgetConfig ?? this.budgetConfig,
      isSaving: isSaving ?? this.isSaving,
      errorMessage: errorMessage,
      saveSuccess: saveSuccess ?? this.saveSuccess,
      electricalStandardId: electricalStandardId ?? this.electricalStandardId,
      supplyVoltage: supplyVoltage ?? this.supplyVoltage,
      installationUsage: installationUsage ?? this.installationUsage,
      expectedPower: expectedPower ?? this.expectedPower,
      powerFactor: powerFactor ?? this.powerFactor,
      requiresTechProject: requiresTechProject ?? this.requiresTechProject,
      isNewLink: isNewLink ?? this.isNewLink,
    );
  }

  @override
  List<Object?> get props => [
        projectId,
        projectName,
        client,
        reference,
        ownerPhone,
        ownerEmail,
        root,
        budgetConfig,
        isSaving,
        errorMessage,
        saveSuccess,
        electricalStandardId,
        supplyVoltage,
        installationUsage,
        expectedPower,
        powerFactor,
        requiresTechProject,
        isNewLink,
      ];
}

// CUBIT
class ProjectCubit extends Cubit<ProjectState> {
  final ProjectRepository _repository;

  ProjectCubit(this._repository) : super(const ProjectState());

  void setProject(Project project) {
    emit(ProjectState(
      projectId: project.id,
      projectName: project.name,
      client: project.client,
      reference: project.reference,
      ownerPhone: project.ownerPhone,
      ownerEmail: project.ownerEmail,
      root: project.root,
      budgetConfig: project.budgetConfig,
      electricalStandardId: project.electricalStandardId ?? 'rebt_spain',
      supplyVoltage: project.supplyVoltage ?? '400V III',
      installationUsage:
          project.installationUsage ?? 'Local de Pública Concurrencia',
      expectedPower: project.expectedPower ?? 15.0,
      powerFactor: project.powerFactor ?? 0.9,
      requiresTechProject: project.requiresTechProject ?? true,
      isNewLink: project.isNewLink ?? false,
    ));
  }

  void updateProjectName(String name) {
    emit(state.copyWith(projectName: name));
  }

  void updateClient(String client) {
    emit(state.copyWith(client: client));
  }

  void updateReference(String reference) {
    emit(state.copyWith(reference: reference));
  }

  void updateOwnerPhone(String val) => emit(state.copyWith(ownerPhone: val));
  void updateOwnerEmail(String val) => emit(state.copyWith(ownerEmail: val));
  void updateSupplyVoltage(String val) =>
      emit(state.copyWith(supplyVoltage: val));
  void updateInstallationUsage(String val) =>
      emit(state.copyWith(installationUsage: val));
  void updateExpectedPower(double val) =>
      emit(state.copyWith(expectedPower: val));
  void updatePowerFactor(double val) => emit(state.copyWith(powerFactor: val));
  void updateRequiresTechProject(bool val) =>
      emit(state.copyWith(requiresTechProject: val));
  void updateIsNewLink(bool val) => emit(state.copyWith(isNewLink: val));

  // Called by DiagramCubit or Page when saving
  void updateRoot(ElectricalNode root) {
    emit(state.copyWith(root: root));
  }

  void updateBudgetConfig(BudgetConfig config) {
    emit(state.copyWith(budgetConfig: config));
  }

  void updateElectricalStandard(String id) {
    emit(state.copyWith(electricalStandardId: id));
  }

  void createNewProject({String defaultStandard = 'rebt_spain'}) {
    emit(ProjectState(electricalStandardId: defaultStandard));
  }

  Future<void> saveProject() async {
    if (state.projectName.isEmpty) {
      emit(state.copyWith(errorMessage: "El nombre es obligatorio"));
      return;
    }

    emit(
        state.copyWith(isSaving: true, errorMessage: null, saveSuccess: false));

    final project = Project(
      id: state.projectId,
      name: state.projectName,
      client: state.client,
      reference: state.reference,
      ownerPhone: state.ownerPhone,
      ownerEmail: state.ownerEmail,
      createdAt: DateTime
          .now(), // Should preserve if editing? Mapping handles it usually
      updatedAt: DateTime.now(),
      root: state.root,
      budgetConfig: state.budgetConfig,
      electricalStandardId: state.electricalStandardId,
      supplyVoltage: state.supplyVoltage,
      installationUsage: state.installationUsage,
      expectedPower: state.expectedPower,
      powerFactor: state.powerFactor,
      requiresTechProject: state.requiresTechProject,
      isNewLink: state.isNewLink,
    );

    final result = await _repository.saveProject(project);

    result.fold(
      (failure) => emit(state.copyWith(
          isSaving: false, errorMessage: "Error al guardar el proyecto")),
      (id) => emit(
          state.copyWith(isSaving: false, saveSuccess: true, projectId: id)),
    );
  }

  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }

  void resetSaveSuccess() {
    emit(state.copyWith(saveSuccess: false));
  }
}
