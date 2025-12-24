import '../../../../core/usecase/usecase.dart';
import '../entities/electrical_node.dart';

class AddChildNodeParams {
  final ElectricalNode root;
  final String parentId;
  final ElectricalNode child;
  AddChildNodeParams(this.root, this.parentId, this.child);
}

class AddChildNodeUseCase
    implements UseCase<ElectricalNode, AddChildNodeParams> {
  @override
  Future<ElectricalNode> call({AddChildNodeParams? params}) async {
    if (params == null) throw Exception("Params required");

    final newRoot = _addChildToTree(params.root, params.parentId, params.child);
    if (newRoot == null) {
      throw Exception("Parent node ${params.parentId} not found");
    }
    return newRoot;
  }

  ElectricalNode? _addChildToTree(
      ElectricalNode currentNode, String parentId, ElectricalNode child) {
    // 1. Check if this is the parent
    if (currentNode.id == parentId) {
      // Add child
      return currentNode.map(
        source: (n) => n.copyWith(children: [...n.children, child]),
        panel: (n) => n.copyWith(children: [...n.children, child]),
        protection: (n) => n.copyWith(children: [...n.children, child]),
        load: (n) => n, // Load cannot have children
      );
    }

    // 2. If not, recurse into children
    List<ElectricalNode> currentChildren = currentNode.maybeMap(
      source: (n) => n.children,
      panel: (n) => n.children,
      protection: (n) => n.children,
      orElse: () => [],
    );

    bool foundInSubtree = false;
    List<ElectricalNode> mappedChildren = [];

    for (var c in currentChildren) {
      final result = _addChildToTree(c, parentId, child);
      if (result != null) {
        mappedChildren.add(result);
        foundInSubtree = true;
      } else {
        mappedChildren.add(c);
      }
    }

    if (foundInSubtree) {
      return currentNode.map(
        source: (n) => n.copyWith(children: mappedChildren),
        panel: (n) => n.copyWith(children: mappedChildren),
        protection: (n) => n.copyWith(children: mappedChildren),
        load: (n) => n,
      );
    }

    return null; // Not found in this tree
  }
}
