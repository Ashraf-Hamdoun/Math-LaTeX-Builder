import 'package:math_latex_builder/src/constants/latex_element_type.dart';

int idsCounter = 0;

/// Generates a unique ID for a LaTeX element.
///
/// The ID is based on the element's type and its parent's ID to ensure that it
/// is unique within the tree.
String idsGenerator(LEType type, String parentId) {
  String idPrefix;

  switch (type) {
    case LEType.trunk:
      idPrefix = "t";
      break;
    case LEType.node:
      idPrefix = "$parentId-n-norm";
      break;
    case LEType.fractionNode:
      idPrefix = "$parentId-n-frac";
      break;
    case LEType.numeratorNode:
      idPrefix = "$parentId-n-num";
      break;
    case LEType.denominatorNode:
      idPrefix = "$parentId-n-den";
      break;
    case LEType.squareRootNode:
      idPrefix = "$parentId-n-sqrt";
      break;
    case LEType.cubeRootNode:
      idPrefix = "$parentId-n-cbrt";
      break;
    case LEType.nthRootNode:
      idPrefix = "$parentId-n-nthrt";
      break;
    case LEType.indexOfRootNode:
      idPrefix = "$parentId-n-idxrt";
      break;
    case LEType.radicandNode:
      idPrefix = "$parentId-n-radicand";
      break;
    case LEType.powerNode:
      idPrefix = "$parentId-n-pow";
      break;
    case LEType.numberLeaf:
      idPrefix = "$parentId-l-num";
      break;
    case LEType.operatorLeaf:
      idPrefix = "$parentId-l-oper";
      break;
    case LEType.variableLeaf:
      idPrefix = "$parentId-l-var";
      break;
    case LEType.leaf:
      idPrefix = "$parentId-l-ess";
      break;
    default:
      idPrefix = "$parentId-unk";
  }

  idsCounter++;
  return "$idPrefix-$idsCounter";
}
