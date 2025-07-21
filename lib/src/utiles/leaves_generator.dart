import 'package:math_latex_builder/src/constants/latex_element_type.dart';
import 'package:math_latex_builder/src/core/latex_leaf.dart';
import 'package:math_latex_builder/src/core/latex_node.dart';
import 'package:math_latex_builder/src/elements/leaves/latex_number_leaf.dart';
import 'package:math_latex_builder/src/elements/leaves/latex_operator_leaf.dart';
import 'package:math_latex_builder/src/elements/leaves/latex_variable_leaf.dart';
import 'package:math_latex_builder/src/utiles/ids_generator.dart';

/// A factory for creating LaTeX leaf elements.
///
/// This function is responsible for creating the correct type of leaf based on
/// the provided [LEType].
LaTeXLeaf leavesGenerator({
  required LaTeXNode parent,
  required LEType type,
  required String content,
}) {
  LaTeXLeaf leaf;
  switch (type) {
    case LEType.numberLeaf:
      leaf = LaTeXNumberLeaf(
        child: content,
        id: idsGenerator(LEType.numberLeaf, parent.id),
        parent: parent,
      );
      break;

    case LEType.operatorLeaf:
      leaf = LaTeXOperatorLeaf(
        child: content,
        id: idsGenerator(LEType.operatorLeaf, parent.id),
        parent: parent,
      );
      break;

    case LEType.variableLeaf:
      leaf = LaTeXVariableLeaf(
        child: content,
        id: idsGenerator(LEType.operatorLeaf, parent.id),
        parent: parent,
      );
      break;

    default:
      leaf = LaTeXNumberLeaf(
        child: content,
        id: idsGenerator(LEType.essentialLeaf, parent.id),
        parent: parent,
      );
  }
  return leaf;
}
