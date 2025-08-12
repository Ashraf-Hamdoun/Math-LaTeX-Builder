import 'package:math_latex_builder/src/constants/directions.dart';
import 'package:math_latex_builder/src/constants/latex_element_type.dart';
import 'package:math_latex_builder/src/core/latex_node.dart';
import 'package:math_latex_builder/src/elements/latex_trunk.dart';
import 'package:math_latex_builder/src/elements/nodes/latex_fraction_node.dart';
import 'package:math_latex_builder/src/elements/nodes/latex_integral_node.dart';
import 'package:math_latex_builder/src/elements/nodes/latex_nth_root_node.dart';
import 'package:math_latex_builder/src/elements/nodes/latex_summation_node.dart';
import 'package:math_latex_builder/src/utiles/leaves_generator.dart';
import 'package:math_latex_builder/src/utiles/nodes_generator.dart';

/// The main class for building and manipulating mathematical expressions.
///
/// `LaTeXTree` provides a user-friendly interface for constructing complex
/// math expressions programmatically. It abstracts the underlying tree structure,
/// managing the cursor and active node automatically.
///
/// Use this class to add, remove, and navigate through elements of an expression.
class LaTeXTree {
  final LaTeXTrunk _trunk = LaTeXTrunk(id: 't-0');
  late LaTeXNode _activeParent;

  /// Creates a new, empty math expression tree.
  LaTeXTree() {
    _trunk.clear();
    _activeParent = _trunk;
    _trunk.enterNode();
  }

  /// Returns the full LaTeX string representation of the expression.
  ///
  /// This string is suitable for rendering with any LaTeX engine.
  /// The '|' character indicates the current cursor position.
  String toLaTeXString() => _trunk.toLaTeXString();

  /// Adds a leaf element (e.g., number, operator) to the expression at the
  /// current cursor position.
  ///
  /// [type] specifies the type of leaf, and [content] is its value.
  void addChildLeaf(LEType type, String content) {
    final leaf = leavesGenerator(
      parent: _activeParent,
      type: type,
      content: content,
    );

    _activeParent.addChildLeaf(leaf);
  }

  /// Adds a structural node (e.g., fraction, root) to the expression at the
  /// current cursor position.
  ///
  /// The cursor automatically moves into the new node's primary input field.
  /// For example, after adding a `fractionNode`, the cursor will be in the
  /// numerator.
  void addChildNode(LEType type, {String content = ''}) {
    final node = nodesGenerator(
      parent: _activeParent,
      type: type,
      content: content,
    );

    _activeParent.addChildNode(node);
    _activeParent.leaveNode();
    if (node is LaTeXFractionNode) {
      _activeParent = node.numerator;
    } else if (node is LaTeXNthRootNode) {
      _activeParent = node.indexOfRoot;
    } else if (node is LaTeXIntegralNode) {
      _activeParent = node.lowerLimit;
    } else if (node is LaTeXSummationNode) {
      _activeParent = node.lowerLimit;
    } else {
      _activeParent = node;
    }
    _activeParent.enterNode();
  }

  /// Moves the cursor in the specified [direction].
  bool _move(Direction direction) {
    final oldLatex = toLaTeXString();
    _activeParent.leaveNode();
    _activeParent = _activeParent.move(direction);
    _activeParent.enterNode();
    return oldLatex != toLaTeXString();
  }

  /// Moves the cursor up to the parent node or a node in an upper position.
  bool moveUp() => _move(Direction.up);

  /// Moves the cursor down to a child node or a node in a lower position.
  bool moveDown() => _move(Direction.down);

  /// Moves the cursor one position to the left.
  bool moveLeft() => _move(Direction.left);

  /// Moves the cursor one position to the right.
  bool moveRight() => _move(Direction.right);

  /// Clears the entire expression tree, resetting it to an empty state.
  bool clear() {
    final oldLatex = toLaTeXString();
    if (oldLatex == r'\(|\)') return false;

    _activeParent.leaveNode();
    _trunk.clear();
    _activeParent = _trunk;
    _activeParent.enterNode();
    return true;
  }

  /// Deletes the element immediately to the left of the cursor.
  ///
  /// If the cursor is at the beginning of a node, this may delete the node
  /// itself if it's empty, or move the cursor out of the node.
  bool delete() {
    final oldLatex = toLaTeXString();
    final node = _activeParent.deleteActiveChild();
    if (node != null) {
      // The active parent might change after a deletion.
      _activeParent.leaveNode();
      _activeParent = node;
      _activeParent.enterNode();
    }
    return oldLatex != toLaTeXString();
  }
}
