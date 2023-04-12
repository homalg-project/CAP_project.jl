# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian && cocartesian categories && various subdoctrines
#
# Declarations
#

####################################
##
#! @Chapter Cocartesian Categories
##
#! @Section Cocartesian Categories
##
####################################

#! @Description
#!  The arguments are an object $a$ && an integer $n \geq 0$.
#!  The output is the codiagonal morphism from the $n$-fold cocartesian multiple $\sqcup_[i=1]^n a$ to $a$.
#!  If the category does !support empty limits, $n$ must be !be 0.
#! @Returns a morphism ⥉ $\mathrm[Hom](\sqcup_[i=1]^n a, a)$.
#! @Arguments a, n
@DeclareOperation( "CocartesianCodiagonal",
                  [ IsCapCategoryObject, IsInt ] );

#! @Description
#!  The arguments are an object $a$, an integer $n$, && an object $b$ equal to the $n$-fold cocartesian multiple $\sqcup_[i=1]^n a$ of $a$.
#!  The output is the codiagonal morphism from $b$ to $a$.
#! @Returns a morphism ⥉ $\mathrm[Hom](b, a)$
#! @Arguments a, n, b
@DeclareOperation( "CocartesianCodiagonalWithGivenCocartesianMultiple",
                  [ IsCapCategoryObject, IsInt, IsCapCategoryObject ] );
