import 'package:math_latex_builder/src/constants/latex_element_type.dart';
import 'package:math_latex_builder/src/core/latex_node.dart';

/// A node that represents a square root.
class LaTeXSquareRootNode extends LaTeXNode {
  LaTeXSquareRootNode({
    required super.id,
    required super.parent,
    required super.updateParent,
  });

  @override
  String get getType => LEType.squareRootNode.name;

  @override
  String computeLaTeXString() {
    return "\\sqrt{${super.computeLaTeXString()}}";
  }
}
