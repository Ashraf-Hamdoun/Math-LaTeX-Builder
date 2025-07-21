import 'package:math_latex_builder/src/constants/latex_element_type.dart';
import 'package:math_latex_builder/src/core/latex_node.dart';

/// A node that represents a power.
class LaTeXPowerNode extends LaTeXNode {
  LaTeXPowerNode({
    required super.id,
    required super.parent,
    required super.updateParent,
  });

  @override
  String get getType => LEType.powerNode.name;

  @override
  String computeLaTeXString() {
    return "^{${super.computeLaTeXString()}}";
  }
}
