import '../../../../core/usecase/usecase.dart';
import '../entities/electrical_node.dart';

class UpdateNodeParams {
  final ElectricalNode root;
  final String targetId;
  final ElectricalNode Function(ElectricalNode) updateFn;
  UpdateNodeParams(this.root, this.targetId, this.updateFn);
}

class UpdateNodeUseCase implements UseCase<ElectricalNode, UpdateNodeParams> {
  @override
  Future<ElectricalNode> call({UpdateNodeParams? params}) async {
    if (params == null) throw Exception("Params required");

    final newRoot =
        _updateNodeInTree(params.root, params.targetId, params.updateFn);
    if (newRoot == null) {
      throw Exception("Target node ${params.targetId} not found");
    }
    return newRoot;
  }

  ElectricalNode? _updateNodeInTree(ElectricalNode currentNode, String targetId,
      ElectricalNode Function(ElectricalNode) updateFn) {
    // 1. Found Target?
    if (currentNode.id == targetId) {
      return updateFn(currentNode);
    }

    // 2. Recurse Children
    List<ElectricalNode> kids = currentNode.maybeMap(
      source: (n) => n.children,
      panel: (n) => n.children,
      protection: (n) => n.children,
      orElse: () => [],
    );

    bool kidsChanged = false;
    List<ElectricalNode> newKids = [];

    for (var child in kids) {
      final updatedChild = _updateNodeInTree(child, targetId, updateFn);

      if (updatedChild != null) {
        newKids.add(updatedChild);
        kidsChanged = true;
      } else {
        newKids.add(child);
      }
    }

    if (kidsChanged) {
      return currentNode.map(
        source: (n) => n.copyWith(children: newKids),
        panel: (n) => n.copyWith(children: newKids),
        protection: (n) => n.copyWith(children: newKids),
        load: (n) => n,
      );
    }

    return null;
  }
}
