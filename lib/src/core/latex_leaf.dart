import 'package:math_latex_builder/src/core/latex_node.dart';
import '../constants/latex_element_type.dart';
import 'latex_element.dart';

/// The base class for all LaTeX leaf elements.
///
/// Leaf elements are the terminal nodes of the LaTeX tree and hold the actual
/// content, such as numbers and operators. They do not have children.
///
/// The [child] property holds the string value of the leaf, which is used to
/// generate the LaTeX string.
abstract class LaTeXLeaf extends LaTeXElement {
  /// The content of the leaf, such as a number or an operator.
  final String child;

  LaTeXLeaf({required super.id, required super.parent, required this.child});

  /// Creates a placeholder leaf, which is used to represent an empty space in the tree.
  factory LaTeXLeaf.placeHolder({required LaTeXNode parent}) {
    return _LaTeXPlaceholderLeaf(
      id: "${parent.id}-pholder",
      parent: parent,
      child: '',
    );
  }

  @override
  String get getType => LEType.essentialLeaf.name;

  /// Returns the LaTeX string for the leaf, which is just its content.
  @override
  String computeLaTeXString() {
    return child;
  }
}

/// A concrete implementation of a placeholder leaf.
class _LaTeXPlaceholderLeaf extends LaTeXLeaf {
  _LaTeXPlaceholderLeaf({
    required super.id,
    required super.parent,
    required super.child,
  });

  @override
  String get getType => LEType.placeHolderLeaf.name;
}
