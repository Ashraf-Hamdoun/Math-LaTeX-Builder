import 'package:math_latex_builder/src/constants/latex_element_type.dart';
import 'package:math_latex_builder/src/core/latex_node.dart';

/// A node that represents a function.
class LaTeXFunctionNode extends LaTeXNode {
  final String function;
  LaTeXFunctionNode({
    required super.id,
    required super.parent,
    required super.updateParent,
    required this.function,
  });

  @override
  String get getType => LEType.functionNode.name;

  @override
  String computeLaTeXString() {
    return "$function(${super.computeLaTeXString()})";
  }
}