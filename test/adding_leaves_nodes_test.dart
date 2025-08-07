import 'package:math_latex_builder/math_latex_builder.dart';
import 'package:test/test.dart';

void main() {
  group("LaTeX Tree", () {
    test('should add leaves correctly.', () {
      final LaTeXTree tree = LaTeXTree();
      tree.addChildLeaf(LEType.numberLeaf, "5");
      tree.addChildLeaf(LEType.operatorLeaf, "+");
      tree.addChildLeaf(LEType.numberLeaf, "1");
      tree.addChildLeaf(LEType.specialSymbolLeaf, 'times');
      tree.addChildLeaf(LEType.variableLeaf, 'f');
      expect(tree.toLaTeXString, '5+1\\timesf|');
    });

    test("should add function node correctly", () {
      final LaTeXTree tree = LaTeXTree();
      tree.addChildLeaf(LEType.numberLeaf, "1");
      tree.addChildLeaf(LEType.operatorLeaf, "-");
      tree.addChildNode(LEType.functionNode, content: 'sin');
      tree.addChildLeaf(LEType.numberLeaf, "8");
      tree.addChildLeaf(LEType.numberLeaf, "5");
      expect(tree.toLaTeXString, '1-\\sin(85|)');
    });

    test("should add inversed function node correctly", () {
      final LaTeXTree tree = LaTeXTree();
      tree.addChildLeaf(LEType.numberLeaf, "1");
      tree.addChildLeaf(LEType.operatorLeaf, "-");
      tree.addChildNode(LEType.inverseFunctionNode, content: 'sin');
      tree.addChildLeaf(LEType.numberLeaf, "8");
      tree.addChildLeaf(LEType.numberLeaf, "5");
      expect(tree.toLaTeXString, '1-\\sin(85|)^{-1}');
    });

    test("should add fractoin node correctly", () {
      final LaTeXTree tree = LaTeXTree();
      tree.addChildLeaf(LEType.numberLeaf, "2");
      tree.addChildLeaf(LEType.operatorLeaf, "+");
      tree.addChildNode(LEType.fractionNode);
      tree.addChildLeaf(LEType.numberLeaf, "8");
      expect(tree.toLaTeXString, '2+\\frac{8|}{\\square}');
    });

    test("should add square root node correctly", () {
      final LaTeXTree tree = LaTeXTree();
      tree.addChildLeaf(LEType.numberLeaf, "4");
      tree.addChildLeaf(LEType.operatorLeaf, "-");
      tree.addChildNode(LEType.squareRootNode);
      tree.addChildLeaf(LEType.numberLeaf, "9");
      expect(tree.toLaTeXString, '4-\\sqrt{9|}');
    });

    test("should add cube root node correctly", () {
      final LaTeXTree tree = LaTeXTree();
      tree.addChildLeaf(LEType.numberLeaf, "3");
      tree.addChildLeaf(LEType.operatorLeaf, "-");
      tree.addChildNode(LEType.cubeRootNode);
      tree.addChildLeaf(LEType.numberLeaf, "8");
      expect(tree.toLaTeXString, '3-\\sqrt[3]{8|}');
    });

    test("should add nth root node correctly", () {
      final LaTeXTree tree = LaTeXTree();
      tree.addChildLeaf(LEType.numberLeaf, "5");
      tree.addChildLeaf(LEType.operatorLeaf, "+");
      tree.addChildNode(LEType.nthRootNode);
      tree.addChildLeaf(LEType.numberLeaf, "4");
      expect(tree.toLaTeXString, '5+\\sqrt[4|]{\\square}');
    });

    test("should add power node correctly", () {
      final LaTeXTree tree = LaTeXTree();
      tree.addChildLeaf(LEType.numberLeaf, "7");
      tree.addChildNode(LEType.powerNode);
      tree.addChildLeaf(LEType.numberLeaf, "4");
      tree.addChildLeaf(LEType.numberLeaf, "5");
      expect(tree.toLaTeXString, '7^{45|}');
    });

    test("should add summation node correctly", () {
      final LaTeXTree tree = LaTeXTree();
      tree.addChildNode(LEType.summationNode);
      tree.addChildLeaf(LEType.variableLeaf, "n");
      tree.addChildLeaf(LEType.operatorLeaf, "=");
      tree.addChildLeaf(LEType.numberLeaf, "0");
      tree.moveUp();
      tree.addChildLeaf(LEType.symbolLeaf, "\\infty");
      tree.moveRight();
      tree.addChildLeaf(LEType.textLeaf, "f(n)");
      expect(tree.toLaTeXString, '\\sum_{n=0}^{\\infty}\\text{f(n)}|');
    });
  });
}
