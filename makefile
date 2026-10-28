install:
	julia -e 'using Pkg; \
		Pkg.develop(path = "CAP"); \
		Pkg.develop(path = "MonoidalCategories"); \
		Pkg.develop(path = "CartesianCategories"); \
		Pkg.develop(path = "Toposes"); \
		Pkg.develop(path = "FinSetsForCAP"); \
		Pkg.develop(path = "ZXCalculusForCAP"); \
		Pkg.develop(path = "LinearAlgebraForCAP"); \
		Pkg.develop(path = "AdditiveClosuresForCAP"); \
		Pkg.develop(path = "LinearClosuresForCAP"); \
		Pkg.develop(path = "LocalesForCAP"); \
		Pkg.develop(path = "FreydCategoriesForCAP"); \
		Pkg.develop(path = "ModulePresentationsForCAP"); \
	'

uninstall:
	$(MAKE) -C CAP uninstall
	$(MAKE) -C MonoidalCategories uninstall
	$(MAKE) -C CartesianCategories uninstall
	$(MAKE) -C Toposes uninstall
	$(MAKE) -C FinSetsForCAP uninstall
	$(MAKE) -C ZXCalculusForCAP uninstall
	$(MAKE) -C LinearAlgebraForCAP uninstall
	$(MAKE) -C AdditiveClosuresForCAP uninstall
	$(MAKE) -C LinearClosuresForCAP uninstall
	$(MAKE) -C LocalesForCAP uninstall
	$(MAKE) -C FreydCategoriesForCAP uninstall
	$(MAKE) -C ModulePresentationsForCAP uninstall

gen-basic:
	$(MAKE) -C CAP gen-basic
	$(MAKE) -C MonoidalCategories gen-basic
	$(MAKE) -C CartesianCategories gen-basic
	$(MAKE) -C Toposes gen-basic
	$(MAKE) -C FinSetsForCAP gen-basic
	$(MAKE) -C ZXCalculusForCAP gen-basic
	$(MAKE) -C LinearAlgebraForCAP gen-basic
	$(MAKE) -C AdditiveClosuresForCAP gen-basic
	$(MAKE) -C LinearClosuresForCAP gen-basic
	$(MAKE) -C LocalesForCAP gen-basic
	$(MAKE) -C FreydCategoriesForCAP gen-basic
	$(MAKE) -C ModulePresentationsForCAP gen-basic
	$(MAKE) gen-root

gen:
	$(MAKE) -C CAP gen
	$(MAKE) -C MonoidalCategories gen
	$(MAKE) -C CartesianCategories gen
	$(MAKE) -C Toposes gen
	$(MAKE) -C FinSetsForCAP gen
	$(MAKE) -C ZXCalculusForCAP gen
	$(MAKE) -C LinearAlgebraForCAP gen
	$(MAKE) -C AdditiveClosuresForCAP gen
	$(MAKE) -C LinearClosuresForCAP gen
	$(MAKE) -C LocalesForCAP gen
	$(MAKE) -C FreydCategoriesForCAP gen
	$(MAKE) -C ModulePresentationsForCAP gen
	$(MAKE) gen-root

gen-root:
	ansible-playbook -i $$HOME/.gap/PackageJanitor/gap_to_julia/hosts $$HOME/.gap/PackageJanitor/gap_to_julia/site.yml -l CAP_project_root --diff

test:
	$(MAKE) -C CAP test
	$(MAKE) -C MonoidalCategories test
	$(MAKE) -C CartesianCategories test
	$(MAKE) -C Toposes test
	$(MAKE) -C FinSetsForCAP test
	$(MAKE) -C ZXCalculusForCAP test
	$(MAKE) -C LinearAlgebraForCAP test
	$(MAKE) -C AdditiveClosuresForCAP test
	$(MAKE) -C LinearClosuresForCAP test
	$(MAKE) -C LocalesForCAP test
	$(MAKE) -C FreydCategoriesForCAP test
	$(MAKE) -C ModulePresentationsForCAP test

git-commit:
	$(MAKE) -C CAP git-commit
	$(MAKE) -C MonoidalCategories git-commit
	$(MAKE) -C CartesianCategories git-commit
	$(MAKE) -C Toposes git-commit
	$(MAKE) -C FinSetsForCAP git-commit
	$(MAKE) -C ZXCalculusForCAP git-commit
	$(MAKE) -C LinearAlgebraForCAP git-commit
	$(MAKE) -C AdditiveClosuresForCAP git-commit
	$(MAKE) -C LinearClosuresForCAP git-commit
	$(MAKE) -C LocalesForCAP git-commit
	$(MAKE) -C FreydCategoriesForCAP git-commit
	$(MAKE) -C ModulePresentationsForCAP git-commit

update-subsplits:
	./dev/manually_update_subsplits.sh
