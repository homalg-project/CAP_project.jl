# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#
#! @Chapter Category 2-Cells

######################################
##
#! @Section Attributes for the Type of 2-Cells
##
######################################

#! @Description
#! The argument is a $2$-cell $c: \alpha \rightarrow \beta$.
#! The output is its source $\alpha$.
#! @Returns a morphism
#! @Arguments c
@DeclareAttribute( "Source",
                  IsCapCategoryTwoCell );

#! @Description
#! The argument is a $2$-cell $c: \alpha \rightarrow \beta$.
#! The output is its range $\beta$.
#! @Returns a morphism
#! @Arguments c
@DeclareAttribute( "Range",
                  IsCapCategoryTwoCell );

###################################
##
## Properties
##
###################################

## TODO: Write Add-functions for useful properties of 2-cells
# DeclareProperty( "IsMonomorphism",
#                  IsCapCategoryTwoCell );
# 
# DeclareProperty( "IsEpimorphism",
#                  IsCapCategoryTwoCell );
# 
# DeclareProperty( "IsIsomorphism",
#                  IsCapCategoryTwoCell );
# 
# DeclareProperty( "IsEndomorphism",
#                  IsCapCategoryTwoCell );
# 
# DeclareProperty( "IsAutomorphism",
#                  IsCapCategoryTwoCell );
# 
# DeclareProperty( "IsSplitMonomorphism",
#                  IsCapCategoryTwoCell );
# 
# DeclareProperty( "IsSplitEpimorphism",
#                  IsCapCategoryTwoCell );
# 
# DeclareProperty( "IsOne",
#                  IsCapCategoryTwoCell );
# 
# DeclareProperty( "IsIdempotent",
#                  IsCapCategoryTwoCell );

###################################
##
#! @Section Adding 2-Cells to a Category
##
###################################

@DeclareOperation( "Add",
                  [ IsCapCategory, IsCapCategoryTwoCell ] );

@DeclareOperation( "AddTwoCell",
                  [ IsCapCategory, IsObject ] );

###################################
##
#! @Section Identity 2-Cell && Composition of 2-Cells
#! @SectionLabel id2cellsandcomp
##
###################################

#! @Description
#! The argument is a morphism $\alpha$.
#! The output is its identity $2$-cell $\mathrm[id]_[\alpha]: \alpha \rightarrow \alpha$.
#! @Returns a $2$-cell
#! @Arguments alpha
@DeclareAttribute( "IdentityTwoCell",
                                          IsCapCategoryMorphism );

#! @Description
#! The arguments are two $2$-cells 
#! $c: \alpha \rightarrow \beta$,
#! $d: \gamma \rightarrow \delta$
#! between morphisms $\alpha, \beta: a \rightarrow b$ && $\gamma, \delta: b \rightarrow c$.
#! The output is their horizontal composition
#! $d \ast c: (\gamma \circ \alpha) \rightarrow (\delta \circ \beta)$.
#! @Returns a $2$-cell
#! @Arguments c,d
@DeclareOperation( "HorizontalPreCompose",
                  [ IsCapCategoryTwoCell, IsCapCategoryTwoCell ] );

#! @Description
#! The arguments are two $2$-cells
#! $d: \gamma \rightarrow \delta$,
#! $c: \alpha \rightarrow \beta$
#! between morphisms $\alpha, \beta: a \rightarrow b$ && $\gamma, \delta: b \rightarrow c$.
#! The output is their horizontal composition
#! $d \ast c: (\gamma \circ \alpha) \rightarrow (\delta \circ \beta)$.
#! @Returns a $2$-cell
#! @Arguments d,c
@DeclareOperation( "HorizontalPostCompose",
                  [ IsCapCategoryTwoCell, IsCapCategoryTwoCell ] );

#! @Description
#! The arguments are two $2$-cells 
#! $c: \alpha \rightarrow \beta$,
#! $d: \beta \rightarrow \gamma$
#! between morphisms $\alpha, \beta, \gamma: a \rightarrow b$.
#! The output is their vertical composition
#! $d \circ c: \alpha \rightarrow \gamma$.
#! @Returns a $2$-cell
#! @Arguments c,d
@DeclareOperation( "VerticalPreCompose",
                  [ IsCapCategoryTwoCell, IsCapCategoryTwoCell ] );

#! @Description
#! The arguments are two $2$-cells 
#! $d: \beta \rightarrow \gamma$,
#! $c: \alpha \rightarrow \beta$
#! between morphisms $\alpha, \beta, \gamma: a \rightarrow b$.
#! The output is their vertical composition
#! $d \circ c: \alpha \rightarrow \gamma$.
#! @Returns a $2$-cell
#! @Arguments d,c
@DeclareOperation( "VerticalPostCompose",
                  [ IsCapCategoryTwoCell, IsCapCategoryTwoCell ] );

######################################
##
#! @Section Well-Definedness for 2-Cells
##
######################################

#! @Description
#! The argument is a $2$-cell $c$.
#! The output is <C>true</C> if $c$ is well-defined,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments c
@DeclareOperation( "IsWellDefinedForTwoCells",
                  [ IsCapCategoryTwoCell ] );
