# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian && cocartesian categories && various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



####################################
## Final derived methods
####################################

## Final methods for CartesianDual
AddFinalDerivationBundle( "IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject && its inverse as the identity of Exp(a,1)",
                    [ [ IdentityMorphism, 1 ],
                      [ ExponentialOnObjects, 1 ],
                      [ TerminalObject, 1 ] ],
                    [ CartesianDualOnObjects,
                      CartesianDualOnMorphismsWithGivenCartesianDuals,
                      MorphismToCartesianBidualWithGivenCartesianBidual,
                      IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject,
                      IsomorphismFromExponentialIntoTerminalObjectToCartesianDualObject,
                      UniversalPropertyOfCartesianDual,
                      DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects,
                      CartesianEvaluationForCartesianDualWithGivenDirectProduct,
                      MorphismFromDirectProductToExponentialWithGivenObjects ],
[
  IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject,
  [ [ IdentityMorphism, 1 ],
    [ ExponentialOnObjects, 1 ],
    [ TerminalObject, 1 ] ],
  function( cat, object )
    
    return IdentityMorphism( cat, ExponentialOnObjects( cat, object, TerminalObject( cat ) ) );
    
  end
],
[
  IsomorphismFromExponentialIntoTerminalObjectToCartesianDualObject,
  [ [ IdentityMorphism, 1 ],
    [ ExponentialOnObjects, 1 ],
    [ TerminalObject, 1 ] ],
  function( cat, object )
    
    return IdentityMorphism( cat, ExponentialOnObjects( cat, object, TerminalObject( cat ) ) );
    
  end
]; CategoryFilter = IsCartesianClosedCategory );
