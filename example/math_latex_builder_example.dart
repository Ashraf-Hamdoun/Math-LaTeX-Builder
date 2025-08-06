import 'package:math_latex_builder/math_latex_builder.dart';

void main(List<String> args) {
  final LaTeXTree tree = LaTeXTree();

  // Start building the expression: y
  tree.addChildLeaf(LEType.variableLeaf, "y");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \$y\$|

  // Add the equals sign: y =
  tree.addChildLeaf(LEType.operatorLeaf, "=");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \$y\$=

  // Add the number 1: y = 1
  tree.addChildLeaf(LEType.numberLeaf, "1");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \$y\$=1|

  // Add the minus sign: y = 1 -
  tree.addChildLeaf(LEType.operatorLeaf, "-");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \$y\$=1-|

  // Add the main fraction node. The cursor automatically moves into its numerator.
  tree.addChildNode(LEType.fractionNode);
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \$y\$=1-\\frac{ |}{\\square}

  // --- Building the NUMERATOR of the main fraction ---
  // Target: f^n[frac{s.1}{f}+(frac{15-sqrt{7}}{f})^w]

  // Add variable 'f': f
  tree.addChildLeaf(LEType.variableLeaf, "f");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \$y\$=1-\\frac{\$f\$|}{\\square}

  // Add a power node for 'n'. Cursor moves into the power.
  tree.addChildNode(LEType.powerNode);
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \$y\$=1-\\frac{\$f\$^{\$|}}{\\square}

  // Add variable 'n' to the power.
  tree.addChildLeaf(LEType.variableLeaf, "n");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \$y\$=1-\\frac{\$f\$^{\$n\$|}{\\square}

  // Move out of the power node. Cursor is now after f^n.
  tree.moveRight();
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \$y\$=1-\\frac{\$f\$^{\$n\$}|}{\\square}

  // Add opening bracket: [
  tree.addChildLeaf(LEType.symbolLeaf, "[");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \$y\$=1-\\frac{\$f\$^{\$n\$}[|]}{\\square}

  // Add inner fraction node. Cursor moves into its numerator.
  // Target: frac{s.1}{f}
  tree.addChildNode(LEType.fractionNode);
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \$y\$=1-\\frac{\$f\$^{\$n\$}[\\frac{ |}{\\square}]}{\\square}

  // Numerator of inner fraction: s.1
  tree.addChildLeaf(LEType.variableLeaf, "s");
  tree.addChildLeaf(LEType.symbolLeaf, ".");
  tree.addChildLeaf(LEType.numberLeaf, "1");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \$y\$=1-\\frac{\$f\$^{\$n\$}[\\frac{\$s\$.1|}{\\square}]}{\\square}

  // Move to denominator of inner fraction.
  tree.moveDown();
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \$y\$=1-\\frac{\$f\$^{\$n\$}[\\frac{\$s\$.1}{\\square|}]}{\\square}

  // Denominator of inner fraction: f
  tree.addChildLeaf(LEType.variableLeaf, "f");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \$y\$=1-\\frac{\$f\$^{\$n\$}[\\frac{\$s\$.1}{\$f\$|}]}{\\square}

  // Move out of the inner fraction. Cursor is now after the inner fraction.
  tree.moveRight();
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \$y\$=1-\\frac{\$f\$^{\$n\$}[\\frac{\$s\$.1}{\$f\$}|]}{\\square}

  // Add plus operator: +
  tree.addChildLeaf(LEType.operatorLeaf, "+");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \$y\$=1-\\frac{\$f\$^{\$n\$}[\\frac{\$s\$.1}{\$f\$}+|]}{\\square}

  // Add opening parenthesis: (
  tree.addChildLeaf(LEType.symbolLeaf, "(");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \$y\$=1-\\frac{\$f\$^{\$n\$}[\\frac{\$s\$.1}{\$f\$}+(\\frac{ |}{\\square})]}{\\square}

  // Add another fraction node. Cursor moves into its numerator.
  // Target: frac{15-sqrt{7}}{f}
  tree.addChildNode(LEType.fractionNode);
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \$y\$=1-\\frac{\$f\$^{\$n\$}[\\frac{\$s\$.1}{\$f\$}+(\\frac{ |}{\\square})]}{\\square}

  // Numerator of this fraction: 15-sqrt{7}
  tree.addChildLeaf(LEType.numberLeaf, "1");
  tree.addChildLeaf(LEType.numberLeaf, "5");
  tree.addChildLeaf(LEType.operatorLeaf, "-");
  tree.addChildNode(
      LEType.squareRootNode); // Cursor moves into the square root.
  tree.addChildLeaf(LEType.numberLeaf, "7");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \$y\$=1-\\frac{\$f\$^{\$n\$}[\\frac{\$s\$.1}{\$f\$}+(\\frac{15-\\sqrt{7|} }{\\square})]}{\\square}

  // Move out of the square root.
  tree.moveRight();
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \$y\$=1-\\frac{\$f\$^{\$n\$}[\\frac{\$s\$.1}{\$f\$}+(\\frac{15-\\sqrt{7}|}{\\square})]}{\\square}

  // Move to denominator of this fraction.
  tree.moveDown();
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \$y\$=1-\\frac{\$f\$^{\$n\$}[\\frac{\$s\$.1}{\$f\$}+(\\frac{15-\\sqrt{7}}{ |})]}{\\square}

  // Denominator of this fraction: f
  tree.addChildLeaf(LEType.variableLeaf, "f");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \$y\$=1-\\frac{\$f\$^{\$n\$}[\\frac{\$s\$.1}{\$f\$}+(\\frac{15-\\sqrt{7}}{\$f\$|})]}{\\square}

  // Move out of this fraction.
  tree.moveRight();
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \$y\$=1-\\frac{\$f\$^{\$n\$}[\\frac{\$s\$.1}{\$f\$}+(\\frac{15-\\sqrt{7}}{\$f\$})|]}{\\square}

  // Add closing parenthesis: )
  tree.addChildLeaf(LEType.symbolLeaf, ")");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \$y\$=1-\\frac{\$f\$^{\$n\$}[\\frac{\$s\$.1}{\$f\$}+(\\frac{15-\\sqrt{7}}{\$f\$})^{\$w\$}]}{(\\sqrt[9]{\\frac{3}{8}})^{\$n\$}|}

  print("\nFinal Result: ${tree.toLaTeXString}");
  // Expected Final Output:
  // \$y\$=1-\\frac{\$f\$^{\$n\$}[\\frac{\$s\$.1}{\$f\$}+(\\frac{15-\\sqrt{7}}{\$f\$})^{\$w\$}]}{(\\sqrt[9]{\\frac{3}{8}})^{\$n\$}|}
}
