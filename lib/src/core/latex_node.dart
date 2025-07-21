import 'package:math_latex_builder/src/constants/directions.dart';
import 'package:math_latex_builder/src/utiles/handle_move.dart';
import '../constants/latex_element_type.dart';
import '../constants/strings.dart';
import 'latex_element.dart';
import 'latex_leaf.dart';

/// The base class for all LaTeX nodes.
///
/// Nodes are the building blocks of the LaTeX tree and can have children.
/// They are responsible for managing their children, their active state, and the
/// position of the cursor.
///
/// The [_isActive] flag indicates whether the node is currently active, meaning
/// it is the target for new elements.
/// The [position] determines where new children are inserted.
abstract class LaTeXNode extends LaTeXElement {
  final List<LaTeXElement> _children = [];
  final List<String> _childrenIDs = [];
  bool _isActive = false;

  /// A callback function that is called when the node is updated.
  final Function(String childId, String childValue) updateParent;

  /// The position of the cursor, used for inserting new children.
  int position = 0;

  LaTeXNode({
    required super.id,
    required super.parent,
    required this.updateParent,
  }) {
    LaTeXLeaf placeHolderLeaf = LaTeXLeaf.placeHolder(parent: this);
    _children.add(placeHolderLeaf);
    _childrenIDs.add(placeHolderLeaf.id);
  }

  /// Returns an unmodifiable list of the node's children.
  List<LaTeXElement> get children => List.unmodifiable(_children);

  /// Returns an unmodifiable list of the IDs of the node's children.
  List<String> get childrenIDs => List.unmodifiable(_childrenIDs);

  @override
  String get getType => LEType.node.name;

  @override
  String computeLaTeXString() {
    if (_children.length == 1) {
      return (_isActive) ? markOfInsertPoint : "\\square";
    } else {
      List<String> parts =
          _children.map((child) => child.toLaTeXString()).toList();
      if (_isActive) {
        parts.insert(position + 1, '|');
      }
      return parts.join();
    }
  }

  /// Called by children to notify the node of an update.
  void onUpdateChildren(String childID, String childValue) {
    setDirty();
    updateParent(id, toLaTeXString());
  }

  /// Adds a child to the node at the current position.
  void _addInsertChildToLists(LaTeXElement child) {
    _children.insert(position + 1, child);
    _childrenIDs.insert(position + 1, child.id);
  }

  /// Adds a leaf to the node and updates the cursor position.
  void addChildLeaf(LaTeXLeaf leaf) {
    _addInsertChildToLists(leaf);

    position += 1;
    setDirty();
    updateParent(id, toLaTeXString());
  }

  /// Adds a node to the node and updates the cursor position.
  void addChildNode(LaTeXNode node) {
    _addInsertChildToLists(node);

    position += 1;
    setDirty();
    updateParent(id, toLaTeXString());
  }

  /// Marks the node as active and notifies the parent of the change.
  void enterNode() {
    _isActive = true;
    setDirty();
    updateParent(id, toLaTeXString());
  }

  /// Marks the node as inactive and notifies the parent of the change.
  void leaveNode() {
    _isActive = false;
    setDirty();
    updateParent(id, toLaTeXString());
  }

  /// Moves the cursor in the specified direction.
  ///
  /// Returns the new active node after the move.
  LaTeXNode move(Direction direction) {
    return handleMove(direction, this) ?? this;
  }

  void clear() {
    position = 0;
    _children.clear();
    _childrenIDs.clear();

    LaTeXLeaf placeHolderLeaf = LaTeXLeaf.placeHolder(parent: this);
    _children.add(placeHolderLeaf);
    _childrenIDs.add(placeHolderLeaf.id);
  }

  // Delete the active child and update the cursor position.
  LaTeXNode? deleteActiveChild() {
    if (position > 0 && children.length > 1) {
      LaTeXElement activeChild = children[position];
      // Delete the active child
      _children.remove(activeChild);
      _childrenIDs.remove(activeChild.id);
      position--;

      setDirty();
      updateParent(id, toLaTeXString());
      return this;
    } else {
      if (children.length > 1) {
        // At the beginning of the node and other children are after you.
        return null;
      } else {
        // No active child to delete.
        if (parent != null) {
          // Parent is not null, i will ask parent to delete me.
          return parent!.deleteActiveChild();
        } else {
          // Parent is null, i can not delete myself.
          return null;
        }
      }
    }
  }
}

/**
   if (children.length >= 2) {
      // Remove the active child
      if (position >= 1) {
        LaTeXElement activeChild = children[position];
        print("Active child to be deleted: ${activeChild.toLaTeXString()}");

        _children.remove(activeChild);
        _childrenIDs.remove(activeChild.id);
        position--;

        setDirty();
        updateParent(id, toLaTeXString());
      }
      print('position is $position and parent is $info');
      return this;
    } else {
      return null;
    }
 */
