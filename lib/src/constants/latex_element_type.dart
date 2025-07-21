/// The type of a LaTeX element.
enum LEType {
  essentialTrunk,
  node,
  essentialLeaf,
  // Node types
  normalNode,
  functionNode,
  inverseFunctionNode,
  fractionNode,
  numeratorNode,
  denominatorNode,
  squareRootNode,
  cubeRootNode,
  nthRootNode,
  indexOfRootNode,
  radicandNode,
  powerNode,
  // Leaf types
  placeHolderLeaf,
  numberLeaf,
  operatorLeaf,
  variableLeaf,
}
