# Math LaTeX Builder

[![pub version](https://img.shields.io/pub/v/math_latex_builder.svg)](https://pub.dev/packages/math_latex_builder)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![stable](https://img.shields.io/badge/stability-stable-brightgreen)](#)

**Status:** This package is considered **stable** and ready for production use.

## Programmatic LaTeX Math Expression Construction for Dart & Flutter

The `math_latex_builder` is a robust and intuitive Dart package engineered for the programmatic construction and manipulation of complex LaTeX mathematical expressions. Moving beyond rudimentary string concatenation, this library introduces a sophisticated tree-based data model, enabling developers to build, traverse, and modify mathematical formulas with unparalleled precision and control.

Ideal for educational applications, scientific tools, dynamic formula editors, or any Dart/Flutter project requiring the generation of intricate mathematical notation, `math_latex_builder` streamlines the process of creating syntactically correct and semantically rich LaTeX output.

## Table of Contents

- [Key Features](#key-features)
- [Visual Demonstration](#visual-demonstration)
- [Architectural Foundation](#architectural-foundation)
- [Getting Started](#getting-started)
- [Usage Examples](#usage-examples)
  - [Using `LaTeXTree`](#using-latextree)
  - [Using `LaTeXInputController`](#using-latexinputcontroller)
- [API Reference](#api-reference)
- [Advanced Topics & Extensibility](#advanced-topics--extensibility)
- [Contributing](#contributing)
- [License](#license)

## Key Features

-   **🌳 Hierarchical Tree-Based Model**: Represents LaTeX expressions as a logical, navigable tree structure, where nodes encapsulate structural elements (e.g., fractions, roots, integrals) and leaves represent atomic components (e.g., numbers, operators, variables). This architectural choice ensures robust management and manipulation of arbitrarily complex expressions.
-   **✍️ Granular Cursor-Based Manipulation**: Features an advanced cursor mechanism that defines the active insertion or modification point within the expression tree. This allows for precise, programmatic navigation (`moveUp`, `moveDown`, `moveLeft`, `moveRight`) and targeted insertion or deletion of elements, mimicking an intelligent mathematical text editor.
-   **🧮 Comprehensive LaTeX Element Support**: Provides out-of-the-box support for a wide array of standard LaTeX mathematical constructs, including:
    -   Fractions (`\frac{...}{...}`)
    -   Roots (Square `\sqrt{...}`, Cube `\sqrt[3]{...}`, Nth `\sqrt[n]{...}`)
    -   Powers and Superscripts (`^{...}`)
    -   Functions (e.g., `\sin(...)`, `\cos(...)`) and Inverse Functions (`\sin^{-1}(...)`)
    -   Integrals (`\int_{...}^{...}{...}`)
    -   Summations (`\sum_{...}^{...}{...}`)
    -   Standard operators, numbers, variables, and symbols.
-   **🚀 Pure Dart & Cross-Platform Compatibility**: Developed entirely in Dart, ensuring seamless integration and consistent performance across all Dart and Flutter supported platforms (Web, Mobile, Desktop).
-   **⚡️ Optimized Performance**: Employs a "dirty-checking" mechanism to intelligently recompute only the modified segments of the LaTeX string, minimizing overhead and ensuring efficient rendering, particularly for dynamic or frequently updated expressions.

## Visual Demonstration

![Package Demo](https://place-hold.it/700x400?text=Showcase+Your+Package+Here)

*The above is a placeholder. For best results, replace it with a GIF or video demonstrating dynamic LaTeX building, cursor navigation, and integration with a UI.*

---

## Architectural Foundation

At its core, `math_latex_builder` abstracts the complexity of LaTeX syntax into an intuitive object-oriented tree.

-   **`LaTeXTree`**: The primary entry point for interaction, managing the entire expression and its state.
-   **Active Node (Cursor)**: A dynamic pointer within the tree, dictating where subsequent operations (additions, deletions) will occur.
-   **`LaTeXNode`**: Abstract base class for structural LaTeX elements that can contain child elements (e.g., `FractionNode`, `NthRootNode`, `IntegralNode`).
-   **`LaTeXLeaf`**: Abstract base class for terminal LaTeX elements representing atomic content (e.g., `NumberLeaf`, `OperatorLeaf`, `VariableLeaf`).

When a new `LaTeXNode` is introduced, the cursor intelligently positions itself within the node\'s primary input field (e.g., the numerator of a fraction), ready for immediate content population.

## Getting Started

Integrate `math_latex_builder` into your Dart or Flutter project by adding it to your `pubspec.yaml`:

```yaml
dependencies:
  math_latex_builder: ^1.0.20 # Always use the latest stable version
```

Then, execute `flutter pub get` or `dart pub get` to fetch the package.

Import the library in your Dart code:

```dart
import 'package:math_latex_builder/math_latex_builder.dart';
```

## Usage Examples

The `|` character in the output string denotes the current cursor position.

### Using `LaTeXTree`

The `LaTeXTree` class provides fine-grained control over the expression tree.

#### Basic Expression: `5 + 1`

```dart
import 'package:math_latex_builder/math_latex_builder.dart';

void main() {
  final tree = LaTeXTree();
  print(tree.toLaTeXString()); // Output: \(|

  tree.addChildLeaf(LEType.numberLeaf, "5");
  print(tree.toLaTeXString()); // Output: \(5|

  tree.addChildLeaf(LEType.operatorLeaf, "+");
  print(tree.toLaTeXString()); // Output: \(5+|

  tree.addChildLeaf(LEType.numberLeaf, "1");
  print(tree.toLaTeXString()); // Output: \(5+1|
}
```

#### Fraction: `2 + 8/5`

```dart
final tree = LaTeXTree();

tree.addChildLeaf(LEType.numberLeaf, "2");
tree.addChildLeaf(LEType.operatorLeaf, "+");
print(tree.toLaTeXString()); // Output: \(2+|

// Add a fraction node; cursor automatically moves to the numerator.
tree.addChildNode(LEType.fractionNode);
print(tree.toLaTeXString()); // Output: \(2+\frac{|}{\square}

// Populate the numerator.
tree.addChildLeaf(LEType.numberLeaf, "8");
print(tree.toLaTeXString()); // Output: \(2+\frac{8|}{\square}

// Move the cursor to the denominator.
tree.moveDown();
print(tree.toLaTeXString()); // Output: \(2+\frac{8}{|}

// Populate the denominator.
tree.addChildLeaf(LEType.numberLeaf, "5");
print(tree.toLaTeXString()); // Output: \(2+\frac{8}{5|}
```

#### Integral: `\int_{0}^{\infty} f(x) dx`

```dart
final tree = LaTeXTree();

tree.addChildNode(LEType.integralNode); // Cursor moves to lower limit
tree.addChildLeaf(LEType.numberLeaf, "0");
print(tree.toLaTeXString()); // Output: \(\int_{0|}^{\square}\square

tree.moveUp(); // Move to upper limit
tree.addChildLeaf(LEType.specialSymbolLeaf, "infty"); // \infty
print(tree.toLaTeXString()); // Output: \(\int_{0}^{\infty|}\square

tree.moveRight(); // Move to integrand
tree.addChildLeaf(LEType.textLeaf, "f(x)");
tree.addChildLeaf(LEType.specialSymbolLeaf, ","); // Optional space
tree.addChildLeaf(LEType.variableLeaf, "d");
tree.addChildLeaf(LEType.variableLeaf, "x");
print(tree.toLaTeXString()); // Output: \(\int_{0}^{\infty}\text{f(x)}\,dx|
```

### Using `LaTeXInputController`

For building user interfaces like calculators, the `LaTeXInputController` provides a simpler, high-level API. It wraps a `LaTeXTree` and exposes methods like `pressPlus()`, `pressFraction()`, etc.

```dart
final tree = LaTeXTree();
final controller = LaTeXInputController(tree);

// Listen for changes
controller.addListener(() {
  print(tree.toLaTeXString());
});

controller.pressSine();         // Output: \(\sin(|
controller.pressVariable("x");  // Output: \(\sin(x|
controller.moveRight();         // Output: \(\sin(x)|
controller.pressPlus();         // Output: \(\sin(x)+|
controller.pressFraction();     // Output: \(\sin(x)+\frac{|}{\square}
controller.pressOne();          // Output: \(\sin(x)+\frac{1|}{\square}
controller.moveDown();          // Output: \(\sin(x)+\frac{1}{|}
controller.pressTwo();          // Output: \(\sin(x)+\frac{1}{2|}
```

## API Reference

-   **`LaTeXTree`**: The central class for managing the expression.
    -   `toLaTeXString()`: Returns the full, rendered LaTeX string.
    -   `addChildLeaf(LEType type, String content)`: Adds an atomic element (number, operator).
    -   `addChildNode(LEType type, {String content = ""})`: Adds a structural element (fraction, root).
    -   `moveUp()`, `moveDown()`, `moveLeft()`, `moveRight()`: Navigates the cursor.
    -   `delete()`: Removes the element to the left of the cursor.
    -   `clear()`: Resets the tree.
-   **`LaTeXInputController`**: A high-level controller for UI integration.
    -   `pressNumber(String number)`, `pressPlus()`, `pressMultiply()`, etc.: Methods for adding common elements.
    -   `pressFraction()`, `pressSquareRoot()`, `pressIntegral()`, etc.: Methods for adding structural nodes.
    -   `pressSine()`, `pressVariable(String variable)`, `pressPi()`, etc.: Methods for functions and symbols.
    -   `moveUp()`, `moveDown()`, `moveLeft()`, `moveRight()`: Cursor navigation.
    -   `addListener(void Function() listener)`: Notifies of changes to the expression.
-   **`LEType`**: An enum defining all supported leaf and node types.

## Advanced Topics & Extensibility

-   **Interactive UIs**: The `LaTeXInputController` is perfectly suited for integration with custom on-screen keyboards in Flutter.
-   **Custom Rendering**: Pair the output of `toLaTeXString()` with any LaTeX rendering engine (like `flutter_math_fork`) to display the expression.
-   **Extending Functionality**: The modular design allows for creating custom `LaTeXNode` and `LaTeXLeaf` subclasses to support new LaTeX commands.
-   **State Management**: The package uses a dirty-checking mechanism to efficiently re-render only when necessary, which is beneficial for performance in reactive frameworks.

## Contributing

We welcome contributions from the community! If you encounter any bugs, have feature requests, or wish to contribute code, please refer to our [issue tracker](https://github.com/Ashraf-Hamdoun/Math-LaTeX-Builder/issues) and consider opening a pull request. Adherence to existing code style and testing practices is appreciated.

## License

This package is distributed under the [MIT License](LICENSE).