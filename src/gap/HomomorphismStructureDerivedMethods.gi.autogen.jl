# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian && cocartesian categories && various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



####################################
## Final derived methods
####################################

##
AddFinalDerivationBundle( "adding the homomorphism structure using the closed cartesian structure",
                    [ [ TerminalObject, 1 ],
                      [ ExponentialOnObjects, 1 ],
                      [ ExponentialOnMorphismsWithGivenExponentials, 1 ],
                      [ CartesianLambdaIntroduction, 1 ],
                      [ CartesianLambdaElimination, 1 ],
                      ],
                    [
                      DistinguishedObjectOfHomomorphismStructure,
                      HomomorphismStructureOnObjects,
                      HomomorphismStructureOnMorphisms,
                      HomomorphismStructureOnMorphismsWithGivenObjects,
                      InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure,
                      InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects,
                      InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism
                    ],
[
  DistinguishedObjectOfHomomorphismStructure,
  [ [ TerminalObject, 1 ] ],
  function ( cat )
    
    return TerminalObject( cat );
    
  end
],
[
  HomomorphismStructureOnObjects,
  [ [ ExponentialOnObjects, 1 ] ],
  function ( cat, a, b )
    
    return ExponentialOnObjects( cat, a, b );
    
end
],
[
  HomomorphismStructureOnMorphismsWithGivenObjects,
  [ [ ExponentialOnMorphismsWithGivenExponentials, 1 ] ],
  function ( cat, s, alpha, beta, r )
    
    return ExponentialOnMorphismsWithGivenExponentials( cat, s, alpha, beta, r );
    
end
],
[
  InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure,
  [ [ CartesianLambdaIntroduction, 1 ] ],
  function( cat, alpha )
    local iota;
    
    return CartesianLambdaIntroduction( cat, alpha );
    
  end
],
[
  InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism,
  [ [ CartesianLambdaElimination, 1 ] ],
  function ( cat, a, b, iota )
    
    return CartesianLambdaElimination( cat, a, b, iota );
    
  end
]; CategoryFilter = function( cat )
      return HasIsEquippedWithHomomorphismStructure( cat ) &&
             IsEquippedWithHomomorphismStructure( cat ) &&
             HasRangeCategoryOfHomomorphismStructure( cat ) &&
             IsIdenticalObj( RangeCategoryOfHomomorphismStructure( cat ), cat );
    end
);
