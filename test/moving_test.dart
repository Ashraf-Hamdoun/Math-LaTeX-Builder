import 'package:math_latex_builder/math_latex_builder.dart';
import 'package:test/test.dart';

void main() {
  group("LaTeXTree - Moving Cursor", () {
    late LaTeXTree tree;

    setUp(() {
      tree = LaTeXTree();
    });

    test("should move correctly within a complex expression", () {
      tree.addChildLeaf(LEType.numberLeaf, "4");
      tree.addChildLeaf(LEType.operatorLeaf, "+");
      tree.addChildNode(LEType.fractionNode);
      tree.addChildLeaf(LEType.numberLeaf, "1");
      tree.addChildLeaf(LEType.numberLeaf, "5");
      tree.addChildLeaf(LEType.operatorLeaf, "-");
      tree.addChildNode(LEType.squareRootNode);
      tree.addChildLeaf(LEType.numberLeaf, "7");
      tree.moveDown();
      tree.addChildNode(LEType.nthRootNode);
      tree.addChildLeaf(LEType.numberLeaf, "9");
      tree.moveRight();
      tree.addChildNode(LEType.fractionNode);
      tree.addChildLeaf(LEType.numberLeaf, "3");
      tree.moveDown();
      tree.addChildLeaf(LEType.numberLeaf, "8");
      tree.moveLeft();
      tree.moveLeft();

      expect(
        tree.toLaTeXString(),
        r'\(4+\frac{15-\sqrt{7}}{\sqrt[9]{|\frac{3}{8}}}\)',
      );
    });

    test('should leave and enter function node correctly', () {
      tree.addChildLeaf(LEType.numberLeaf, "4");
      tree.addChildLeaf(LEType.operatorLeaf, "+");
      tree.addChildNode(LEType.functionNode, content: "sin");
      tree.addChildLeaf(LEType.variableLeaf, "x");

      expect(tree.toLaTeXString(), r'\(4+\sin(x|)\)');

      // Leave the node
      tree.moveRight();
      expect(tree.toLaTeXString(), r'\(4+\sin(x)|\)');

      // Enter the node
      tree.moveLeft();
      expect(tree.toLaTeXString(), r'\(4+\sin(x|)\)');

      // Moving through leaves of the node.
      tree.moveLeft();
      expect(tree.toLaTeXString(), r'\(4+\sin(|x)\)');

      // Leaving the node
      tree.moveLeft();
      expect(tree.toLaTeXString(), r'\(4+|\sin(x)\)');

      // Enter the node
      tree.moveRight();
      expect(tree.toLaTeXString(), r'\(4+\sin(|x)\)');
    });

    test('should leave and enter inverse function node correctly', () {
      tree.addChildLeaf(LEType.numberLeaf, "4");
      tree.addChildLeaf(LEType.operatorLeaf, "+");
      tree.addChildNode(LEType.inverseFunctionNode, content: "sin");
      tree.addChildLeaf(LEType.variableLeaf, "x");

      expect(tree.toLaTeXString(), r'\(4+\sin^{-1}(x|)\)');

      // Leave the node
      tree.moveRight();
      expect(tree.toLaTeXString(), r'\(4+\sin^{-1}(x)|\)');

      // Enter the node
      tree.moveLeft();
      expect(tree.toLaTeXString(), r'\(4+\sin^{-1}(x|)\)');

      // Moving through leaves of the node.
      tree.moveLeft();
      expect(tree.toLaTeXString(), r'\(4+\sin^{-1}(|x)\)');

      // Leaving the node
      tree.moveLeft();
      expect(tree.toLaTeXString(), r'\(4+|\sin^{-1}(x)\)');

      // Enter the node
      tree.moveRight();
      expect(tree.toLaTeXString(), r'\(4+\sin^{-1}(|x)\)');
    });

    test('should handle integral node movement correctly', () {
      tree.addChildNode(LEType.integralNode);
      tree.addChildLeaf(LEType.numberLeaf, "0");
      tree.moveRight();
      tree.addChildLeaf(LEType.textLeaf, "f(x)");

      expect(tree.toLaTeXString(), r'\(\int_{0}^{\square}\text{f(x)}|\)');

      tree.moveLeft(); // At the start of integrand
      tree.moveLeft(); // Move to lower limit
      expect(tree.toLaTeXString(), r'\(\int_{0|}^{\square}\text{f(x)}\)');

      tree.moveUp(); // Move to upper limit
      tree.addChildLeaf(LEType.numberLeaf, '1');
      expect(tree.toLaTeXString(), r'\(\int_{0}^{1|}\text{f(x)}\)');

      tree.moveDown(); // Move back to lower limit
      expect(tree.toLaTeXString(), r'\(\int_{0|}^{1}\text{f(x)}\)');

      tree.moveRight(); // Move to integrand
      expect(tree.toLaTeXString(), r'\(\int_{0}^{1}|\text{f(x)}\)');

      tree.moveRight(); // Move to the end of integral
      tree.moveRight(); // Move out of integral
      expect(tree.toLaTeXString(), r'\(\int_{0}^{1}\text{f(x)}|\)');
    });

    test('should handle summation node movement correctly', () {
      tree.addChildNode(LEType.summationNode);
      tree.addChildLeaf(LEType.variableLeaf, "i");
      tree.addChildLeaf(LEType.operatorLeaf, "=");
      tree.addChildLeaf(LEType.numberLeaf, "1");
      tree.moveUp();
      tree.addChildLeaf(LEType.variableLeaf, "n");
      tree.moveRight();
      tree.addChildLeaf(LEType.textLeaf, "f(i)");

      expect(tree.toLaTeXString(), r'\(\sum_{i=1}^{n}\text{f(i)}|\)');

      tree.moveLeft(); // Move back to start of summand
      tree.moveLeft(); // Move to lower limit
      expect(tree.toLaTeXString(), r'\(\sum_{i=1|}^{n}\text{f(i)}\)');

      tree.moveUp(); // Move to upper limit
      expect(tree.toLaTeXString(), r'\(\sum_{i=1}^{n|}\text{f(i)}\)');

      tree.moveDown(); // Move back to lower limit
      expect(tree.toLaTeXString(), r'\(\sum_{i=1|}^{n}\text{f(i)}\)');

      tree.moveRight(); // Move to summand
      expect(tree.toLaTeXString(), r'\(\sum_{i=1}^{n}|\text{f(i)}\)');

      tree.moveRight(); // Move until the end of summand
      tree.moveRight(); // Move out of summation
      expect(tree.toLaTeXString(), r'\(\sum_{i=1}^{n}\text{f(i)}|\)');
    });
  });
}
