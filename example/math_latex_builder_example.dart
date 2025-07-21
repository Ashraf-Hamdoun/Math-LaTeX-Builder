import 'package:math_latex_builder/math_latex_builder.dart';

void main(List<String> args) {
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

  print("result : ${tree.toLaTeXString}");
  // 4+\frac{15-\sqrt{7}}{\sqrt[9]{\frac{3}{8|}}}
}
