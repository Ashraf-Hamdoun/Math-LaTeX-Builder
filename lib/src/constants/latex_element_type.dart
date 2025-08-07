/// The type of a LaTeX element.
///
/// User-facing types are marked below. Internal types are for package use only.
enum LEType {
  // Internal types (not for direct user use)
  trunk,
  node,
  leaf,
  numeratorNode,
  denominatorNode,
  indexOfRootNode,
  radicandNode,
  lowerLimitNode,
  upperLimitNode,
  integrandNode,
  summandNode,
  placeHolderLeaf,

  // User-facing node types
  functionNode, // e.g., sin(x)
  inverseFunctionNode, // e.g., sin^{-1}(x)
  fractionNode,
  squareRootNode,
  cubeRootNode,
  nthRootNode,
  powerNode,
  integralNode,
  summationNode,

  // User-facing leaf types
  numberLeaf,
  operatorLeaf,
  variableLeaf,
  symbolLeaf,
  specialSymbolLeaf,
  textLeaf,
}

extension LETypeUserFacing on LEType {
  /// Returns true if this type is intended for user code.
  bool get isUserFacing => const {
        LEType.functionNode,
        LEType.inverseFunctionNode,
        LEType.fractionNode,
        LEType.squareRootNode,
        LEType.cubeRootNode,
        LEType.nthRootNode,
        LEType.powerNode,
        LEType.integralNode,
        LEType.summationNode,
        LEType.numberLeaf,
        LEType.operatorLeaf,
        LEType.variableLeaf,
        LEType.symbolLeaf,
        LEType.specialSymbolLeaf,
        LEType.textLeaf,
      }.contains(this);
}
