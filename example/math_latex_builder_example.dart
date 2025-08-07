import 'package:math_latex_builder/math_latex_builder.dart';

void main(List<String> args) {
  final LaTeXTree tree = LaTeXTree();

  print("\n--- Example 1: Complex Fraction with Powers and Roots ---\n");
  // Start building the expression: y
  tree.addChildLeaf(LEType.variableLeaf, "y");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y|

  // Add the equals sign: y =
  tree.addChildLeaf(LEType.operatorLeaf, "=");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=

  // Add the number 1: y = 1
  tree.addChildLeaf(LEType.numberLeaf, "1");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=1|

  // Add the minus sign: y = 1 -
  tree.addChildLeaf(LEType.operatorLeaf, "-");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=1-|

  // Add the main fraction node. The cursor automatically moves into its numerator.
  tree.addChildNode(LEType.fractionNode);
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=1-\\frac{ |}{\\square}

  // --- Building the NUMERATOR of the main fraction ---
  // Target: f^n[frac{s.1}{f}+(frac{15-sqrt{7}}{f})^w]

  // Add variable 'f': f
  tree.addChildLeaf(LEType.variableLeaf, "f");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=1-\\frac{f|}{\\square}

  // Add a power node for 'n'. Cursor moves into the power.
  tree.addChildNode(LEType.powerNode);
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=1-\\frac{f^{|}}{\\square}

  // Add variable 'n' to the power.
  tree.addChildLeaf(LEType.variableLeaf, "n");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=1-\\frac{f^{n|}{\\square}

  // Move out of the power node. Cursor is now after f^n.
  tree.moveRight();
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=1-\\frac{f^{n}|}{\\square}

  // Add opening bracket: [
  tree.addChildLeaf(LEType.symbolLeaf, "[");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=1-\\frac{f^{n}[|]}{\\square}

  // Add inner fraction node. Cursor moves into its numerator.
  // Target: frac{s.1}{f}
  tree.addChildNode(LEType.fractionNode);
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=1-\\frac{f^{n}[\\frac{ |}{\\square}]}{\\square}

  // Numerator of inner fraction: s.1
  tree.addChildLeaf(LEType.variableLeaf, "s");
  tree.addChildLeaf(LEType.symbolLeaf, ".");
  tree.addChildLeaf(LEType.numberLeaf, "1");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=1-\\frac{f^{n}[\\frac{s.1|}{\\square}]}{\\square}

  // Move to denominator of inner fraction.
  tree.moveDown();
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=1-\\frac{f^{n}[\\frac{s.1}{\\square|}]}{\\square}

  // Denominator of inner fraction: f
  tree.addChildLeaf(LEType.variableLeaf, "f");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=1-\\frac{f^{n}[\\frac{s.1}{f|}]}{\\square}

  // Move out of the inner fraction. Cursor is now after the inner fraction.
  tree.moveRight();
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=1-\\frac{f^{n}[\\frac{s.1}{f}|]}{\\square}

  // Add plus operator: +
  tree.addChildLeaf(LEType.operatorLeaf, "+");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=1-\\frac{f^{n}[\\frac{s.1}{f}+|]}{\\square}

  // Add opening parenthesis: (
  tree.addChildLeaf(LEType.symbolLeaf, "(");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=1-\\frac{f^{n}[\\frac{s.1}{f}+(\\frac{ |}{\\square})]}{\\square}

  // Add another fraction node. Cursor moves into its numerator.
  // Target: frac{15-sqrt{7}}{f}
  tree.addChildNode(LEType.fractionNode);
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=1-\\frac{f^{n}[\\frac{s.1}{f}+(\\frac{ |}{\\square})]}{\\square}

  // Numerator of this fraction: 15-sqrt{7}
  tree.addChildLeaf(LEType.numberLeaf, "1");
  tree.addChildLeaf(LEType.numberLeaf, "5");
  tree.addChildLeaf(LEType.operatorLeaf, "-");
  tree.addChildNode(
      LEType.squareRootNode); // Cursor moves into the square root.
  tree.addChildLeaf(LEType.numberLeaf, "7");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=1-\\frac{f^{n}[\\frac{s.1}{f}+(\\frac{15-\\sqrt{7|} }{\\square})]}{\\square}

  // Move out of the square root.
  tree.moveRight();
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=1-\\frac{f^{n}[\\frac{s.1}{f}+(\\frac{15-\\sqrt{7}|}{\\square})]}{\\square}

  // Move to denominator of this fraction.
  tree.moveDown();
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=1-\\frac{f^{n}[\\frac{s.1}{f}+(\\frac{15-\\sqrt{7}}{ |})]}{\\square}

  // Denominator of this fraction: f
  tree.addChildLeaf(LEType.variableLeaf, "f");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=1-\\frac{f^{n}[\\frac{s.1}{f}+(\\frac{15-\\sqrt{7}}{f|})]}{\\square}

  // Move out of this fraction.
  tree.moveRight();
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=1-\\frac{f^{n}[\\frac{s.1}{f}+(\\frac{15-\\sqrt{7}}{f})|]}{\\square}

  // Add closing parenthesis: )
  tree.addChildLeaf(LEType.symbolLeaf, ")");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=1-\\frac{f^{n}[\\frac{s.1}{f}+(\\frac{15-\\sqrt{7}}{f})|]}{\\square}

  // Add a power node for 'w' to the last fraction in the numerator
  tree.addChildNode(LEType.powerNode);
  tree.addChildLeaf(LEType.variableLeaf, "w");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=1-\\frac{f^{n}[\\frac{s.1}{f}+(\\frac{15-\\sqrt{7}}{f})^{w}|]}{\\square}

  // Move out of the power node (now after the powered fraction)
  tree.moveRight();

  // Move to the denominator of the main fraction
  tree.moveDown();
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=1-\\frac{f^{n}[\\frac{s.1}{f}+(\\frac{15-\\sqrt{7}}{f})^{w}]}{|}

  // Add a root node with index 9
  tree.addChildNode(LEType.nthRootNode);
  tree.addChildLeaf(LEType.numberLeaf, "9");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=1-\\frac{f^{n}[\\frac{s.1}{f}+(\\frac{15-\\sqrt{7}}{f})^{w}]}{\\sqrt[9]{|}}

  // Move into the radicand (the root's main content)
  tree.moveRight();

  // Add a fraction inside the root
  tree.addChildNode(LEType.fractionNode);
  tree.addChildLeaf(LEType.numberLeaf, "3");
  tree.moveDown();
  tree.addChildLeaf(LEType.numberLeaf, "8");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=1-\\frac{f^{n}[\\frac{s.1}{f}+(\\frac{15-\\sqrt{7}}{f})^{w}]}{\\sqrt[9]{\\frac{3}{8}|}}

  // Move out of the fraction and root
  tree.moveRight();
  tree.moveRight();

  // Add a power node for 'n' to the root
  tree.addChildNode(LEType.powerNode);
  tree.addChildLeaf(LEType.variableLeaf, "n");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: y=1-\\frac{f^{n}[\\frac{s.1}{f}+(\\frac{15-\\sqrt{7}}{f})^{w}]}{(\\sqrt[9]{\\frac{3}{8}})^{n}|}

  print("\nFinal Result: ${tree.toLaTeXString}");
  // Expected Final Output:
  // y=1-\\frac{f^{n}[\\frac{s.1}{f}+(\\frac{15-\\sqrt{7}}{f})^{w}]}{(\\sqrt[9]{\\frac{3}{8}})^{n}|}

  // --- Example 2: Complex Integral ---
  print("\n--- Example 2: Complex Integral ---\n");
  // clear the tree to add new exemple.
  tree.clear();

  // Build: \int_{a}^{b}x^{2}\,\sin(x)dx+C
  tree.addChildNode(LEType.integralNode);
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \int_{|}^{\square}\square

  // Lower limit: a
  tree.addChildLeaf(LEType.variableLeaf, "a");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \int_{a|}^{\square}\square

  tree.moveUp();
  // Upper limit: b
  tree.addChildLeaf(LEType.variableLeaf, "b");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \int_{a}^{b|}\square

  tree.moveRight();
  // Integrand: x
  tree.addChildLeaf(LEType.variableLeaf, "x");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \int_{a}^{b}x|

  // Add power node for 2
  tree.addChildNode(LEType.powerNode);
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \int_{a}^{b}x^{|}

  tree.addChildLeaf(LEType.numberLeaf, "2");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \int_{a}^{b}x^{2|}

  tree.moveRight();
  // Add multiplication (optional)
  tree.addChildLeaf(LEType.specialSymbolLeaf, ",");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \int_{a}^{b}x^{2}\,|

  // Add sin(x)
  tree.addChildNode(LEType.functionNode, content: "sin");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \int_{a}^{b}x^{2}\,\sin(|)

  tree.addChildLeaf(LEType.variableLeaf, "x");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \int_{a}^{b}x^{2}\,\sin(x|)

  tree.moveRight();
  // Add dx
  tree.addChildLeaf(LEType.variableLeaf, "d");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \int_{a}^{b}x^{2}\,\sin(x)d|

  tree.addChildLeaf(LEType.variableLeaf, "x");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \int_{a}^{b}x^{2}\,\sin(x)dx|

  // Move cursor to the end of the integrand to add a constant of integration (e.g., +C)
  tree.addChildLeaf(LEType.operatorLeaf, "+");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \int_{a}^{b}x^{2}\,\sin(x)dx+|

  tree.addChildLeaf(LEType.variableLeaf, "C");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \int_{a}^{b}x^{2}\,\sin(x)dx+C|

  print("\nFinal Result: ${tree.toLaTeXString}");
  // Expected Final Output:
  // \int_{a}^{b}x^{2}\,\sin(x)dx+C|

  // --- Example 3: Complex Summation ---
  print("\n--- Example 3: Complex Summation ---\n");
  // clear the tree to add new exemple.
  tree.clear();

  // Build: \sum_{i=1}^{n}(2i+1)^{2}+k|
  tree.addChildNode(LEType.summationNode);
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \sum_{|}^{\square}\square

  // Lower limit: i
  tree.addChildLeaf(LEType.variableLeaf, "i");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \sum_{i|}^{\square}\square

  tree.addChildLeaf(LEType.operatorLeaf, "=");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \sum_{i=|}^{\square}\square

  tree.addChildLeaf(LEType.numberLeaf, "1");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \sum_{i=1|}^{\square}\square

  tree.moveUp();
  // Upper limit: n
  tree.addChildLeaf(LEType.variableLeaf, "n");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \sum_{i=1}^{n|}\square

  tree.moveRight();
  // Summand: (
  tree.addChildLeaf(LEType.symbolLeaf, "(");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \sum_{i=1}^{n}(|

  tree.addChildLeaf(LEType.numberLeaf, "2");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \sum_{i=1}^{n}(2|

  tree.addChildLeaf(LEType.variableLeaf, "i");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \sum_{i=1}^{n}(2i|

  tree.addChildLeaf(LEType.operatorLeaf, "+");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \sum_{i=1}^{n}(2i+|

  tree.addChildLeaf(LEType.numberLeaf, "1");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \sum_{i=1}^{n}(2i+1|

  tree.addChildLeaf(LEType.symbolLeaf, ")");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \sum_{i=1}^{n}(2i+1)|

  tree.addChildNode(LEType.powerNode);
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \sum_{i=1}^{n}(2i+1)^{|}

  tree.addChildLeaf(LEType.numberLeaf, "2");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \sum_{i=1}^{n}(2i+1)^{2|}

  // Add an operator and a variable to complete the summand (e.g., +k)
  tree.addChildLeaf(LEType.operatorLeaf, "+");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \sum_{i=1}^{n}(2i+1)^{2}+|

  tree.addChildLeaf(LEType.variableLeaf, "k");
  print("Current LaTeX: ${tree.toLaTeXString}");
  // Output: \sum_{i=1}^{n}(2i+1)^{2}+k|

  print("\nFinal Result: ${tree.toLaTeXString}");
  // Expected Final Output:
  // \sum_{i=1}^{n}(2i+1)^{2}+k|
}
