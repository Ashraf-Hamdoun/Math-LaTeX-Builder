import 'package:math_latex_builder/src/constants/latex_element_type.dart';
import 'package:math_latex_builder/src/core/latex_node.dart';

/// The root of the LaTeX tree.
///
/// This class represents the main container for the LaTeX expression and is
/// responsible for initiating the LaTeX string generation.
class LaTeXTrunk extends LaTeXNode {
  LaTeXTrunk({
    required super.id,
    super.parent,
    super.updateParent = _defaultUpdateParent,
  });

  @override
  String get getType => LEType.trunk.name;

  /// The default callback for child updates.
  static void _defaultUpdateParent(String childId, String childValue) {}

  @override
  String toLaTeXString() {
    return "\\(${super.toLaTeXString()}\\)";
  }
}
