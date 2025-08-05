import 'package:math_latex_builder/src/constants/latex_element_type.dart';
import 'package:math_latex_builder/src/core/latex_leaf.dart';

/// A leaf that represents a common mathematical symbol.
/// These symbols can be rendered as they are.
class LaTeXSymbolLeaf extends LaTeXLeaf {
  LaTeXSymbolLeaf({
    required super.id,
    required super.parent,
    required super.child,
  });

  @override
  String get getType => LEType.symbolLeaf.name;

  // For many symbols like (), [], +, -, the string itself is the LaTeX output.
  // This class is a simple passthrough.
}
