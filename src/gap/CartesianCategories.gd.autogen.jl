# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian && cocartesian categories && various subdoctrines
#
# Declarations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



####################################
##
#! @Chapter Cartesian Categories
##
#! @Section Cartesian Categories
##
####################################

DeclareGlobalVariable( "CARTESIAN_CATEGORIES_METHOD_NAME_RECORD" );

## DirectProductOnMorphismsWithGivenDirectProducts

#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$.
#! The output is the direct product $\alpha \times \beta$.
#! @Returns a morphism ⥉ $\mathrm[Hom](a \times b, a' \times b')$
#! @Arguments alpha, beta
@DeclareOperation( "DirectProductOnMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are an object $s == a \times b$,
#! two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$,
#! && an object $r == a' \times b'$.
#! The output is the direct product $\alpha \times \beta$.
#! @Returns a morphism ⥉ $\mathrm[Hom](a \times b, a' \times b')$
#! @Arguments s, alpha, beta, r
@DeclareOperation( "DirectProductOnMorphismsWithGivenDirectProducts",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the associator $\alpha_[a,(b,c)]: a \times (b \times c) \rightarrow (a \times b) \times c$.
#! @Returns a morphism ⥉ $\mathrm[Hom]( a \times (b \times c), (a \times b) \times c )$.
#! @Arguments a, b, c
@DeclareOperation( "CartesianAssociatorRightToLeft",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s == a \times (b \times c)$,
#! three objects $a,b,c$,
#! && an object $r == (a \times b) \times c$.
#! The output is the associator $\alpha_[a,(b,c)]: a \times (b \times c) \rightarrow (a \times b) \times c$.
#! @Returns a morphism ⥉ $\mathrm[Hom]( a \times (b \times c), (a \times b) \times c )$.
#! @Arguments s, a, b, c, r
@DeclareOperation( "CartesianAssociatorRightToLeftWithGivenDirectProducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the associator $\alpha_[(a,b),c]: (a \times b) \times c \rightarrow a \times (b \times c)$.
#! @Returns a morphism ⥉ $\mathrm[Hom]( (a \times b) \times c \rightarrow a \times (b \times c) )$.
#! @Arguments a, b, c
@DeclareOperation( "CartesianAssociatorLeftToRight",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s == (a \times b) \times c$,
#! three objects $a,b,c$,
#! && an object $r == a \times (b \times c)$.
#! The output is the associator $\alpha_[(a,b),c]: (a \times b) \times c \rightarrow a \times (b \times c)$.
#! @Returns a morphism ⥉ $\mathrm[Hom]( (a \times b) \times c \rightarrow a \times (b \times c) )$.
#! @Arguments s, a, b, c, r
@DeclareOperation( "CartesianAssociatorLeftToRightWithGivenDirectProducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the left unitor $\lambda_a: 1 \times a \rightarrow a$.
#! @Returns a morphism ⥉ $\mathrm[Hom](1 \times a, a)$
#! @Arguments a
@DeclareAttribute( "CartesianLeftUnitor",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $a$ && an object $s == 1 \times a$.
#! The output is the left unitor $\lambda_a: 1 \times a \rightarrow a$.
#! @Returns a morphism ⥉ $\mathrm[Hom](1 \times a, a)$
#! @Arguments a, s
@DeclareOperation( "CartesianLeftUnitorWithGivenDirectProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the inverse of the left unitor $\lambda_a^[-1]: a \rightarrow 1 \times a$.
#! @Returns a morphism ⥉ $\mathrm[Hom](a, 1 \times a)$
#! @Arguments a
@DeclareAttribute( "CartesianLeftUnitorInverse",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$ && an object $r == 1 \times a$.
#! The output is the inverse of the left unitor $\lambda_a^[-1]: a \rightarrow 1 \times a$.
#! @Returns a morphism ⥉ $\mathrm[Hom](a, 1 \times a)$
#! @Arguments a, r
@DeclareOperation( "CartesianLeftUnitorInverseWithGivenDirectProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the right unitor $\rho_a: a \times 1 \rightarrow a$.
#! @Returns a morphism ⥉ $\mathrm[Hom](a \times 1, a)$
#! @Arguments a
@DeclareAttribute( "CartesianRightUnitor",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $a$ && an object $s == a \times 1$.
#! The output is the right unitor $\rho_a: a \times 1 \rightarrow a$.
#! @Returns a morphism ⥉ $\mathrm[Hom](a \times 1, a)$
#! @Arguments a, s
@DeclareOperation( "CartesianRightUnitorWithGivenDirectProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the inverse of the right unitor $\rho_a^[-1]: a \rightarrow a \times 1$.
#! @Returns a morphism ⥉ $\mathrm[Hom](a, a \times 1)$
#! @Arguments a
@DeclareAttribute( "CartesianRightUnitorInverse",
                  IsCapCategoryObject );

# the second argument is the given direct product
#! @Description
#! The arguments are an object $a$ && an object $r == a \times 1$.
#! The output is the inverse of the right unitor $\rho_a^[-1]: a \rightarrow a \times 1$.
#! @Returns a morphism ⥉ $\mathrm[Hom](a, a \times 1)$
#! @Arguments a, r
@DeclareOperation( "CartesianRightUnitorInverseWithGivenDirectProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );
