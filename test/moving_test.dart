import 'package:math_latex_builder/math_latex_builder.dart';
import 'package:test/test.dart';

void main() {
  group("Movig between nodes", () {
    test("should move correctly", () {
      final LaTeXTree tree = LaTeXTree();

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
        tree.toLaTeXString,
        "4+\\frac{15-\\sqrt{7}}{\\sqrt[9]{|\\frac{3}{8}}}",
      );
    });

    test('should leave and enter function node correctly', () {
      final LaTeXTree tree = LaTeXTree();

      tree.addChildLeaf(LEType.numberLeaf, "4");
      tree.addChildLeaf(LEType.operatorLeaf, "+");
      tree.addChildNode(LEType.functionNode, content: "sin");
      print("test the result of adding.");
      tree.addChildLeaf(LEType.variableLeaf, "x");
      expect(tree.toLaTeXString, "4+\\sin(\\x|)");

      // Leave the node
      print("test the result of leaving the node form right side.");
      tree.moveRight();
      expect(tree.toLaTeXString, "4+\\sin(\\x)|");

      // Enter the node
      print("test the result of entering form right side.");
      tree.moveLeft();
      expect(tree.toLaTeXString, "4+\\sin(\\x|)");

      // Moving throw leaves of the node.
      print("test the result of moving inside the node.");
      tree.moveLeft();
      expect(tree.toLaTeXString, "4+\\sin(|\\x)");

      // Leaving the node
      print("test the result of leaving form left side.");
      tree.moveLeft();
      expect(tree.toLaTeXString, "4+|\\sin(\\x)");

      // Enter the node
      print("test the result of entering form left side.");
      tree.moveRight();
      expect(tree.toLaTeXString, "4+\\sin(|\\x)");
    });

    test('should leave and enter inverse function node correctly', () {
      final LaTeXTree tree = LaTeXTree();

      tree.addChildLeaf(LEType.numberLeaf, "4");
      tree.addChildLeaf(LEType.operatorLeaf, "+");
      tree.addChildNode(LEType.inverseFunctionNode, content: "sin");
      print("test the result of adding.");
      tree.addChildLeaf(LEType.variableLeaf, "x");
      expect(tree.toLaTeXString, "4+\\sin(\\x|)^{-1}");

      // Leave the node
      print("test the result of leaving the node form right side.");
      tree.moveRight();
      expect(tree.toLaTeXString, "4+\\sin(\\x)^{-1}|");

      // Enter the node
      print("test the result of entering form right side.");
      tree.moveLeft();
      expect(tree.toLaTeXString, "4+\\sin(\\x|)^{-1}");

      // Moving throw leaves of the node.
      print("test the result of moving inside the node.");
      tree.moveLeft();
      expect(tree.toLaTeXString, "4+\\sin(|\\x)^{-1}");

      // Leaving the node
      print("test the result of leaving form left side.");
      tree.moveLeft();
      expect(tree.toLaTeXString, "4+|\\sin(\\x)^{-1}");

      // Enter the node
      print("test the result of entering form left side.");
      tree.moveRight();
      expect(tree.toLaTeXString, "4+\\sin(|\\x)^{-1}");
    });

    test('should handle integral node correctly', () {
      final LaTeXTree tree = LaTeXTree();

      tree.addChildNode(LEType.integralNode);
      tree.addChildLeaf(LEType.numberLeaf, "0");
      tree.moveRight();
      tree.addChildLeaf(LEType.textLeaf, "f(x)");
      expect(tree.toLaTeXString, "\\int_{0}^{\\square}\\text{f(x)}|");

      tree.moveLeft();
      expect(tree.toLaTeXString, "\\int_{0}^{\\square}|\\text{f(x)}");

      tree.moveLeft();
      tree.delete();
      tree.addChildLeaf(LEType.variableLeaf, "a");
      expect(tree.toLaTeXString, "\\int_{\\a|}^{\\square}\\text{f(x)}");

      tree.moveUp();
      tree.addChildLeaf(LEType.variableLeaf, "b");
      expect(tree.toLaTeXString, "\\int_{\\a}^{\\b|}\\text{f(x)}");
    });
  });
}
