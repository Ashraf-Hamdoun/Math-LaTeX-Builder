import 'package:math_latex_builder/src/constants/latex_element_type.dart';
import 'package:math_latex_builder/src/core/latex_node.dart';
import 'package:math_latex_builder/src/elements/nodes/latex_function_node.dart';
import 'package:math_latex_builder/src/elements/nodes/latex_integral_node.dart';
import 'package:math_latex_builder/src/elements/nodes/latex_inverse_function_node.dart';
import 'package:math_latex_builder/src/utiles/ids_generator.dart';
import 'package:math_latex_builder/src/elements/nodes/latex_cube_root_node.dart';
import 'package:math_latex_builder/src/elements/nodes/latex_fraction_node.dart';
import 'package:math_latex_builder/src/elements/nodes/latex_node_with_initial_type.dart';
import 'package:math_latex_builder/src/elements/nodes/latex_nth_root_node.dart';
import 'package:math_latex_builder/src/elements/nodes/latex_power_node.dart';
import 'package:math_latex_builder/src/elements/nodes/latex_square_root_node.dart';

/// A factory for creating LaTeX node elements.
///
/// This function is responsible for creating the correct type of node based on
/// the provided [LEType].
LaTeXNode nodesGenerator({
  required LaTeXNode parent,
  required LEType type,
  required String content,
}) {
  LaTeXNode node;
  switch (type) {
    case LEType.functionNode:
      node = LaTeXFunctionNode(
        id: idsGenerator(type, parent.id),
        parent: parent,
        updateParent: (childId, childValue) =>
            parent.onUpdateChildren(childId, childValue),
        function: content,
      );
      break;

    case LEType.inverseFunctionNode:
      node = LaTeXInverseFunctionNode(
        id: idsGenerator(type, parent.id),
        parent: parent,
        updateParent: (childId, childValue) =>
            parent.onUpdateChildren(childId, childValue),
        function: content,
      );
      break;

    case LEType.fractionNode:
      node = LaTeXFractionNode(
        id: idsGenerator(type, parent.id),
        parent: parent,
        updateParent: (childId, childValue) =>
            parent.onUpdateChildren(childId, childValue),
      );
      break;

    case LEType.squareRootNode:
      node = LaTeXSquareRootNode(
        id: idsGenerator(type, parent.id),
        parent: parent,
        updateParent: (childId, childValue) =>
            parent.onUpdateChildren(childId, childValue),
      );
      break;

    case LEType.cubeRootNode:
      node = LaTeXCubeRootNode(
        id: idsGenerator(type, parent.id),
        parent: parent,
        updateParent: (childId, childValue) =>
            parent.onUpdateChildren(childId, childValue),
      );
      break;

    case LEType.nthRootNode:
      node = LaTeXNthRootNode(
        id: idsGenerator(type, parent.id),
        parent: parent,
        updateParent: (childId, childValue) =>
            parent.onUpdateChildren(childId, childValue),
      );
      break;

    case LEType.powerNode:
      node = LaTeXPowerNode(
        id: idsGenerator(type, parent.id),
        parent: parent,
        updateParent: (childId, childValue) =>
            parent.onUpdateChildren(childId, childValue),
      );
      break;

    case LEType.integralNode:
      node = LaTeXIntegralNode(
          id: idsGenerator(type, parent.id),
          parent: parent,
          updateParent: (childId, childValue) =>
              parent.onUpdateChildren(childId, childValue));
      break;

    default:
      node = LaTeXNodeWithInitialType(
        id: idsGenerator(type, parent.id),
        parent: parent,
        updateParent: (childId, childValue) =>
            parent.onUpdateChildren(childId, childValue),
        initialType: type,
      );
  }
  return node;
}
