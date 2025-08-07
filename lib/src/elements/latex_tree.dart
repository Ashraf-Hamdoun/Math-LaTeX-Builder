import 'package:math_latex_builder/src/constants/directions.dart';
import 'package:math_latex_builder/src/constants/latex_element_type.dart';
import 'package:math_latex_builder/src/core/latex_leaf.dart';
import 'package:math_latex_builder/src/core/latex_node.dart';
import 'package:math_latex_builder/src/elements/latex_trunk.dart';
import 'package:math_latex_builder/src/elements/nodes/latex_fraction_node.dart';
import 'package:math_latex_builder/src/elements/nodes/latex_integral_node.dart';
import 'package:math_latex_builder/src/elements/nodes/latex_nth_root_node.dart';
import 'package:math_latex_builder/src/elements/nodes/latex_summation_node.dart';
import 'package:math_latex_builder/src/utiles/leaves_generator.dart';
import 'package:math_latex_builder/src/utiles/nodes_generator.dart';

/// The main class for building LaTeX expressions.
///
/// This class provides a simple interface for creating and manipulating LaTeX
/// expressions. It manages the underlying tree structure and the active node,
/// making it easy to add new elements and move the cursor.
class LaTeXTree {
  final LaTeXTrunk _trunk = LaTeXTrunk(id: "t-0");
  late LaTeXNode _activeParent;

  LaTeXTree() {
    _trunk.clear();
    _activeParent = _trunk;
    _trunk.enterNode();
  }

  /// Returns the LaTeX string for the entire expression.
  String toLaTeXString() => "\\(${_trunk.computeLaTeXString()}\\)";

  /// Adds a leaf to the active node.
  void addChildLeaf(LEType type, String content) {
    LaTeXLeaf leaf = leavesGenerator(
      parent: _activeParent,
      type: type,
      content: content,
    );

    _activeParent.addChildLeaf(leaf);
  }

  /// Adds a node to the active node and enters it.
  void addChildNode(LEType type, {String content = ""}) {
    LaTeXNode node = nodesGenerator(
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

  /// Moves the cursor in the specified direction.
  void _move(Direction direction) {
    _activeParent.leaveNode();
    _activeParent = _activeParent.move(direction);
    _activeParent.enterNode();
  }

  /// Moves
  void moveUp() => _move(Direction.up);
  void moveDown() => _move(Direction.down);
  void moveLeft() => _move(Direction.left);
  void moveRight() => _move(Direction.right);

  void clear() {
    _activeParent.leaveNode();
    _trunk.clear();
    _activeParent = _trunk;
    _activeParent.enterNode();
  }

  /// Deletes the active child and updates the cursor position.
  void delete() {
    LaTeXNode? node = _activeParent.deleteActiveChild();
    if (node != null) {
      // Parent will be changed!
      _activeParent.leaveNode();
      _activeParent = node;
      _activeParent.enterNode();
    }
  }
}
