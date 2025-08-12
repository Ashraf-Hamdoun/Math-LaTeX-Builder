import 'package:math_latex_builder/math_latex_builder.dart';

/// A controller to simplify adding common mathematical inputs to a [MathTree].
///
/// This class provides an intuitive, "button-press" like interface for building
/// expressions, abstracting away the underlying `LEType` and content details.
/// It is ideal for creating UIs like on-screen calculators.
///
/// It also includes a listener pattern to notify consumers of changes to the
/// expression tree.
class LaTeXInputController {
  final LaTeXTree _laTeXTree;
  final List<void Function()> _listeners = [];

  /// Creates a controller that modifies the given [laTeXTree].
  LaTeXInputController(this._laTeXTree);

  /// Adds a [listener] that will be called whenever the expression changes.
  void addListener(void Function() listener) {
    _listeners.add(listener);
  }

  /// Removes a previously added [listener].
  void removeListener(void Function() listener) {
    _listeners.remove(listener);
  }

  /// Notifies all registered listeners of a change.
  void _notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }

  /// Adds the number 0 to the expression.
  void pressZero() {
    _laTeXTree.addChildLeaf(LEType.numberLeaf, '0');
    _notifyListeners();
  }

  /// Adds the number 1 to the expression.
  void pressOne() {
    _laTeXTree.addChildLeaf(LEType.numberLeaf, '1');
    _notifyListeners();
  }

  /// Adds the number 2 to the expression.
  void pressTwo() {
    _laTeXTree.addChildLeaf(LEType.numberLeaf, '2');
    _notifyListeners();
  }

  /// Adds the number 3 to the expression.
  void pressThree() {
    _laTeXTree.addChildLeaf(LEType.numberLeaf, '3');
    _notifyListeners();
  }

  /// Adds the number 4 to the expression.
  void pressFour() {
    _laTeXTree.addChildLeaf(LEType.numberLeaf, '4');
    _notifyListeners();
  }

  /// Adds the number 5 to the expression.
  void pressFive() {
    _laTeXTree.addChildLeaf(LEType.numberLeaf, '5');
    _notifyListeners();
  }

  /// Adds the number 6 to the expression.
  void pressSix() {
    _laTeXTree.addChildLeaf(LEType.numberLeaf, '6');
    _notifyListeners();
  }

  /// Adds the number 7 to the expression.
  void pressSeven() {
    _laTeXTree.addChildLeaf(LEType.numberLeaf, '7');
    _notifyListeners();
  }

  /// Adds the number 8 to the expression.
  void pressEight() {
    _laTeXTree.addChildLeaf(LEType.numberLeaf, '8');
    _notifyListeners();
  }

  /// Adds the number 9 to the expression.
  void pressNine() {
    _laTeXTree.addChildLeaf(LEType.numberLeaf, '9');
    _notifyListeners();
  }

  /// Adds a custom number string to the expression.
  void pressNumber(String number) {
    _laTeXTree.addChildLeaf(LEType.numberLeaf, number);
    _notifyListeners();
  }

  /// Adds the addition operator (+) to the expression.
  void pressPlus() {
    _laTeXTree.addChildLeaf(LEType.operatorLeaf, '+');
    _notifyListeners();
  }

  /// Adds the subtraction operator (-) to the expression.
  void pressMinus() {
    _laTeXTree.addChildLeaf(LEType.operatorLeaf, '-');
    _notifyListeners();
  }

  /// Adds the multiplication operator (×) to the expression.
  void pressMultiply() {
    _laTeXTree.addChildLeaf(LEType.specialSymbolLeaf, 'times');
    _notifyListeners();
  }

  /// Adds the division operator (÷) to the expression.
  void pressDivide() {
    _laTeXTree.addChildLeaf(LEType.specialSymbolLeaf, 'div');
    _notifyListeners();
  }

  /// Adds a custom operator string to the expression.
  void pressOperator(String operator) {
    _laTeXTree.addChildLeaf(LEType.operatorLeaf, operator);
    _notifyListeners();
  }

  /// Adds a fraction node to the expression.
  void pressFraction() {
    _laTeXTree.addChildNode(LEType.fractionNode);
    _notifyListeners();
  }

  /// Adds a square root node to the expression.
  void pressSquareRoot() {
    _laTeXTree.addChildNode(LEType.squareRootNode);
    _notifyListeners();
  }

  /// Adds a cube root node to the expression.
  void pressCubeRoot() {
    _laTeXTree.addChildNode(LEType.cubeRootNode);
    _notifyListeners();
  }

  /// Adds an nth root node to the expression.
  void pressNthRoot() {
    _laTeXTree.addChildNode(LEType.nthRootNode);
    _notifyListeners();
  }

  /// Adds a power node (superscript) to the expression.
  void pressPower() {
    _laTeXTree.addChildNode(LEType.powerNode);
    _notifyListeners();
  }

  /// Adds an integral node to the expression.
  void pressIntegral() {
    _laTeXTree.addChildNode(LEType.integralNode);
    _notifyListeners();
  }

  /// Adds a summation node to the expression.
  void pressSummation() {
    _laTeXTree.addChildNode(LEType.summationNode);
    _notifyListeners();
  }

  /// Adds a function node (e.g., `sin`, `cos`) to the expression.
  void pressFunction(String functionName) {
    _laTeXTree.addChildNode(LEType.functionNode, content: functionName);
    _notifyListeners();
  }

  /// Adds the sine function to the expression.
  void pressSine() => pressFunction('sin');

  /// Adds the cosine function to the expression.
  void pressCosine() => pressFunction('cos');

  /// Adds the tangent function to the expression.
  void pressTangent() => pressFunction('tan');

  /// Adds the natural logarithm (ln) function to the expression.
  void pressNaturalLog() => pressFunction('ln');

  /// Adds the base-10 logarithm (log) function to the expression.
  void pressLog() => pressFunction('log');

  /// Adds the inverse sine function to the expression.
  void pressInversedSine() => pressInverseFunction('sin');

  /// Adds the inverse cosine function to the expression.
  void pressInversedCosine() => pressInverseFunction('cos');

  /// Adds the inverse tangent function to the expression.
  void pressInversedTangent() => pressInverseFunction('tan');

  /// Adds the symbol for Pi (π) to the expression.
  void pressPi() => pressSpecialSymbol('pi');

  /// Adds the symbol for Euler's number (e) to the expression.
  void pressEuler() => pressVariable('e');

  /// Adds a left parenthesis to the expression.
  void pressLeftParenthesis() => pressSymbol('(');

  /// Adds a right parenthesis to the expression.
  void pressRightParenthesis() => pressSymbol(')');

  /// Adds a left bracket to the expression.
  void pressLeftBracket() => pressSymbol('[');

  /// Adds a right bracket to the expression.
  void pressRightBracket() => pressSymbol(']');

  /// Adds a left brace to the expression.
  void pressLeftBrace() => pressSymbol('{');

  /// Adds a right brace to the expression.
  void pressRightBrace() => pressSymbol('}');

  /// Adds an inverse function node to the expression.
  void pressInverseFunction(String functionName) {
    _laTeXTree.addChildNode(LEType.inverseFunctionNode, content: functionName);
    _notifyListeners();
  }

  /// Adds a variable leaf to the expression.
  void pressVariable(String variable) {
    _laTeXTree.addChildLeaf(LEType.variableLeaf, variable);
    _notifyListeners();
  }

  /// Adds a symbol leaf to the expression.
  void pressSymbol(String symbol) {
    _laTeXTree.addChildLeaf(LEType.symbolLeaf, symbol);
    _notifyListeners();
  }

  /// Adds a special symbol leaf (a LaTeX command) to the expression.
  void pressSpecialSymbol(String symbol) {
    _laTeXTree.addChildLeaf(LEType.specialSymbolLeaf, symbol);
    _notifyListeners();
  }

  /// Adds a text leaf to the expression.
  void pressText(String text) {
    _laTeXTree.addChildLeaf(LEType.textLeaf, text);
    _notifyListeners();
  }

  /// Moves the cursor up in the expression tree.
  void moveUp() {
    if (_laTeXTree.moveUp()) {
      _notifyListeners();
    }
  }

  /// Moves the cursor down in the expression tree.
  void moveDown() {
    if (_laTeXTree.moveDown()) {
      _notifyListeners();
    }
  }

  /// Moves the cursor left in the expression tree.
  void moveLeft() {
    if (_laTeXTree.moveLeft()) {
      _notifyListeners();
    }
  }

  /// Moves the cursor right in the expression tree.
  void moveRight() {
    if (_laTeXTree.moveRight()) {
      _notifyListeners();
    }
  }

  /// Deletes the element at the current cursor position.
  void pressDelete() {
    if (_laTeXTree.delete()) {
      _notifyListeners();
    }
  }

  /// Clears the entire expression tree.
  void pressClear() {
    if (_laTeXTree.clear()) {
      _notifyListeners();
    }
  }
}
