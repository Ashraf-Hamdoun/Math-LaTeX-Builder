import 'package:math_latex_builder/math_latex_builder.dart';
import 'package:test/test.dart';

void main() {
  group("LaTeXTree - Adding Elements", () {
    late LaTeXTree tree;

    setUp(() {
      tree = LaTeXTree();
    });

    test('should add leaves correctly', () {
      tree.addChildLeaf(LEType.numberLeaf, "5");
      tree.addChildLeaf(LEType.operatorLeaf, "+");
      tree.addChildLeaf(LEType.numberLeaf, "1");
      tree.addChildLeaf(LEType.specialSymbolLeaf, 'times');
      tree.addChildLeaf(LEType.variableLeaf, 'f');
      expect(tree.toLaTeXString(), r'\(5+1\timesf|\)');
    });

    test("should add function node correctly", () {
      tree.addChildLeaf(LEType.numberLeaf, "1");
      tree.addChildLeaf(LEType.operatorLeaf, "-");
      tree.addChildNode(LEType.functionNode, content: 'sin');
      tree.addChildLeaf(LEType.numberLeaf, "8");
      tree.addChildLeaf(LEType.numberLeaf, "5");

      expect(tree.toLaTeXString(), r'\(1-\sin(85|)\)');
    });

    test("should add inversed function node correctly", () {
      tree.addChildLeaf(LEType.numberLeaf, "1");
      tree.addChildLeaf(LEType.operatorLeaf, "-");
      tree.addChildNode(LEType.inverseFunctionNode, content: 'sin');
      tree.addChildLeaf(LEType.numberLeaf, "8");
      tree.addChildLeaf(LEType.numberLeaf, "5");

      expect(tree.toLaTeXString(), r'\(1-\sin^{-1}(85|)\)');
    });

    test("should add fraction node correctly", () {
      tree.addChildLeaf(LEType.numberLeaf, "2");
      tree.addChildLeaf(LEType.operatorLeaf, "+");
      tree.addChildNode(LEType.fractionNode);
      tree.addChildLeaf(LEType.numberLeaf, "8");

      expect(tree.toLaTeXString(), r'\(2+\frac{8|}{\square}\)');
    });

    test("should add square root node correctly", () {
      tree.addChildLeaf(LEType.numberLeaf, "4");
      tree.addChildLeaf(LEType.operatorLeaf, "-");
      tree.addChildNode(LEType.squareRootNode);
      tree.addChildLeaf(LEType.numberLeaf, "9");

      expect(tree.toLaTeXString(), r'\(4-\sqrt{9|}\)');
    });

    test("should add cube root node correctly", () {
      tree.addChildLeaf(LEType.numberLeaf, "3");
      tree.addChildLeaf(LEType.operatorLeaf, "-");
      tree.addChildNode(LEType.cubeRootNode);
      tree.addChildLeaf(LEType.numberLeaf, "8");

      expect(tree.toLaTeXString(), r'\(3-\sqrt[3]{8|}\)');
    });

    test("should add nth root node correctly", () {
      tree.addChildLeaf(LEType.numberLeaf, "5");
      tree.addChildLeaf(LEType.operatorLeaf, "+");
      tree.addChildNode(LEType.nthRootNode);
      tree.addChildLeaf(LEType.numberLeaf, "4");

      expect(tree.toLaTeXString(), r'\(5+\sqrt[4|]{\square}\)');
    });

    test("should add power node correctly", () {
      tree.addChildLeaf(LEType.numberLeaf, "7");
      tree.addChildNode(LEType.powerNode);
      tree.addChildLeaf(LEType.numberLeaf, "4");
      tree.addChildLeaf(LEType.numberLeaf, "5");

      expect(tree.toLaTeXString(), r'\(7^{45|}\)');
    });

    test("should add summation node correctly", () {
      tree.addChildNode(LEType.summationNode);
      tree.addChildLeaf(LEType.variableLeaf, "n");
      tree.addChildLeaf(LEType.operatorLeaf, "=");
      tree.addChildLeaf(LEType.numberLeaf, "0");
      tree.moveUp();
      tree.addChildLeaf(LEType.specialSymbolLeaf, "infty");
      tree.moveRight();
      tree.addChildLeaf(LEType.textLeaf, "f(n)");

      expect(tree.toLaTeXString(), r'\(\sum_{n=0}^{\infty}\text{f(n)}|\)');
    });

    test("should add integral node correctly", () {
      tree.addChildNode(LEType.integralNode);
      tree.addChildLeaf(LEType.variableLeaf, "a");
      tree.moveUp();
      tree.addChildLeaf(LEType.variableLeaf, "b");
      tree.moveRight();
      tree.addChildLeaf(LEType.variableLeaf, "f");
      tree.addChildLeaf(LEType.variableLeaf, "(");
      tree.addChildLeaf(LEType.variableLeaf, "x");
      tree.addChildLeaf(LEType.variableLeaf, ")");
      tree.addChildLeaf(LEType.variableLeaf, "d");
      tree.addChildLeaf(LEType.variableLeaf, "x");

      expect(tree.toLaTeXString(), r'\(\int_{a}^{b}f(x)dx|\)');
    });
  });
}
