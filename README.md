
# Math LaTeX Builder

[![pub version](https://img.shields.io/pub/v/math_latex_builder.svg)](https://pub.dev/packages/math_latex_builder)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![stable](https://img.shields.io/badge/stability-stable-brightgreen)](#)


> **Status:** This package is considered **stable** and ready for production use.

## Programmatic LaTeX Math Expression Construction for Dart & Flutter

The `math_latex_builder` is a robust and intuitive Dart package engineered for the programmatic construction and manipulation of complex LaTeX mathematical expressions. Moving beyond rudimentary string concatenation, this library introduces a sophisticated tree-based data model, enabling developers to build, traverse, and modify mathematical formulas with unparalleled precision and control.

Ideal for educational applications, scientific tools, dynamic formula editors, or any Dart/Flutter project requiring the generation of intricate mathematical notation, `math_latex_builder` streamlines the process of creating syntactically correct and semantically rich LaTeX output.

## Key Capabilities

-   **🌳 Hierarchical Tree-Based Model**: Represents LaTeX expressions as a logical, navigable tree structure, where nodes encapsulate structural elements (e.g., fractions, roots, integrals) and leaves represent atomic components (e.g., numbers, operators, variables). This architectural choice ensures robust management and manipulation of arbitrarily complex expressions.
-   **✍️ Granular Cursor-Based Manipulation**: Features an advanced cursor mechanism that defines the active insertion or modification point within the expression tree. This allows for precise, programmatic navigation (`moveUp`, `moveDown`, `moveLeft`, `moveRight`) and targeted insertion or deletion of elements, mimicking an intelligent mathematical text editor.
-   **🧮 Comprehensive LaTeX Element Support**: Provides out-of-the-box support for a wide array of standard LaTeX mathematical constructs, including:
    -   Fractions (`\frac{...}{...}`)
    -   Roots (Square `\sqrt{...}`, Cube `\sqrt[3]{...}`, Nth `\sqrt[n]{...}`)
    -   Powers and Superscripts (`^{...}`)
    -   Functions (e.g., `\sin(...)`, `\cos(...)`) and Inverse Functions (`\sin^{-1}(...)`)
    -   Integrals (`\int_{...}^{...}{...}`)
    -   Summations (`\sum_{...}^{...}{...}`)
    -   Standard operators, numbers, variables (e.g., `$x# Math LaTeX Builder

[![pub version](https://img.shields.io/pub/v/math_latex_builder.svg)](https://pub.dev/packages/math_latex_builder)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## Programmatic LaTeX Math Expression Construction for Dart & Flutter

The `math_latex_builder` is a robust and intuitive Dart package engineered for the programmatic construction and manipulation of complex LaTeX mathematical expressions. Moving beyond rudimentary string concatenation, this library introduces a sophisticated tree-based data model, enabling developers to build, traverse, and modify mathematical formulas with unparalleled precision and control.

Ideal for educational applications, scientific tools, dynamic formula editors, or any Dart/Flutter project requiring the generation of intricate mathematical notation, `math_latex_builder` streamlines the process of creating syntactically correct and semantically rich LaTeX output.

## Key Capabilities

-   **🌳 Hierarchical Tree-Based Model**: Represents LaTeX expressions as a logical, navigable tree structure, where nodes encapsulate structural elements (e.g., fractions, roots, integrals) and leaves represent atomic components (e.g., numbers, operators, variables). This architectural choice ensures robust management and manipulation of arbitrarily complex expressions.
-   **✍️ Granular Cursor-Based Manipulation**: Features an advanced cursor mechanism that defines the active insertion or modification point within the expression tree. This allows for precise, programmatic navigation (`moveUp`, `moveDown`, `moveLeft`, `moveRight`) and targeted insertion or deletion of elements, mimicking an intelligent mathematical text editor.
-   **🧮 Comprehensive LaTeX Element Support**: Provides out-of-the-box support for a wide array of standard LaTeX mathematical constructs, including:
    -   Fractions (`\frac{...}{...}`)
    -   Roots (Square `\sqrt{...}`, Cube `\sqrt[3]{...}`, Nth `\sqrt[n]{...}`)
    -   Powers and Superscripts (`^{...}`)
    -   Functions (e.g., `\sin(...)`, `\cos(...)`) and Inverse Functions (`\sin^{-1}(...)`)
    -   Integrals (`\int_{...}^{...}{...}`)
    -   Summations (`\sum_{...}^{...}{...}`)
    ), and symbols.
-   **🚀 Pure Dart & Cross-Platform Compatibility**: Developed entirely in Dart, ensuring seamless integration and consistent performance across all Dart and Flutter supported platforms (Web, Mobile, Desktop).
-   **⚡️ Optimized Performance**: Employs a "dirty-checking" mechanism to intelligently recompute only the modified segments of the LaTeX string, minimizing overhead and ensuring efficient rendering, particularly for dynamic or frequently updated expressions.


## Visual Demonstration

![Package Demo](https://place-hold.it/700x400?text=Dynamic+LaTeX+Generation+Demo)

*The above is a placeholder. Replace with a real GIF or screenshot to showcase dynamic LaTeX building and cursor navigation for best results.*

---

## Architectural Foundation: The LaTeX Expression Tree

At its core, `math_latex_builder` abstracts the complexity of LaTeX syntax into an intuitive object-oriented tree.

-   **`LaTeXTree`**: The primary entry point for interaction, managing the entire expression and its state.
-   **Active Node (Cursor)**: A dynamic pointer within the tree, dictating where subsequent operations (additions, deletions) will occur.
-   **`LaTeXNode`**: Abstract base class for structural LaTeX elements that can contain child elements (e.g., `FractionNode`, `NthRootNode`, `IntegralNode`).
-   **`LaTeXLeaf`**: Abstract base class for terminal LaTeX elements representing atomic content (e.g., `NumberLeaf`, `OperatorLeaf`, `VariableLeaf`).

When a new `LaTeXNode` is introduced, the cursor intelligently positions itself within the node's primary input field (e.g., the numerator of a fraction), ready for immediate content population.

## Getting Started

Integrate `math_latex_builder` into your Dart or Flutter project by adding it to your `pubspec.yaml`:

```yaml
dependencies:
  math_latex_builder: ^1.0.18 # Always use the latest stable version
```

Then, execute `flutter pub get` or `dart pub get` to fetch the package.

Import the library in your Dart code:

```dart
import 'package:math_latex_builder/math_latex_builder.dart';
```

## Usage Examples

### Basic Expression Construction: `5 + 1`

The `|` character in the output string denotes the current cursor position within the LaTeX expression.

```dart
import 'package:math_latex_builder/math_latex_builder.dart';

void main() {
  final tree = LaTeXTree();
  print(tree.toLaTeXString); // Output: \(|\) (Empty tree, cursor at root)

  tree.addChildLeaf(LEType.numberLeaf, "5");
  print(tree.toLaTeXString); // Output: \(5|\)

  tree.addChildLeaf(LEType.operatorLeaf, "+");
  print(tree.toLaTeXString); // Output: \(5+|\)

  tree.addChildLeaf(LEType.numberLeaf, "1");
  print(tree.toLaTeXString); // Output: \(5+1|\)
}
```

### Constructing a Fraction: `2 + 8/5`

Demonstrates adding a structural node and navigating its sub-elements.

```dart
final tree = LaTeXTree();

tree.addChildLeaf(LEType.numberLeaf, "2");
tree.addChildLeaf(LEType.operatorLeaf, "+");
  print(tree.toLaTeXString); // Output: \(2+|\)

// Add a fraction node; cursor automatically moves to the numerator.
tree.addChildNode(LEType.fractionNode);
  print(tree.toLaTeXString); // Output: \(2+\frac{ |}{\square}\)

// Populate the numerator.
tree.addChildLeaf(LEType.numberLeaf, "8");
  print(tree.toLaTeXString); // Output: \(2+\frac{8|}{\square}\)

// Move the cursor to the denominator.
tree.moveDown();
  print(tree.toLaTeXString); // Output: \(2+\frac{8}{ |}\)

// Populate the denominator.
tree.addChildLeaf(LEType.numberLeaf, "5");
  print(tree.toLaTeXString); // Output: \(2+\frac{8}{5|}\)
```

### Integral Expression: `\int_{0}^{\infty} f(x) dx`

```dart
final tree = LaTeXTree();

tree.addChildNode(LEType.integralNode); // Cursor moves to lower limit
tree.addChildLeaf(LEType.numberLeaf, "0");
  print(tree.toLaTeXString); // Output: \(\int_{0|}^{\square}\square\)

tree.moveUp(); // Move to upper limit
tree.addChildLeaf(LEType.specialSymbolLeaf, "infty"); // \infty
  print(tree.toLaTeXString); // Output: \(\int_{0}^{\infty|}\square\)

tree.moveRight(); // Move to integrand
tree.addChildLeaf(LEType.textLeaf, "f(x)");
  print(tree.toLaTeXString); // Output: \(\int_{0}^{\infty}\text{f(x)}|\)

// For a complete integral, you might manually append 'dx' or similar
// depending on your rendering needs, as the tree focuses on the mathematical structure.
```

## API Reference

The `math_latex_builder` API is designed for clarity and ease of use:

-   **`LaTeXTree`**: The central class for managing the LaTeX expression.
    -   `addChildLeaf(LEType type, String content)`: Appends a new leaf element (e.g., number, operator, symbol) at the current cursor position.
    -   `addChildNode(LEType type, {String content = ""})`: Inserts a new structural node (e.g., fraction, root, power) at the cursor. The cursor then automatically moves into the node's primary input field.
    -   `moveUp()`, `moveDown()`, `moveLeft()`, `moveRight()`: Navigates the cursor through the expression tree. These methods intelligently handle transitions between nested nodes.
    -   `delete()`: Removes the element or node immediately to the left of the cursor. Handles complex node deletions gracefully.
    -   `clear()`: Resets the entire expression tree to an empty state.
    -   `toLaTeXString`: A getter that returns the fully rendered LaTeX string of the current expression, including the cursor marker.
-   **`LEType`**: An enumeration defining all supported types of LaTeX leaves and nodes, ensuring type-safe and explicit element creation.

## Advanced Topics & Extensibility

-   **Interactive User Interfaces**: The `LaTeXTree`'s cursor-based manipulation and `toLaTeXString` output make it perfectly suited for integration with custom on-screen keyboards or interactive UI components in Flutter, enabling users to build complex equations dynamically.
-   **Custom Rendering**: As `math_latex_builder` outputs standard LaTeX strings, it can be seamlessly paired with any LaTeX rendering engine (e.g., `flutter_math_fork` for Flutter, or external LaTeX compilers) to achieve desired visual styles, fonts, and display properties.
-   **Extending Functionality**: The modular design, based on `LaTeXNode` and `LaTeXLeaf` abstractions, allows developers to easily extend the package by implementing custom subclasses for new LaTeX commands or specialized mathematical structures not natively supported.
-   **State Management**: The `isDirty` flag and `setDirty()` mechanism within `LaTeXElement` provide an efficient way to manage state and trigger re-renders only when necessary, which is beneficial for performance in reactive frameworks.

## Contributing

We welcome contributions from the community! If you encounter any bugs, have feature requests, or wish to contribute code, please refer to our [issue tracker](https://github.com/Ashraf-Hamdoun/Math-LaTeX-Builder/issues) and consider opening a pull request. Adherence to existing code style and testing practices is appreciated.

## License

This package is distributed under the [MIT License](LICENSE).
