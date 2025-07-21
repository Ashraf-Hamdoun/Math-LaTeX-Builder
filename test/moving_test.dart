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
      tree.addChildNode(LEType.functionNode, content: "sin");
      tree.addChildLeaf(LEType.numberLeaf, "x");
      tree.moveRight();
      expect(tree.toLaTeXString, "4sin(x)|");

      tree.moveLeft();
      tree.moveLeft();
      tree.moveLeft();
      expect(tree.toLaTeXString, "4|sin(x)");
    });
  });
}
