import 'package:math_latex_builder/src/constants/directions.dart';
import 'package:math_latex_builder/src/constants/latex_element_type.dart';
import 'package:math_latex_builder/src/core/latex_node.dart';
import 'package:math_latex_builder/src/elements/nodes/latex_node_with_initial_type.dart';
import 'package:math_latex_builder/src/utiles/ids_generator.dart';

/// A node that represents a summation.
///
/// It contains three children: a lower limit, an upper limit, and the summand (expression).
class LaTeXSummationNode extends LaTeXNode {
  late final LaTeXNode lowerLimit;

  late final LaTeXNode upperLimit;

  late final LaTeXNode summand;

  LaTeXSummationNode({
    required super.id,
    required super.parent,
    required super.updateParent,
  }) {
    // Initialize the lower limit child node

    lowerLimit = LaTeXNodeWithInitialType(
      id: idsGenerator(LEType.lowerLimitNode, id),
      parent: this,
      updateParent: (childId, childValue) =>
          onUpdateChildren(childId, childValue),
      initialType: LEType.lowerLimitNode,
    );

    // Initialize the upper limit child node

    upperLimit = LaTeXNodeWithInitialType(
      id: idsGenerator(LEType.upperLimitNode, id),
      parent: this,
      updateParent: (childId, childValue) =>
          onUpdateChildren(childId, childValue),
      initialType: LEType.upperLimitNode,
    );

    // Initialize the summand (function) child node

    summand = LaTeXNodeWithInitialType(
      id: idsGenerator(LEType.summandNode, id),
      parent: this,
      updateParent: (childId, childValue) =>
          onUpdateChildren(childId, childValue),
      initialType: LEType.summandNode,
    );

    // Add the children to the summation node

    addChildNode(lowerLimit);

    addChildNode(upperLimit);

    addChildNode(summand);

    // Set the initial position to start in the lower limit

    position = 1;
  }

  @override
  String get getType => LEType.summationNode.name;

  @override
  String computeLaTeXString() {
    // Returns the full LaTeX string for the summation, including
    // the lower limit, upper limit, and the summand.
    // The \int command is prefixed, and the limits are in a subscript and superscript.
    // We add a small space `\,` before a placeholder differential 'dx' for clarity,
    // which is a standard practice in LaTeX.
    return "\\sum_{${lowerLimit.computeLaTeXString()}}^{${upperLimit.computeLaTeXString()}}${summand.computeLaTeXString()}";
  }

  @override
  LaTeXNode move(Direction direction) {
    if (direction == Direction.left) {
      // Logic for moving left
      if (position == 3) {
        position = 1;
        return lowerLimit;
      } else {
        // Move out of the summation node to the left
        parent!.position--;
        return parent!;
      }
    } else {
      // direction == Direction.right
      // Logic for moving right
      if (position != 3) {
        position = 3;
        return summand;
      } else {
        // Move out of the summation node to the right
        // it will return after the summation in the parent
        // so it is not needto => parent!.position++;
        return parent!;
      }
    }
  }

  @override
  LaTeXNode? deleteActiveChild() {
    // The summation node can only be deleted if all of its children are empty.
    if (lowerLimit.children.length == 1 &&
        upperLimit.children.length == 1 &&
        summand.children.length == 1) {
      // All children are empty, so we can delete the summation node itself.
      return parent!.deleteActiveChild();
    } else {
      // One of children is not empty
      // Move back ...
      if (position >= 2) {
        position--;
        return (position == 2) ? upperLimit : lowerLimit;
      } else {
        // Get out
        return parent!;
      }
    }
  }
}
