import 'package:math_latex_builder/math_latex_builder.dart';
import 'package:test/test.dart';

void main() {
  group("Clear tree", () {
    test("should be cleared", () {
      final LaTeXTree tree = LaTeXTree();
      tree.addChildLeaf(LEType.numberLeaf, "1");
      tree.addChildLeaf(LEType.operatorLeaf, "-");
      tree.addChildNode(LEType.functionNode, content: 'sin');
      tree.addChildLeaf(LEType.numberLeaf, "8");
      tree.addChildLeaf(LEType.numberLeaf, "5");
      expect(tree.toLaTeXString(), '\\(1-\\sin(85|)\\)');

      tree.clear();
      expect(tree.toLaTeXString(), "\\(|\\)");
    });
  });
}
