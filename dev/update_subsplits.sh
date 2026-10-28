#!/bin/bash

set -e

# Check if token exists
if [ -z "$JULIA_SUBSPLIT_TOKEN" ]; then
  echo "ERROR: Missing JULIA_SUBSPLIT_TOKEN"
  exit 1
fi

# update git index
git status > /dev/null

if ! git diff-index --quiet HEAD; then
	echo "WARNING: Dirty working tree."
fi

if [[ "$(git rev-parse --abbrev-ref HEAD)" != "master" ]]; then
	echo "ERROR: Not on branch master"
	exit 1
fi

# CAP
git subtree split --prefix=CAP -b CAP-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/CAP.jl.git CAP-split:master
echo "Pushed to CAP.jl"

# MonoidalCategories
git subtree split --prefix=MonoidalCategories -b MonoidalCategories-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/MonoidalCategories.jl.git MonoidalCategories-split:master
echo "Pushed to MonoidalCategories.jl"

# CartesianCategories
git subtree split --prefix=CartesianCategories -b CartesianCategories-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/CartesianCategories.jl.git CartesianCategories-split:master
echo "Pushed to CartesianCategories.jl"

# Toposes
git subtree split --prefix=Toposes -b Toposes-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/Toposes.jl.git Toposes-split:master
echo "Pushed to Toposes.jl"

# FinSetsForCAP
git subtree split --prefix=FinSetsForCAP -b FinSetsForCAP-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/FinSetsForCAP.jl.git FinSetsForCAP-split:master
echo "Pushed to FinSetsForCAP.jl"

# ZXCalculusForCAP
git subtree split --prefix=ZXCalculusForCAP -b ZXCalculusForCAP-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/ZXCalculusForCAP.jl.git ZXCalculusForCAP-split:master
echo "Pushed to ZXCalculusForCAP.jl"

# LinearAlgebraForCAP
git subtree split --prefix=LinearAlgebraForCAP -b LinearAlgebraForCAP-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/LinearAlgebraForCAP.jl.git LinearAlgebraForCAP-split:master
echo "Pushed to LinearAlgebraForCAP.jl"

# AdditiveClosuresForCAP
git subtree split --prefix=AdditiveClosuresForCAP -b AdditiveClosuresForCAP-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/AdditiveClosuresForCAP.jl.git AdditiveClosuresForCAP-split:master
echo "Pushed to AdditiveClosuresForCAP.jl"

# LinearClosuresForCAP
git subtree split --prefix=LinearClosuresForCAP -b LinearClosuresForCAP-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/LinearClosuresForCAP.jl.git LinearClosuresForCAP-split:master
echo "Pushed to LinearClosuresForCAP.jl"

# LocalesForCAP
git subtree split --prefix=LocalesForCAP -b LocalesForCAP-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/LocalesForCAP.jl.git LocalesForCAP-split:master
echo "Pushed to LocalesForCAP.jl"

# FreydCategoriesForCAP
git subtree split --prefix=FreydCategoriesForCAP -b FreydCategoriesForCAP-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/FreydCategoriesForCAP.jl.git FreydCategoriesForCAP-split:master
echo "Pushed to FreydCategoriesForCAP.jl"

# ModulePresentationsForCAP
git subtree split --prefix=ModulePresentationsForCAP -b ModulePresentationsForCAP-split > /dev/null 2>&1
git push https://${JULIA_SUBSPLIT_TOKEN}@github.com/homalg-project/ModulePresentationsForCAP.jl.git ModulePresentationsForCAP-split:master
echo "Pushed to ModulePresentationsForCAP.jl"
