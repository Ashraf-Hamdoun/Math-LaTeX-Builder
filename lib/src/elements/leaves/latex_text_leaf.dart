import 'package:math_latex_builder/src/constants/latex_element_type.dart';
import 'package:math_latex_builder/src/core/latex_leaf.dart';

/// A leaf that represents a plain text string within a mathematical expression.
/// It wraps the text in a LaTeX `\text{...}` command.
class LaTeXTextLeaf extends LaTeXLeaf {
  LaTeXTextLeaf({
    required super.id,
    required super.parent,
    required super.child,
  });

  @override
  String get getType => LEType.textLeaf.name;

  @override
  String computeLaTeXString() {
    // The child string represents the text content.
    // We wrap it in a \text{} command to display it correctly in math mode.
    return '\\text{$child}';
  }
}
