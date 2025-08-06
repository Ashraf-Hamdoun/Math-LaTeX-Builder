import 'package:math_latex_builder/src/constants/directions.dart';
import 'package:math_latex_builder/src/constants/latex_element_type.dart';
import 'package:math_latex_builder/src/core/latex_element.dart';
import 'package:math_latex_builder/src/core/latex_node.dart';
import 'package:math_latex_builder/src/elements/nodes/latex_fraction_node.dart';
import 'package:math_latex_builder/src/elements/nodes/latex_integral_node.dart';
import 'package:math_latex_builder/src/elements/nodes/latex_node_with_initial_type.dart';
import 'package:math_latex_builder/src/elements/nodes/latex_nth_root_node.dart';
import 'package:math_latex_builder/src/elements/nodes/latex_summation_node.dart';
import 'package:math_latex_builder/src/utiles/search_for_specific_node.dart';

/// Handles the movement of the cursor in the LaTeX tree.
///
/// This function is responsible for determining the new active node based on the
/// current active node and the direction of movement. It also handles moving
/// in and out of nodes, such as fractions and roots.
LaTeXNode? handleMove(Direction direction, LaTeXNode parent) {
  LaTeXNode? proposedParent;

  switch (direction) {
    case Direction.right:
      proposedParent = handleMoveRight(parent);
      break;
    case Direction.left:
      proposedParent = handleMoveLeft(parent);
      break;
    case Direction.up:
      proposedParent = handleMoveUp(parent);
      break;
    case Direction.down:
      proposedParent = handleMoveDown(parent);
      break;
  }

  if (proposedParent != null && proposedParent != parent) {
    if (proposedParent.childrenIDs.contains(parent.id)) {
      if (proposedParent is LaTeXFractionNode) {
        proposedParent = proposedParent.move(direction);
      } else if (proposedParent is LaTeXNthRootNode) {
        proposedParent = proposedParent.move(direction);
      } else if (proposedParent is LaTeXIntegralNode) {
        proposedParent = proposedParent.move(direction);
      } else if (proposedParent is LaTeXSummationNode) {
        proposedParent = proposedParent.move(direction);
      }
    } else {
      if (proposedParent is LaTeXFractionNode) {
        proposedParent = proposedParent.numerator;
      } else if (proposedParent is LaTeXNthRootNode) {
        proposedParent = proposedParent.indexOfRoot;
      } else if (proposedParent is LaTeXIntegralNode) {
        proposedParent = proposedParent.lowerLimit;
      } else if (proposedParent is LaTeXSummationNode) {
        proposedParent = proposedParent.lowerLimit;
      }
    }
  }

  return proposedParent;
}

/// Handles moving the cursor to the right.
LaTeXNode? handleMoveRight(LaTeXNode parent) {
  LaTeXNode? proposedParent;
  LaTeXNode? grandParent = parent.parent;
  int position = parent.position;

  // Still inside the parent and there are available moves.
  if (position < parent.children.length - 1) {
    // if the next child is a node, then we must enter it
    if (parent.children[position + 1] is LaTeXNode) {
      parent.position++;
      proposedParent = parent.children[position + 1] as LaTeXNode;
    } else {
      parent.position++;
      proposedParent = parent;
    }
  } else {
    // At the end and the available move to go outside.
    if (grandParent != null) {
      if (grandParent is LaTeXIntegralNode) {
        proposedParent = grandParent.move(Direction.right);
      } else if (grandParent is LaTeXSummationNode) {
        proposedParent = grandParent.move(Direction.right);
      } else {
        proposedParent = grandParent;
      }
    } else {
      proposedParent = null;
    }
  }

  return proposedParent;
}

/// Handles moving the cursor to the left.
LaTeXNode? handleMoveLeft(LaTeXNode parent) {
  LaTeXNode? proposedParent;
  LaTeXNode? grandParent = parent.parent;
  int position = parent.position;

  if (position > 0) {
    LaTeXElement laTeXElement = parent.children[position];
    if (laTeXElement is LaTeXNode) {
      proposedParent = laTeXElement;
    } else {
      parent.position--;
      proposedParent = parent;
    }
  } else {
    if (grandParent != null) {
      if (grandParent is LaTeXFractionNode) {
        proposedParent = grandParent.move(Direction.left);
      }
      if (grandParent is LaTeXIntegralNode) {
        proposedParent = grandParent.move(Direction.left);
      } else if (grandParent is LaTeXSummationNode) {
        proposedParent = grandParent.move(Direction.left);
      } else {
        grandParent.position--;
        proposedParent = grandParent;
      }
    } else {
      proposedParent = null;
    }
  }

  return proposedParent;
}

/// Handles moving the cursor down.
LaTeXNode? handleMoveDown(LaTeXNode parent) {
  LaTeXNode? proposedParent;
  LaTeXNode? grandParent = parent.parent;

  if (grandParent != null) {
    if (parent is LaTeXNodeWithInitialType &&
        parent.initialType == LEType.numeratorNode) {
      proposedParent = (grandParent as LaTeXFractionNode).denominator;
    } else if (parent is LaTeXNodeWithInitialType &&
        parent.initialType == LEType.upperLimitNode) {
      if (grandParent is LaTeXIntegralNode) {
        proposedParent = grandParent.lowerLimit;
      } else if (grandParent is LaTeXSummationNode) {
        proposedParent = grandParent.lowerLimit;
      }
    } else {
      proposedParent = searchForSpecificNode(parent, Direction.down);
    }
  } else {
    proposedParent = null;
  }

  return proposedParent;
}

/// Handles moving the cursor up.
LaTeXNode? handleMoveUp(LaTeXNode parent) {
  LaTeXNode? proposedParent;
  LaTeXNode? grandParent = parent.parent;

  if (grandParent != null) {
    if (parent is LaTeXNodeWithInitialType &&
        parent.initialType == LEType.denominatorNode) {
      proposedParent = (grandParent as LaTeXFractionNode).numerator;
    } else if (parent is LaTeXNodeWithInitialType &&
        parent.initialType == LEType.lowerLimitNode) {
      if (grandParent is LaTeXIntegralNode) {
        proposedParent = grandParent.upperLimit;
      } else if (grandParent is LaTeXSummationNode) {
        proposedParent = grandParent.upperLimit;
      }
    } else {
      proposedParent = searchForSpecificNode(parent, Direction.up);
    }
  } else {
    proposedParent = null;
  }

  return proposedParent;
}
