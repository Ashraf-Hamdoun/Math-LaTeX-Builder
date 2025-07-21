import 'package:math_latex_builder/math_latex_builder.dart';
import 'package:test/test.dart';

void main() {
  test('should delete leaves correctly', () {
    final LaTeXTree tree = LaTeXTree();

    tree.addChildLeaf(LEType.numberLeaf, '5');
    tree.addChildLeaf(LEType.operatorLeaf, '+');
    tree.addChildLeaf(LEType.numberLeaf, '9');
    tree.addChildLeaf(LEType.numberLeaf, '0');

    tree.delete();
    tree.moveLeft();
    tree.delete();

    tree.addChildLeaf(LEType.operatorLeaf, '-');

    expect(tree.toLaTeXString, equals('5-|9'));
  });

  test('should delete function node if it is empty', () {
    LaTeXTree tree = LaTeXTree();

    tree.addChildLeaf(LEType.numberLeaf, '1');
    tree.addChildLeaf(LEType.operatorLeaf, '-');
    tree.addChildNode(LEType.functionNode, content: 'f');
    tree.addChildLeaf(LEType.variableLeaf, 'x');

    tree.delete();
    tree.delete();

    expect(tree.toLaTeXString, equals('1-|'));
  });

  test('should delete fraction node if it is empty', () {
    final LaTeXTree tree = LaTeXTree();

    tree.addChildLeaf(LEType.numberLeaf, '5');
    tree.addChildLeaf(LEType.operatorLeaf, '+');
    tree.addChildNode(LEType.fractionNode);
    tree.addChildLeaf(LEType.numberLeaf, '9');
    tree.addChildLeaf(LEType.numberLeaf, '0');

    tree.delete();
    tree.delete();
    tree.delete();

    expect(tree.toLaTeXString, equals('5+|'));
  });

  test('should delete nth root node if it is empty', () {
    LaTeXTree tree = LaTeXTree();

    tree.addChildLeaf(LEType.numberLeaf, '5');
    tree.addChildLeaf(LEType.operatorLeaf, '+');
    tree.addChildNode(LEType.nthRootNode);
    tree.addChildLeaf(LEType.numberLeaf, '4');
    tree.moveRight();
    tree.addChildLeaf(LEType.numberLeaf, '9');

    tree.delete();
    tree.delete();
    tree.delete();

    expect(tree.toLaTeXString, equals('5+|'));
  });
}
