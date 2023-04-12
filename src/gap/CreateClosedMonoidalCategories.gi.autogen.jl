# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal && monoidal (co)closed categories
#
# Implementations
#

##
@InstallGlobalFunction( CAP_INTERNAL_FUNC_FOR_CLOSED_MONOIDAL_STRUCTURES,
  function( key_val_rec, package_name )
    local L, name;
    
    L = [ "IsMonoidalCategory",
           "IsStrictMonoidalCategory",
           "IsBraidedMonoidalCategory",
           "IsSymmetricMonoidalCategory",
           "IsClosedMonoidalCategory",
           "IsSymmetricClosedMonoidalCategory",
           "AdditiveMonoidal",
           "TensorProductOnObjects",
           "TensorProduct",
           "TensorUnit",
           "Associator",
           "LeftUnitor",
           "RightUnitor",
           "Distributivity",
           "Braiding",
           "Lambda",
           "Evaluation",
           "Coevaluation",
           "InternalHom",
           "Dual",
           "Bidual",
           "ClosedMonoidalCategories",
           "CLOSED_MONOIDAL",
           "ClosedMonoidal",
           "MONOIDAL",
           "Monoidal",
           "monoidal",
           "tensor_object",
           "tensored",
           "otimes",
           "tensor_product",
           "tensorSproduct",
           "tensor_hom",
           "Hom",
           "ClosedSMonoidal",
           "TensorProductOnObjectsBCcat",
           "CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE",
           ];
    
    for name in L
        if !IsBound( key_val_rec[name] )
            Error( "the component with the name ", name, " is missing ⥉ the given key_value_record record\n" );
        end;
    end;
    
    L = List( L[(1):(Length( L ) - 5)], name -> [ name, key_val_rec[name] ] );
    
    L = Concatenation(
                 [ [ "\"MonoidalCategories\",", Concatenation( "\"", package_name, "\"," ) ],
                   [ Concatenation( PackageInfo( "MonoidalCategories" )[1].PackageName, ": ", PackageInfo( "MonoidalCategories" )[1].Subtitle ),
                     Concatenation( PackageInfo( package_name )[1].PackageName, ": ", PackageInfo( package_name )[1].Subtitle ) ],
                   [ "Closed Monoidal", key_val_rec.ClosedSMonoidal ],
                   [ "TensorProductOnObjects( cat,", key_val_rec.TensorProductOnObjectsBCcat ],
                   [ "METHOD_NAME_RECORD, \"MonoidalCategories\"", key_val_rec.CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE ],
                   ], L );
    
    Add( L, [ "tensor product", key_val_rec.tensorSproduct ] );
    Add( L, [ "tensor hom", key_val_rec.tensor_hom ] );
    Add( L, [ "\\underline[Hom]", key_val_rec.Hom ] );
    
    if IsBound( key_val_rec.replace )
        Append( L, key_val_rec.replace );
    end;
    
    if IsBound( key_val_rec.safe_replace )
        L = Concatenation(
                     List( key_val_rec.safe_replace, r -> [ r[1], ShaSum( r[1] ) ] ), ## detect at the very beginning && replace by sha's (order is important!)
                     L,
                     List( key_val_rec.safe_replace, r -> [ ShaSum( r[1] ), r[2] ] ) ); ## safely replace the sha's at the very end
    end;
    
    return L;
    
end );

##
@InstallGlobalFunction( WriteFileForClosedMonoidalStructure,
  function( key_val_rec, package_name, files_rec )
    local dir, L, files, header, file, source, target;
    
    L = CAP_INTERNAL_FUNC_FOR_CLOSED_MONOIDAL_STRUCTURES( key_val_rec, package_name );
    
    dir = Concatenation( PackageInfo( "MonoidalCategories" )[1].InstallationPath, "/gap/" );
    
    files = [ "ClosedMonoidalCategories_gd",
               "ClosedMonoidalCategoriesTest_gd",
               "RigidSymmetricClosedMonoidalCategories_gd",
               "RigidSymmetricClosedMonoidalCategoriesTest_gd",
               "ClosedMonoidalCategoriesProperties_gi",
               "ClosedMonoidalCategoriesMethodRecord_gi",
               "ClosedMonoidalCategories_gi",
               "ClosedMonoidalCategoriesTest_gi",
               "SymmetricClosedMonoidalCategoriesProperties_gi",
               "RigidSymmetricClosedMonoidalCategoriesProperties_gi",
               "RigidSymmetricClosedMonoidalCategoriesMethodRecord_gi",
               "RigidSymmetricClosedMonoidalCategories_gi",
               "RigidSymmetricClosedMonoidalCategoriesTest_gi",
               "ClosedMonoidalCategoriesDerivedMethods_gi",
               "SymmetricClosedMonoidalCategoriesDerivedMethods_gi",
               "RigidSymmetricClosedMonoidalCategoriesDerivedMethods_gi",
               "HomomorphismStructureDerivedMethods_gi",
               ];
    
    header = Concatenation(
                      "# THIS FILE WAS AUTOMATICALLY GENERATED",
                      "\n\n" );
    for file in files
        if !IsBound( files_rec[file] )
            Info( InfoWarning, 1, "the component ", file, " is !bound ⥉ the record 'files_rec'" );
        elseif IsString( files_rec[file] )
            source = Concatenation( dir, ReplacedString( file, "_", "." ) );
            target = Concatenation( PackageInfo( package_name )[1].InstallationPath, "/gap/", files_rec[file] );
            WriteReplacedFileForHomalg( source, L, target; header = header );
        end;
    end;
    
end );
