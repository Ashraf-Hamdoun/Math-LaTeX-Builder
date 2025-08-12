import 'package:math_latex_builder/math_latex_builder.dart';
import 'package:test/test.dart';

void main() {
  group('LaTeXTree - Deleting Elements', () {
    late LaTeXTree tree;

    setUp(() {
      tree = LaTeXTree();
    });

    test('should delete leaves correctly', () {
      tree.addChildLeaf(LEType.numberLeaf, '5');
      tree.addChildLeaf(LEType.operatorLeaf, '+');
      tree.addChildLeaf(LEType.numberLeaf, '9');
      tree.addChildLeaf(LEType.numberLeaf, '0');

      expect(tree.toLaTeXString(), r'\(5+90|\)');

      tree.delete();

      expect(tree.toLaTeXString(), r'\(5+9|\)');

      tree.moveLeft();
      tree.delete();

      expect(tree.toLaTeXString(), r'\(5|9\)');

      tree.addChildLeaf(LEType.operatorLeaf, '-');

      expect(tree.toLaTeXString(), r'\(5-|9\)');
    });

    test('should delete function node if it is empty', () {
      tree.addChildLeaf(LEType.numberLeaf, '1');
      tree.addChildLeaf(LEType.operatorLeaf, '-');
      tree.addChildNode(LEType.functionNode, content: 'f');
      tree.addChildLeaf(LEType.variableLeaf, 'x');

      expect(tree.toLaTeXString(), r'\(1-\f(x|)\)');

      tree.delete(); // Delete x
      tree.delete(); // Delete empty function node

      expect(tree.toLaTeXString(), r'\(1-|\)');
    });

    test('should delete fraction node if it is empty', () {
      tree.addChildLeaf(LEType.numberLeaf, '5');
      tree.addChildLeaf(LEType.operatorLeaf, '+');
      tree.addChildNode(LEType.fractionNode);
      tree.addChildLeaf(LEType.numberLeaf, '9');
      tree.addChildLeaf(LEType.numberLeaf, '0');

      expect(tree.toLaTeXString(), r'\(5+\frac{90|}{\square}\)');

      tree.delete(); // Delete 0
      tree.delete(); // Delete 9
      tree.delete(); // Delete empty fraction node

      expect(tree.toLaTeXString(), r'\(5+|\)');
    });

    test('should delete nth root node if it is empty', () {
      tree.addChildLeaf(LEType.numberLeaf, '5');
      tree.addChildLeaf(LEType.operatorLeaf, '+');
      tree.addChildNode(LEType.nthRootNode);
      tree.addChildLeaf(LEType.numberLeaf, '4');
      tree.moveRight();
      tree.addChildLeaf(LEType.numberLeaf, '9');

      expect(tree.toLaTeXString(), r'\(5+\sqrt[4]{9|}\)');

      tree.delete(); // Delete 9

      tree.moveLeft(); // Move to index of root
      tree.delete(); // Delete 4
      tree.delete(); // Delete empty nth root node

      expect(tree.toLaTeXString(), r'\(5+|\)');
    });

    test('should delete integral node if all its children are empty', () {
      tree.addChildLeaf(LEType.numberLeaf, '1');
      tree.addChildLeaf(LEType.operatorLeaf, '+');
      tree.addChildNode(LEType.integralNode);
      tree.addChildLeaf(LEType.numberLeaf, '0');

      expect(tree.toLaTeXString(), r'\(1+\int_{0|}^{\square}\square\)');

      tree.moveUp(); // Move to upper limit
      tree.delete(); // Delete Upper (back to lower because upper limit is empty)
      tree.moveRight(); // Move to summand and delete it (it's empty)
      tree.delete(); // Delete the summand

      // Now it backs to Upper because intgrand is empty
      tree.moveDown(); // Move to lover limit
      tree.delete(); // Delete lower content

      // Delete lower limit (it's empty)
      tree.delete(); // Now the integral node itself should be deleted

      expect(tree.toLaTeXString(), r'\(1+|\)');
    });

    test('should delete summation node if all its children are empty', () {
      tree.addChildLeaf(LEType.numberLeaf, '1');
      tree.addChildLeaf(LEType.operatorLeaf, '+');
      tree.addChildNode(LEType.summationNode);
      tree.addChildLeaf(LEType.numberLeaf, '0');

      expect(tree.toLaTeXString(), r'\(1+\sum_{0|}^{\square}\square\)');

      tree.moveUp(); // Move to upper limit
      tree.delete(); // Delete Upper (back to lower because upper limit is empty)
      tree.moveRight(); // Move to summand and delete it (it's empty)
      tree.delete(); // Delete the summand

      // Now it backs to Upper because summand is empty
      tree.moveDown(); // Move to lover limit
      tree.delete(); // Delete lower content

      // Delete lower limit (it's empty)
      tree.delete(); // Now the summation node itself should be deleted

      expect(tree.toLaTeXString(), r'\(1+|\)');
    });
  });
}
