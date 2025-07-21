import 'package:math_latex_builder/src/constants/directions.dart';
import 'package:math_latex_builder/src/constants/latex_element_type.dart';
import 'package:math_latex_builder/src/core/latex_node.dart';
import 'package:math_latex_builder/src/elements/nodes/latex_node_with_initial_type.dart';
import 'package:math_latex_builder/src/utiles/ids_generator.dart';

/// A node that represents a fraction.
class LaTeXFractionNode extends LaTeXNode {
  late final LaTeXNode numerator;
  late final LaTeXNode denominator;

  LaTeXFractionNode({
    required super.id,
    required super.parent,
    required super.updateParent,
  }) {
    numerator = LaTeXNodeWithInitialType(
      id: idsGenerator(LEType.numeratorNode, id),
      parent: this,
      updateParent: (childId, childValue) =>
          onUpdateChildren(childId, childValue),
      initialType: LEType.numeratorNode,
    );

    denominator = LaTeXNodeWithInitialType(
      id: idsGenerator(LEType.denominatorNode, id),
      parent: this,
      updateParent: (childId, childValue) =>
          onUpdateChildren(childId, childValue),
      initialType: LEType.denominatorNode,
    );

    addChildNode(numerator);
    addChildNode(denominator);

    position = 1;
  }

  @override
  String get getType => LEType.fractionNode.name;

  @override
  String computeLaTeXString() {
    return "\\frac{${numerator.computeLaTeXString()}}{${denominator.computeLaTeXString()}}";
  }

  @override
  LaTeXNode move(Direction direction) {
    if (direction == Direction.left) {
      parent!.position--;
      return parent!;
    } else {
      return parent!;
    }
  }

  @override
  LaTeXNode? deleteActiveChild() {
    if (numerator.children.length == 1 && denominator.children.length == 1) {
      // Fraction node is empty, you can delete it.
      parent!.deleteActiveChild();
      return parent;
    } else {
      return null;
    }
  }
}
