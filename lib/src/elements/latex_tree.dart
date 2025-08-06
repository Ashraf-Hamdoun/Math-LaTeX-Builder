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
  late LaTeXNode activeParent;

  LaTeXTree() {
    _trunk.clear();
    activeParent = _trunk;
    _trunk.enterNode();
  }

  /// Returns the LaTeX string for the entire expression.
  String get toLaTeXString => _trunk.computeLaTeXString();

  /// Adds a leaf to the active node.
  void addChildLeaf(LEType type, String content) {
    LaTeXLeaf leaf = leavesGenerator(
      parent: activeParent,
      type: type,
      content: content,
    );

    activeParent.addChildLeaf(leaf);
  }

  /// Adds a node to the active node and enters it.
  void addChildNode(LEType type, {String content = ""}) {
    LaTeXNode node = nodesGenerator(
      parent: activeParent,
      type: type,
      content: content,
    );

    activeParent.addChildNode(node);
    activeParent.leaveNode();
    if (node is LaTeXFractionNode) {
      activeParent = node.numerator;
    } else if (node is LaTeXNthRootNode) {
      activeParent = node.indexOfRoot;
    } else if (node is LaTeXIntegralNode) {
      activeParent = node.lowerLimit;
    } else if (node is LaTeXSummationNode) {
      activeParent = node.lowerLimit;
    } else {
      activeParent = node;
    }
    activeParent.enterNode();
  }

  /// Moves the cursor in the specified direction.
  void _move(Direction direction) {
    activeParent.leaveNode();
    activeParent = activeParent.move(direction);
    activeParent.enterNode();
  }

  /// Moves
  void moveUp() => _move(Direction.up);
  void moveDown() => _move(Direction.down);
  void moveLeft() => _move(Direction.left);
  void moveRight() => _move(Direction.right);

  void clear() {
    activeParent.leaveNode();
    _trunk.clear();
    activeParent = _trunk;
    activeParent.enterNode();
  }

  /// Deletes the active child and updates the cursor position.
  void delete() {
    LaTeXNode? node = activeParent.deleteActiveChild();
    if (node != null) {
      // Parent will be changed!
      activeParent.leaveNode();
      activeParent = node;
      activeParent.enterNode();
    }
  }
}
