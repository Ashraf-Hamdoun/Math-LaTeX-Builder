import 'package:math_latex_builder/src/constants/latex_element_type.dart';
import 'package:math_latex_builder/src/core/latex_node.dart';

/// A node that represents a cube root.
class LaTeXCubeRootNode extends LaTeXNode {
  LaTeXCubeRootNode({
    required super.id,
    required super.parent,
    required super.updateParent,
  });

  @override
  String get getType => LEType.cubeRootNode.name;

  @override
  String computeLaTeXString() {
    return "\\sqrt[3]{${super.computeLaTeXString()}}";
  }
}
