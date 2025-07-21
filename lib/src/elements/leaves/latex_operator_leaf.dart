import 'package:math_latex_builder/src/constants/latex_element_type.dart';
import 'package:math_latex_builder/src/core/latex_leaf.dart';

/// A leaf that represents an operator.
class LaTeXOperatorLeaf extends LaTeXLeaf {
  LaTeXOperatorLeaf({
    required super.id,
    required super.parent,
    required super.child,
  });

  @override
  String get getType => LEType.operatorLeaf.name;
}
