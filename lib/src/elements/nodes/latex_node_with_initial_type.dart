import 'package:math_latex_builder/src/constants/latex_element_type.dart';
import 'package:math_latex_builder/src/core/latex_node.dart';

/// A node with an initial type.
class LaTeXNodeWithInitialType extends LaTeXNode {
  final LEType initialType;
  LaTeXNodeWithInitialType({
    required super.id,
    required super.parent,
    required super.updateParent,
    required this.initialType,
  });

  @override
  String get getType => initialType.name;
}
