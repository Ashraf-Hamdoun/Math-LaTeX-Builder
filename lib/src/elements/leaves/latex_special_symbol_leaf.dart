import 'package:math_latex_builder/src/constants/latex_element_type.dart';
import 'package:math_latex_builder/src/core/latex_leaf.dart';

/// A leaf that represents a special character or command in LaTeX.
/// These symbols require a specific LaTeX string representation.
class LaTeXSpecialSymbolLeaf extends LaTeXLeaf {
  LaTeXSpecialSymbolLeaf({
    required super.id,
    required super.parent,
    required super.child,
  });

  @override
  String get getType => LEType.specialSymbolLeaf.name;

  @override
  String computeLaTeXString() {
    return '\\$child';
  }
}
