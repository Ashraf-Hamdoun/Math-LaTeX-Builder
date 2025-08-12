import 'package:math_latex_builder/src/constants/latex_element_type.dart';
import 'package:math_latex_builder/src/core/latex_node.dart';

/// A node that represents a function.
class LaTeXInverseFunctionNode extends LaTeXNode {
  final String function;
  LaTeXInverseFunctionNode({
    required super.id,
    required super.parent,
    required super.updateParent,
    required this.function,
  });

  @override
  String get getType => LEType.inverseFunctionNode.name;

  @override
  String computeLaTeXString() {
    return "\\$function^{-1}(${super.computeLaTeXString()})";
  }
}
