# Math LaTeX Builder

[![pub version](https://img.shields.io/pub/v/math_latex_builder.svg)](https://pub.dev/packages/math_latex_builder)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A powerful and intuitive Dart package to programmatically build, manipulate, and render LaTeX math expressions using a tree-based structure.

Say goodbye to messy string concatenation. This package provides a robust object-oriented approach to handle complex math formulas with ease, making it ideal for educational apps, scientific calculators, or any Flutter/Dart project that requires dynamic LaTeX generation.

## Key Features

-   **🌳 Intuitive Tree-Based Model**: Represents LaTeX expressions as a logical tree of nodes (like fractions, roots) and leaves (like numbers, operators). This makes complex expressions easy to manage.
-   **✍️ Cursor-Based Navigation and Editing**: Programmatically move a cursor `up`, `down`, `left`, or `right` through the expression tree to insert or delete elements at any position.
-   **🧮 Rich Set of LaTeX Elements**: Out-of-the-box support for common elements including fractions, square/cube/nth roots, powers, functions, and inverse functions.
-   **🚀 Pure Dart & Flutter Compatible**: Written in 100% Dart, ensuring seamless integration with any Dart or Flutter project on any platform.
-   **⚡️ Efficient & Reactive**: Uses a dirty-checking mechanism to ensure that only modified parts of the expression are recomputed, providing excellent performance.

## Visuals

*It is highly recommended to add a screenshot or a GIF to demonstrate the package in action, as it is a UI-based package.*

![Package Demo](https://place-hold.it/700x400?text=Package+Demo+GIF)

## Core Concept: The LaTeX Tree

Think of `LaTeXTree` as a structured text editor for math. Instead of a flat string, your expression lives in a tree.

-   **`LaTeXTree`**: The main class you interact with. It holds the entire expression.
-   **The Cursor (Active Node)**: The tree always has a "cursor" (an active node) that determines where new elements will be placed.
-   **`LaTeXNode`**: A structural element that can have children. Examples:
    -   `fractionNode`: Has a `numerator` and a `denominator` node.
    -   `squareRootNode`: Contains the radicand.
    -   `nthRootNode`: Has an `indexOfRoot` and a `radicand`.
-   **`LaTeXLeaf`**: A content element, like a number (`5`), an operator (`+`), or a variable (`x`). Leaves are the actual content of your expression.

When you add a node, the cursor automatically moves into the logical first part of that node (e.g., into the numerator of a fraction), ready for you to add more elements.

## Getting Started

Add this to your `pubspec.yaml` file:

```yaml
dependencies:
  math_latex_builder: ^1.0.10 # Use the latest version
```

Then, run `flutter pub get` or `dart pub get`.

Import the package in your Dart file:
```dart
import 'package:math_latex_builder/math_latex_builder.dart';
```

## Usage Examples

### Simple Example: `5+1`

The `|` character in the output string represents the current cursor position.

```dart
import 'package:math_latex_builder/math_latex_builder.dart';

void main() {
  // 1. Create a tree instance.
  final tree = LaTeXTree();
  print(tree.toLaTeXString); // Output: |

  // 2. Add a number leaf. The cursor moves after it.
  tree.addChildLeaf(LEType.numberLeaf, "5");
  print(tree.toLaTeXString); // Output: 5|

  // 3. Add an operator leaf.
  tree.addChildLeaf(LEType.operatorLeaf, "+");
  print(tree.toLaTeXString); // Output: 5+|

  // 4. Add another number leaf.
  tree.addChildLeaf(LEType.numberLeaf, "1");
  print(tree.toLaTeXString); // Output: 5+1|
}
```

### Advanced Example: Building a Fraction

To build a fraction like `2 + 8/5`, you need to add a `fractionNode` and then populate its numerator and denominator.

```dart
final tree = LaTeXTree();

// Build "2+"
tree.addChildLeaf(LEType.numberLeaf, "2");
tree.addChildLeaf(LEType.operatorLeaf, "+");
print(tree.toLaTeXString); // Output: 2+|

// Add a fraction node. The cursor automatically moves to the numerator.
tree.addChildNode(LEType.fractionNode);
print(tree.toLaTeXString); // Output: 2+\frac{ |}{\square}

// Add the numerator.
tree.addChildLeaf(LEType.numberLeaf, "8");
print(tree.toLaTeXString); // Output: 2+\frac{8|}{\square}

// Move the cursor down to the denominator.
tree.moveDown();
print(tree.toLaTeXString); // Output: 2+\frac{8}{ |}

// Add the denominator.
tree.addChildLeaf(LEType.numberLeaf, "5");
print(tree.toLaTeXString); // Output: 2+\frac{8}{5|}
```

### Inverse Function Example

```dart
final tree = LaTeXTree();

tree.addChildNode(LEType.inverseFunctionNode, content: 'sin');
tree.addChildLeaf(LEType.numberLeaf, '0');
tree.addChildLeaf(LEType.symbolLeaf, '.');
tree.addChildLeaf(LEType.numberLeaf, '5');

print(tree.toLaTeXString); // Output: \sin(0.5|)^{-1}
```

### Complex Example

Here is the code to generate the expression `4+\frac{15-\sqrt{7}}{\sqrt[9]{\frac{3}{8}}}`.

```dart
final tree = LaTeXTree();

tree.addChildLeaf(LEType.numberLeaf, "4");
tree.addChildLeaf(LEType.operatorLeaf, "+");

// Create the main fraction
tree.addChildNode(LEType.fractionNode); // Cursor moves to numerator

// Build the numerator: 15-\sqrt{7}
tree.addChildLeaf(LEType.numberLeaf, "1");
tree.addChildLeaf(LEType.numberLeaf, "5");
tree.addChildLeaf(LEType.operatorLeaf, "-");
tree.addChildNode(LEType.squareRootNode); // Cursor moves into sqrt
tree.addChildLeaf(LEType.numberLeaf, "7");

// Move from the numerator to the denominator
tree.moveDown(); // Cursor is now in the denominator

// Build the denominator: \sqrt[9]{\frac{3}{8}}
tree.addChildNode(LEType.nthRootNode); // Cursor moves to the root's index
tree.addChildLeaf(LEType.numberLeaf, "9");

tree.moveRight(); // Cursor moves to the radicand (the content of the root)
tree.addChildNode(LEType.fractionNode); // Cursor moves to the inner fraction's numerator
tree.addChildLeaf(LEType.numberLeaf, "3");

tree.moveDown(); // Cursor moves to the inner fraction's denominator
tree.addChildLeaf(LEType.numberLeaf, "8");

// Final result with cursor at the end
print("result : ${tree.toLaTeXString}");
// 4+\frac{15-\sqrt{7}}{\sqrt[9]{\frac{3}{8|}}}
```

## API Reference

-   **`LaTeXTree`**: The main class.
    -   `addChildLeaf(LEType type, String content)`: Adds a content leaf.
    -   `addChildNode(LEType type, {String content = ""})`: Adds a structural node.
    -   `moveUp()`, `moveDown()`, `moveLeft()`, `moveRight()`: Navigates the cursor.
    -   `delete()`: Deletes the element or node to the left of the cursor.
    -   `clear()`: Clears the entire expression.
    -   `toLaTeXString`: Gets the rendered LaTeX string.
-   **`LEType`**: An enum representing all possible types of leaves and nodes you can add.

## Advanced Topics

-   **Handling User Input**: Connect the `LaTeXTree` methods to a custom keyboard or UI buttons to allow users to build expressions interactively.
-   **Custom Styling**: Since this package generates a LaTeX string, you can use a rendering package (like `flutter_math_fork`) to control the color, font size, and style of the rendered output.
-   **Extending with New Elements**: You can extend the package by creating your own `LaTeXNode` or `LaTeXLeaf` subclasses to support custom LaTeX commands or structures.

## Contributing

Contributions are welcome! If you find a bug or have a feature request, please file an issue. If you want to contribute code, please feel free to open a pull request.

## License

This package is licensed under the [MIT License](LICENSE).