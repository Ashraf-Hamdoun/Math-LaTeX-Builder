import 'package:math_latex_builder/math_latex_builder.dart';

void main(List<String> args) {
  final LaTeXTree tree = LaTeXTree();

  // \text{y}
  tree.addChildLeaf(LEType.textLeaf, "y");

  // =
  tree.addChildLeaf(LEType.operatorLeaf, "=");

  // 1
  tree.addChildLeaf(LEType.numberLeaf, "1");

  // -
  tree.addChildLeaf(LEType.operatorLeaf, "-");

  // Main fraction: \frac{NUMERATOR}{DENOMINATOR}
  tree.addChildNode(LEType.fractionNode); // Cursor is in the numerator

  // NUMERATOR: \text{f}^{\text{n}}[\frac{\text{s}\\.1}{\text{f}}+\(\frac{15-\sqrt{7}})^{\text{w}}]
  // \text{f}
  tree.addChildLeaf(LEType.textLeaf, "f");

  // ^{\text{n}}
  tree.addChildNode(LEType.powerNode); // Cursor is in the power
  tree.addChildLeaf(LEType.textLeaf, "n");
  tree.moveRight(); // Move out of power node

  // [
  tree.addChildLeaf(LEType.symbolLeaf, "[");

  // Inner fraction: \frac{\text{s}\\.1}{\text{f}}
  tree.addChildNode(LEType.fractionNode); // Cursor is in the numerator
  // Numerator: \text{s}\\.1
  tree.addChildLeaf(LEType.textLeaf, "s");
  tree.addChildLeaf(LEType.symbolLeaf, ".");
  tree.addChildLeaf(LEType.numberLeaf, "1");
  tree.moveDown(); // Move to denominator
  // Denominator: \text{f}
  tree.addChildLeaf(LEType.textLeaf, "f");
  tree.moveRight(); // Move out of inner fraction

  // +
  tree.addChildLeaf(LEType.operatorLeaf, "+");

  // (\frac{15-\sqrt{7}})^{\text{w}}
  tree.addChildLeaf(LEType.symbolLeaf, "(");
  // \frac{15-\sqrt{7}} (Note: This is interpreted as a fraction with an empty denominator as per the input string)
  tree.addChildNode(LEType.fractionNode); // Cursor is in the numerator
  // Numerator: 15-\sqrt{7}
  tree.addChildLeaf(LEType.numberLeaf, "1");
  tree.addChildLeaf(LEType.numberLeaf, "5");
  tree.addChildLeaf(LEType.operatorLeaf, "-");
  tree.addChildNode(LEType.squareRootNode); // Cursor is in the square root
  tree.addChildLeaf(LEType.numberLeaf, "7");
  tree.moveRight(); // Move out of square root

  tree.moveDown(); // go to denominator
  // Denominator: \text{f}
  tree.addChildLeaf(LEType.textLeaf, "f");

  tree.moveRight(); // Move out of the fraction (leaving denominator empty)

  // )
  tree.addChildLeaf(LEType.symbolLeaf, ")");

  // ^{\text{w}}
  tree.addChildNode(LEType.powerNode); // Cursor is in the power
  tree.addChildLeaf(LEType.textLeaf, "w");
  tree.moveRight(); // Move out of power node

  // ]
  tree.addChildLeaf(LEType.symbolLeaf, "]");

  // Move to DENOMINATOR of main fraction
  tree.moveDown();

  // DENOMINATOR: (\sqrt[9]{\frac{3}{8|}})^{\text{n}}
  // (
  tree.addChildLeaf(LEType.symbolLeaf, "(");

  // \sqrt[9]{\frac{3}{8|}}
  tree.addChildNode(LEType.nthRootNode); // Cursor is in the index of root
  tree.addChildLeaf(LEType.numberLeaf, "9");
  tree.moveRight(); // Move to radicand
  tree.addChildNode(LEType.fractionNode); // Cursor is in the numerator
  tree.addChildLeaf(LEType.numberLeaf, "3");
  tree.moveDown(); // Move to denominator
  tree.addChildLeaf(LEType.numberLeaf,
      "8"); // Cursor is now after 8, inside the denominator. This is the final cursor position.

  // )
  tree.moveRight(); // Move out of inner fraction
  tree.moveRight(); // Move out of nth root node
  tree.addChildLeaf(LEType.symbolLeaf, ")");

  // ^{\text{n}}
  tree.addChildNode(LEType.powerNode); // Cursor is in the power
  tree.addChildLeaf(LEType.textLeaf, "n");
  tree.moveRight(); // Move out of power node

  print("Result: ${tree.toLaTeXString}");
  // output:
  // \text{y}=1-\frac{\text{f}^{\text{n}}[\frac{\text{s}.1}{\text{f}}+(\frac{15-\sqrt{7}}{\text{f}})^{\text{w}}]}{(\sqrt[9]{\frac{3}{8}})^{\text{n}}|}
}
