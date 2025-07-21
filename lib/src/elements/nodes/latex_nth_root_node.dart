import 'package:math_latex_builder/src/constants/directions.dart';
import 'package:math_latex_builder/src/constants/latex_element_type.dart';
import 'package:math_latex_builder/src/core/latex_node.dart';
import 'package:math_latex_builder/src/elements/nodes/latex_node_with_initial_type.dart';
import 'package:math_latex_builder/src/utiles/ids_generator.dart';

/// A node that represents an nth root.
class LaTeXNthRootNode extends LaTeXNode {
  late final LaTeXNode indexOfRoot;
  late final LaTeXNode radicand;

  LaTeXNthRootNode({
    required super.id,
    required super.parent,
    required super.updateParent,
  }) {
    indexOfRoot = LaTeXNodeWithInitialType(
      id: idsGenerator(LEType.indexOfRootNode, id),
      parent: this,
      updateParent: (childId, childValue) =>
          onUpdateChildren(childId, childValue),
      initialType: LEType.indexOfRootNode,
    );

    radicand = LaTeXNodeWithInitialType(
      id: idsGenerator(LEType.radicandNode, id),
      parent: this,
      updateParent: (childId, childValue) =>
          onUpdateChildren(childId, childValue),
      initialType: LEType.radicandNode,
    );

    addChildNode(indexOfRoot);
    addChildNode(radicand);

    position = 1;
  }

  @override
  String get getType => LEType.nthRootNode.name;

  @override
  String computeLaTeXString() {
    return "\\sqrt[${indexOfRoot.computeLaTeXString()}]{${radicand.computeLaTeXString()}}";
  }

  @override
  LaTeXNode move(Direction direction) {
    if (position == 1 && direction == Direction.right) {
      position = 2;
      return radicand;
    } else if (position == 2 && direction == Direction.left) {
      position = 1;
      return indexOfRoot;
    } else {
      if (direction == Direction.right) {
        return parent!;
      } else if (direction == Direction.left) {
        parent?.position--;
        return parent!;
      } else {
        return parent!.move(direction);
      }
    }
  }

  @override
  LaTeXNode? deleteActiveChild() {
    if (indexOfRoot.children.length == 1 && radicand.children.length == 1) {
      // Nth root node is empty, you can delete it.
      parent!.deleteActiveChild();
      return parent;
    } else {
      if (position == 2) {
        position == 1;
        return indexOfRoot.deleteActiveChild();
      }
      return null;
    }
  }
}
