import 'package:math_latex_builder/src/constants/directions.dart';
import 'package:math_latex_builder/src/constants/latex_element_type.dart';
import 'package:math_latex_builder/src/core/latex_node.dart';
import 'package:math_latex_builder/src/elements/nodes/latex_node_with_initial_type.dart';

/// Searches for a specific node in the LaTeX tree.
///
/// This function is used to find a node that can handle a vertical move, such as
/// a fraction or a root.
LaTeXNode? searchForSpecificNode(LaTeXNode parent, Direction direction) {
  LaTeXNode? proposedParent;
  LaTeXNode? grandParent = parent.parent;

  if (grandParent != null) {
    if (direction == Direction.down) {
      if (grandParent is LaTeXNodeWithInitialType &&
          grandParent.initialType == LEType.numeratorNode) {
        proposedParent = grandParent.move(direction);
      } else {
        proposedParent = searchForSpecificNode(grandParent, Direction.down);
      }
    } else {
      if (grandParent is LaTeXNodeWithInitialType &&
          grandParent.initialType == LEType.denominatorNode) {
        proposedParent = grandParent.move(direction);
      } else {
        proposedParent = searchForSpecificNode(grandParent, Direction.up);
      }
    }
  }

  return proposedParent;
}
