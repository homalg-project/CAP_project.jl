# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
#! @Chapter Managing Derived Methods

@BindGlobal( "TheFamilyOfDerivations",
            NewFamily( "TheFamilyOfDerivations" ) );
@BindGlobal( "TheFamilyOfDerivationGraphs",
            NewFamily( "TheFamilyOfDerivationGraphs" ) );
@BindGlobal( "TheFamilyOfOperationWeightLists",
            NewFamily( "TheFamilyOfOperationWeightLists" ) );
@BindGlobal( "TheFamilyOfStringMinHeaps",
            NewFamily( "TheFamilyOfStringMinHeaps" ) );

@BindGlobal( "TheTypeOfDerivedMethods", NewType( TheFamilyOfDerivations, IsDerivedMethod ) );
@BindGlobal( "TheTypeOfDerivationsGraphs", NewType( TheFamilyOfDerivationGraphs, IsDerivedMethodGraph ) );
@BindGlobal( "TheTypeOfOperationWeightLists", NewType( TheFamilyOfOperationWeightLists, IsOperationWeightList ) );
@BindGlobal( "TheTypeOfStringMinHeaps", NewType( TheFamilyOfStringMinHeaps, IsStringMinHeap ) );

@InstallGlobalFunction( "ActivateDerivationInfo",
  function( )
    SetInfoLevel( DerivationInfo, 1 );
end );

@InstallGlobalFunction( "DeactivateDerivationInfo",
  function( )
    SetInfoLevel( DerivationInfo, 0 );
end );

@InstallMethod( MakeDerivation,
               [ IsString, IsString, IsDenseList, IsPosInt, IsFunction, IsFunction ],
               
function( name, target_op_name, used_op_names_with_multiples_and_category_getters, weight, func, category_filter )
  local wrapped_category_filter, derivation;
    
    #= comment for Julia
    if (PositionSublist( StringGAP( category_filter ), "CanCompute" ) != fail)
        
        Print( "WARNING: The CategoryFilter of a derivation for ", target_op_name, " uses `CanCompute`. Please register all preconditions explicitly.\n" );
        
    end;
    # =#
    
    if (NumberArgumentsFunction( category_filter ) == 0 || NumberArgumentsFunction( category_filter ) > 1)
        
        Error( "the CategoryFilter of a derivation must accept exactly one argument" );
        
    end;
    
    if (ForAny( used_op_names_with_multiples_and_category_getters, x -> x[3] != fail ) && category_filter == IsCapCategory)
        
        Print( "WARNING: A derivation for ", target_op_name, " depends on other categories (e.g. RangeCategoryOfHomomorphismStructure) but does no test via the CategoryFilter if the other categories are available (e.g. by testing HasRangeCategoryOfHomomorphismStructure).\n" );
        
    end;
    
    if (IsProperty( category_filter ))
        
        # for Julia
        wrapped_category_filter = cat -> Tester( category_filter )( cat ) && category_filter( cat );
        
        #= comment for Julia
        wrapped_category_filter = Tester( category_filter ) && category_filter;
        # =#
        
    else
        
        wrapped_category_filter = category_filter;
        
    end;
    
    derivation = ObjectifyWithAttributes(
        @rec( ), TheTypeOfDerivedMethods,
        DerivationName, name,
        DerivationWeight, weight,
        DerivationFunction, func,
        CategoryFilter, wrapped_category_filter,
        TargetOperation, target_op_name,
        UsedOperationsWithMultiplesAndCategoryGetters, used_op_names_with_multiples_and_category_getters
    );
    
    return derivation;
    
end );

@InstallMethod( StringGAP,
               [ IsDerivedMethod ],
function( d )
  return @Concatenation( "derivation ", DerivationName( d ),
                        " of operation ", TargetOperation( d ) );
end );

@InstallMethod( ViewString,
               [ IsDerivedMethod ],
function( d )
  return @Concatenation( "<", StringGAP( d ), ">" );
end );

@InstallMethod( IsApplicableToCategory,
               [ IsDerivedMethod, IsCapCategory ],
function( d, C )
  return CategoryFilter( d )( C );
end );

@InstallMethod( InstallDerivationForCategory,
               [ IsDerivedMethod, IsPosInt, IsCapCategory ],
@FunctionWithNamedArguments(
  [
    [ "IsFinalDerivation", false ],
  ],
  function( CAP_NAMED_ARGUMENTS, d, weight, C )
    local method_name, func, add_method, add_name, general_filter_list,
          installation_name, nr_arguments, cache_name, current_filters, current_implementation,
          function_called_before_installation;
    
    @Info( DerivationInfo, 1, @Concatenation( "install(",
                                            StringGAP( weight ),
                                            ") ",
                                            TargetOperation( d ),
                                            ": ",
                                            DerivationName( d ), "\n" ) );
    
    method_name = TargetOperation( d );
    func = DerivationFunction( d );
    add_name = @Concatenation( "Add", method_name );
    add_method = ValueGlobal( add_name );
    
    if (HasFunctionCalledBeforeInstallation( d ))
        
        FunctionCalledBeforeInstallation( d )( C );
        
    end;
    
    # use the add method with signature IsCapCategory, IsList, IsInt to avoid
    # the convenience for AddZeroObject etc.
    add_method( C, [ PairGAP( func, [ ] ) ], weight; IsDerivation = !(IsFinalDerivation), IsFinalDerivation = IsFinalDerivation );
    
end ) );

@InstallMethod( MakeDerivationGraph,
               [ IsDenseList ],
function( operations )
  local G, op_name;
  G = @rec( derivations_by_target = @rec(),
              derivations_by_used_ops = @rec() );
  G = ObjectifyWithAttributes( G, TheTypeOfDerivationsGraphs );
  
  SetOperations( G, operations );
  
  for op_name in operations
    G.derivations_by_target[op_name] = [];
    G.derivations_by_used_ops[op_name] = [];
  end;
  
  # derivations not using any operations
  G.derivations_by_used_ops.none = [];
  
  return G;
end );

@InstallMethod( AddOperationsToDerivationGraph,
               [ IsDerivedMethodGraph, IsDenseList ],
               
  function( graph, operations )
    local op_name;
    
    Append( Operations( graph ), operations );
    
    for op_name in operations
        
        graph.derivations_by_target[op_name] = [];
        graph.derivations_by_used_ops[op_name] = [];
        
    end;
    
end );

@InstallMethod( StringGAP,
               [ IsDerivedMethodGraph ],
function( G )
  return "derivation graph";
end );

@InstallMethod( ViewString,
               [ IsDerivedMethodGraph ],
function( G )
  return @Concatenation( "<", StringGAP( G ), ">" );
end );

@InstallGlobalFunction( AddDerivation,
  
  function( graph, target_op, description, used_ops_with_multiples_and_category_getters, func, weight, category_filter, loop_multiplier, category_getters, function_called_before_installation, is_with_given_derivation, is_autogenerated_by_CompilerForCAP )
    local target_op_name, operations_in_graph, used_op_names_with_multiples_and_category_getters, collected_list, derivation, x;
    
    target_op_name = NameFunction( target_op );
    
    ## get used ops
    operations_in_graph = Operations( graph );
    
    used_op_names_with_multiples_and_category_getters = [ ];
    
    for x in used_ops_with_multiples_and_category_getters
        
        if (Length( x ) < 2 || !(IsFunction( x[1] )) || @not IsInt( x[2] ))
            
            Error( "preconditions must be of the form `[op, mult, getter]`, where `getter` is optional" );
            
        end;
        
        if ((Length( x ) == 2 || (Length( x ) == 3 && x[3] == fail)) && x[1] == target_op)
            
            Error( "A derivation for ", target_op_name, " has itself as a precondition. This is not supported because we cannot compute a well-defined weight.\n" );
            
        end;
        
        if (Length( x ) == 2)
            
            Add( used_op_names_with_multiples_and_category_getters, [ NameFunction( x[1] ), x[2], fail ] );
            
        elseif (Length( x ) == 3)
            
            if (x != fail && !(IsFunction( x[3] ) && NumberArgumentsFunction( x[3] ) == 1))
                
                Error( "the category getter must be a single-argument function" );
                
            end;
            
            Add( used_op_names_with_multiples_and_category_getters, [ NameFunction( x[1] ), x[2], x[3] ] );
            
        else
            
            Error( "The list of preconditions must be a list of pairs or triples." );
            
        end;
        
    end;
    
    #= comment for Julia
    collected_list = CAP_INTERNAL_FIND_APPEARANCE_OF_SYMBOL_IN_FUNCTION( func, operations_in_graph, loop_multiplier, CAP_INTERNAL_METHOD_RECORD_REPLACEMENTS, category_getters );
    
    if (Length( collected_list ) != Length( used_op_names_with_multiples_and_category_getters ) || @not ForAll( collected_list, c -> c in used_op_names_with_multiples_and_category_getters ))
        
        SortBy( used_op_names_with_multiples_and_category_getters, x -> x[1] );
        SortBy( collected_list, x -> x[1] );
        
        Print(
            "WARNING: You have installed a derivation for ", target_op_name, " with preconditions ", used_op_names_with_multiples_and_category_getters,
            " but the automated detection has detected the following list of preconditions: ", collected_list, ".\n",
            "If this is a bug in the automated detection, please report it.\n"
        );
        
    end;
    # =#
    
    derivation = MakeDerivation( description,
                                  target_op_name,
                                  used_op_names_with_multiples_and_category_getters,
                                  weight,
                                  func,
                                  category_filter );
    
    if (function_called_before_installation != false)
        
        SetFunctionCalledBeforeInstallation( derivation, function_called_before_installation );
        
    end;
    
    derivation.is_with_given_derivation = is_with_given_derivation;
    derivation.is_autogenerated_by_CompilerForCAP = is_autogenerated_by_CompilerForCAP;
    
    if (derivation.is_with_given_derivation && derivation.is_autogenerated_by_CompilerForCAP)
        
        Error( "WithGiven derivations should not be marked as being autogenerated by CompilerForCAP" );
        
    end;
    
    Add( graph.derivations_by_target[target_op_name], derivation );
    
    for x in used_op_names_with_multiples_and_category_getters
        # We add all operations, even those with category getters: In case the category getter
        # returns the category itself, this allows to recursively trigger derivations correctly.
        Add( graph.derivations_by_used_ops[x[1]], derivation );
    end;
    
    if (IsEmpty( used_op_names_with_multiples_and_category_getters ))
        
        Add( graph.derivations_by_used_ops.none, derivation );
        
    end;
    
end );

@BindGlobal( "CAP_INTERNAL_DERIVATION_GRAPH", MakeDerivationGraph( [ ] ) );

@InstallGlobalFunction( AddDerivationToCAP, @FunctionWithNamedArguments(
  [
    # When compiling categories, a derivation does not cause overhead anymore, so we would like to simply set `Weight` to 0.
    # However, the weight 1 is currently needed to prevent the installation of cyclic derivations.
    [ "Weight", 1 ],
    [ "CategoryFilter", IsCapCategory ],
    [ "WeightLoopMultiple", 2 ],
    [ "CategoryGetters", Immutable( @rec( ) ) ],
    [ "FunctionCalledBeforeInstallation", false ],
    [ "is_with_given_derivation", false ],
    [ "is_autogenerated_by_CompilerForCAP", false ],
  ],
  function( CAP_NAMED_ARGUMENTS, target_op, description, used_ops_with_multiples_and_category_getters, func )
    local method_name, filter_list, number_of_proposed_arguments, current_function_argument_number, weight, category_filter, loop_multiplier, category_getters, function_called_before_installation, option_is_with_given_derivation, option_is_autogenerated_by_CompilerForCAP;
    
    method_name = NameFunction( target_op );
    
    if (@not @IsBound( CAP_INTERNAL_METHOD_NAME_RECORD[method_name] ))
        
        Error( "trying to add a derivation to CAP_INTERNAL_DERIVATION_GRAPH for a method not in CAP_INTERNAL_METHOD_NAME_RECORD" );
        
    end;
    
    filter_list = CAP_INTERNAL_METHOD_NAME_RECORD[method_name].filter_list;
    
    number_of_proposed_arguments = Length( filter_list );
    
    current_function_argument_number = NumberArgumentsFunction( func );
    
    if (current_function_argument_number >= 0 && current_function_argument_number != number_of_proposed_arguments)
        Error( "While adding a derivation for ", method_name, ": given function has ", StringGAP( current_function_argument_number ),
               " arguments but should have ", StringGAP( number_of_proposed_arguments ) );
    end;
    
    weight = Weight;
    category_filter = CategoryFilter;
    loop_multiplier = WeightLoopMultiple;
    category_getters = CategoryGetters;
    function_called_before_installation = FunctionCalledBeforeInstallation;
    option_is_with_given_derivation = is_with_given_derivation;
    option_is_autogenerated_by_CompilerForCAP = is_autogenerated_by_CompilerForCAP;
    
    AddDerivation( CAP_INTERNAL_DERIVATION_GRAPH, target_op, description, used_ops_with_multiples_and_category_getters, func, weight, category_filter, loop_multiplier, category_getters, function_called_before_installation, option_is_with_given_derivation, option_is_autogenerated_by_CompilerForCAP );
    
end ) );

@InstallMethod( DerivationsUsingOperation,
               [ IsDerivedMethodGraph, IsString ],
function( G, op_name )
  return G.derivations_by_used_ops[op_name];
end );

@InstallMethod( DerivationsOfOperation,
               [ IsDerivedMethodGraph, IsString ],
function( G, op_name )
  return G.derivations_by_target[op_name];
end );

@InstallMethod( MakeOperationWeightList,
               [ IsCapCategory, IsDerivedMethodGraph ],
function( C, G )
  local operation_weights, operation_derivations, owl, op_name;
    
    operation_weights = @rec( );
    operation_derivations = @rec( );
    
    for op_name in Operations( G )
        operation_weights[op_name] = infinity;
        operation_derivations[op_name] = fail;
    end;
    
    owl = ObjectifyWithAttributes(
        @rec( operation_weights = operation_weights, operation_derivations = operation_derivations ), TheTypeOfOperationWeightLists,
        DerivationGraph, G,
        CategoryOfOperationWeightList, C
    );
    
    return owl;
    
end );

@InstallMethod( StringGAP,
               [ IsOperationWeightList ],
function( owl )
  return @Concatenation( "operation weight list for ",
                        StringGAP( CategoryOfOperationWeightList( owl ) ) );
end );

@InstallMethod( ViewString,
               [ IsOperationWeightList ],
function( owl )
  return @Concatenation( "<", StringGAP( owl ), ">" );
end );

@InstallMethod( CurrentOperationWeight,
               [ IsOperationWeightList, IsString ],
function( owl, op_name )
  if (@IsBound( owl.operation_weights[op_name] ))
      return owl.operation_weights[op_name];
  end;
  return infinity;
end );

@InstallMethod( OperationWeightUsingDerivation,
               [ IsOperationWeightList, IsDerivedMethod ],
function( owl, d )
  local category, category_operation_weights, weight, operation_weights, operation_name, operation_weight, x;
    
    category = CategoryOfOperationWeightList( owl );
    category_operation_weights = owl.operation_weights;
    
    weight = DerivationWeight( d );
    
    for x in UsedOperationsWithMultiplesAndCategoryGetters( d )
        
        if (x[3] == fail)
            
            operation_weights = category_operation_weights;
            
        else
            
            operation_weights = x[3](category).derivations_weight_list.operation_weights;
            
        end;
        
        operation_name = x[1];
        
        if (@not @IsBound( operation_weights[operation_name] ))
            
            return infinity;
            
        end;
        
        operation_weight = operation_weights[operation_name];
        
        if (operation_weight == infinity)
            
            return infinity;
            
        end;
        
        weight = weight + operation_weight * x[2];
        
    end;
    
    return weight;
    
end );

@InstallMethod( DerivationOfOperation,
               [ IsOperationWeightList, IsString ],
function( owl, op_name )
  return owl.operation_derivations[op_name];
end );

@BindGlobal( "TryToInstallDerivation", function ( owl, d )
  local new_weight, target, current_weight, current_derivation, derivations_of_target, new_pos, current_pos;
    
    if (@not IsApplicableToCategory( d, CategoryOfOperationWeightList( owl ) ))
        return fail;
    end;
    
    new_weight = OperationWeightUsingDerivation( owl, d );
    
    if (new_weight == infinity)
        return fail;
    end;
    
    target = TargetOperation( d );
    
    current_weight = CurrentOperationWeight( owl, target );
    current_derivation = DerivationOfOperation( owl, target );
    
    if (current_derivation != fail)
        
        derivations_of_target = DerivationsOfOperation( DerivationGraph( owl ), target );
        
        new_pos = PositionProperty( derivations_of_target, x -> IsIdenticalObj( x, d ) );
        current_pos = PositionProperty( derivations_of_target, x -> IsIdenticalObj( x, current_derivation ) );
        
        @Assert( 0, new_pos != fail );
        @Assert( 0, current_pos != fail );
        
    end;

    if (new_weight < current_weight || (new_weight == current_weight && current_derivation != fail && new_pos < current_pos))
        
        # Previously, `InstallDerivationForCategory` was called at this point.
        # However, this could lead to methods being overwritten if cheaper derivations become available while adding primitive installations to a category.
        # Hence, we now install the derivations in `Finalize`.
        
        owl.operation_weights[target] = new_weight;
        owl.operation_derivations[target] = d;
        
        return new_weight;
        
    else
        
        return fail;
        
    end;
    
end );

@InstallMethod( InstallDerivationsUsingOperation,
               [ IsOperationWeightList, IsString ],
function( owl, op_name )
  local Q, derivations_to_install, node, new_weight, target, d;
    
    Q = StringMinHeap();
    Add( Q, op_name, 0 );
    
    while @not IsEmptyHeap( Q )
        
        node = ExtractMin( Q );
        
        op_name = node[ 1 ];
        
        for d in DerivationsUsingOperation( DerivationGraph( owl ), op_name )
            
            new_weight = TryToInstallDerivation( owl, d );
            
            if (new_weight != fail)
                
                target = TargetOperation( d );
                
                if (Contains( Q, target ))
                    
                    DecreaseKey( Q, target, new_weight );
                    
                else
                    
                    Add( Q, target, new_weight );
                    
                end;
                
            end;
            
        end;
        
    end;
    
end );  

@InstallMethod( Reevaluate,
               [ IsOperationWeightList ],
function( owl )
  local new_weight, op_name, d;
    
    for op_name in Operations( DerivationGraph( owl ) )
        
        for d in DerivationsOfOperation( DerivationGraph( owl ), op_name )
            
            new_weight = TryToInstallDerivation( owl, d );
            
            if (new_weight != fail)
                
                InstallDerivationsUsingOperation( owl, TargetOperation( d ) );
                
            end;
            
        end;
        
    end;
    
end );

@InstallMethod( Saturate,
               [ IsOperationWeightList ],
  function( owl )
    local current_weight_list;

    while true
        current_weight_list = StructuralCopy( owl.operation_weights );
        Reevaluate( owl );
        if (current_weight_list == owl.operation_weights)
            break;
        end;
    end;

end );

@InstallMethod( AddPrimitiveOperation,
               [ IsOperationWeightList, IsString, IsInt ],
function( owl, op_name, weight )
    
    @Info( DerivationInfo, 1, @Concatenation( "install(",
                                  StringGAP( weight ),
                                  ") ",
                                  op_name,
                                  ": primitive installation\n" ) );
    
    owl.operation_weights[op_name] = weight;
    owl.operation_derivations[op_name] = fail;
    
    InstallDerivationsUsingOperation( owl, op_name );
    
end );

@InstallMethod( PrintDerivationTree,
               [ IsOperationWeightList, IsString ],
function( owl, op_name )
  local print_node, get_children;
  print_node = function( node )
    local w, mult, op, d;
    mult = node[ 2 ];
    op = node[ 1 ];
    if (op == fail)
      Print( "  ", mult );
      return;
    end;
    w = CurrentOperationWeight( owl, op );
    d = DerivationOfOperation( owl, op );
    if (mult != fail)
      Print( "+ ", mult, " * " );
    end;
    if (w == infinity)
      Print( "(not installed)" );
    else
      Print( "(", w, ")" );
    end;
    Print( " ", op );
    if (w != infinity)
      Print( " " );
      if (d == fail)
        Print( "[primitive]" );
      else
        Print( "[derived:", DerivationName( d ), "]" );
      end;
    end;
  end;
  get_children = function( node )
    local op, d;
    op = node[ 1 ];
    if (op == fail)
      return [];
    end;
    d = DerivationOfOperation( owl, op );
    if (d == fail)
      return [];
    else
      return @Concatenation( [ [ fail, DerivationWeight( d ) ] ],
                            UsedOperationsWithMultiplesAndCategoryGetters( d ) );
    end;
  end;
  PrintTree( [ op_name, fail ],
             print_node,
             get_children );
end );


@InstallGlobalFunction( StringMinHeap,
function()
  return Objectify( TheTypeOfStringMinHeaps,
                    @rec( key = function(n) return n[2]; end,
                         str = function(n) return n[1]; end,
                         array = [],
                         node_indices = @rec() ) );
end );

@InstallMethod( StringGAP,
               [ IsStringMinHeap ],
function( H )
  return @Concatenation( "min heap for strings, with size ",
                        StringGAP( HeapSize( H ) ) );
end );

@InstallMethod( ViewString,
               [ IsStringMinHeap ],
function( H )
  return @Concatenation( "<", StringGAP( H ), ">" );
end );

@InstallMethod( HeapSize,
               [ IsStringMinHeap ],
function( H )
  return Length( H.array );
end );

@InstallMethod( Add,
               [ IsStringMinHeap, IsString, IsInt ],
function( H, string, key )
  local array;
  array = H.array;
  Add( array, [ string, key ] );
  H.node_indices[string] = Length( array );
  DecreaseKey( H, string, key );
end );

@InstallMethod( IsEmptyHeap,
               [ IsStringMinHeap ],
function( H )
  return IsEmpty( H.array );
end );

@InstallMethod( ExtractMin,
               [ IsStringMinHeap ],
function( H )
  local array, node, key;
  array = H.array;
  node = array[ 1 ];
  Swap( H, 1, Length( array ) );
  Remove( array );
  key = H.str( node );
  @Unbind( H.node_indices[key] );
  if (@not IsEmpty( array ))
    Heapify( H, 1 );
  end;
  return node;
end );

@InstallMethod( DecreaseKey,
               [ IsStringMinHeap, IsString, IsInt ],
function( H, string, key )
  local array, i, parent;
  array = H.array;
  i = H.node_indices[string];
  array[ i ][ 2 ] = key;
  parent = IntGAP( i / 2 );
  while parent > 0 && H.key( array[ i ] ) < H.key( array[ parent ] )
    Swap( H, i, parent );
    i = parent;
    parent = IntGAP( i / 2 );
  end;
end );

@InstallMethod( Swap,
               [ IsStringMinHeap, IsPosInt, IsPosInt ],
function( H, i, j )
  local array, node_indices, str, tmp, key;
  array = H.array;
  node_indices = H.node_indices;
  str = H.str;
  tmp = array[ i ];
  array[ i ] = array[ j ];
  array[ j ] = tmp;
  key = str( array[ i ] );
  node_indices[key] = i;
  key = str( array[ j ] );
  node_indices[key] = j;
end );

@InstallMethod( Contains,
               [ IsStringMinHeap, IsString ],
function( H, string )
  return @IsBound( H.node_indices[string] );
end );

@InstallMethod( Heapify,
               [ IsStringMinHeap, IsPosInt ],
function( H, i )
  local key, array, left, right, smallest;
  key = H.key;
  array = H.array;
  left = 2 * i;
  right = 2 * i + 1;
  smallest = i;
  if (left <= HeapSize( H ) && key( array[ left ] ) < key( array[ smallest ] ))
    smallest = left;
  end;
  if (right <= HeapSize( H ) && key( array[ right ] ) < key( array[ smallest ] ))
    smallest = right;
  end;
  if (smallest != i)
    Swap( H, i, smallest );
    Heapify( H, smallest );
  end;
end );


@InstallMethod( PrintTree,
               [ IsObject, IsFunction, IsFunction ],
function( root, print_node, get_children )
  PrintTreeRec( root, print_node, get_children, 0 );
end );

@InstallMethod( PrintTreeRec,
               [ IsObject, IsFunction, IsFunction, IsInt ],
function( node, print_node, get_children, level )
  local i, child;
  for i in (1):(level)
    Print( "   " );
  end;
  print_node( node );
  Print( "\n" );
  for child in get_children( node )
    PrintTreeRec( child, print_node, get_children, level + 1 );
  end;
end );

#################################
##
## Some print functions
##
#################################

##
@InstallGlobalFunction( InstalledMethodsOfCategory,
  
  function( cell )
    local weight_list, list_of_methods, i, current_weight, can_compute, cannot_compute;
    
    if (IsCapCategory( cell ))
        weight_list = cell.derivations_weight_list;
    elseif (IsCapCategoryCell( cell ))
        weight_list = CapCategory( cell ).derivations_weight_list;
    else
        Error( "Input must be a category or a cell" );
    end;
    
    list_of_methods = Operations( CAP_INTERNAL_DERIVATION_GRAPH );
    
    list_of_methods = AsSortedList( list_of_methods );
    
    can_compute = [ ];
    cannot_compute = [ ];
    
    for i in list_of_methods
        
        current_weight = CurrentOperationWeight( weight_list, i );
        
        if (current_weight < infinity)
            Add( can_compute, [ i, current_weight ] );
        else
            Add( cannot_compute, i );
        end;
        
    end;
    
    Print( "Can do the following basic methods at the moment:\n" );
    
    for i in can_compute
        Print( "+ ", i[ 1 ], ", weight ", StringGAP( i[ 2 ] ), "\n" );
    end;
    
    Print( "\nThe following is still missing:\n" );
    
    for i in cannot_compute
        Print( "- ", i, "\n" );
    end;
    
    Print( "\nPlease use DerivationsOfMethodByCategory( <category>, <name> ) to get\n",
           "information about how to add the missing methods\n" );
    
end );

##
@InstallGlobalFunction( DerivationsOfMethodByCategory,
  
  function( category, name )
    local category_weight_list, current_weight, current_derivation, currently_installed_funcs, to_delete, weight_list, category_getter_string, possible_derivations, category_filter, weight, found, i, x, final_derivation;
    
    if (IsFunction( name ))
        name = NameFunction( name );
    end;
    
    if (@not IsString( name ))
        Error( "Usage is <category>,<string> or <category>,<CAP operation>\n" );
        return;
    end;
    
    if (@not @IsBound( CAP_INTERNAL_METHOD_NAME_RECORD[name] ))
        Error( name, " is not the name of a CAP operation." );
        return;
    end;
    
    category_weight_list = category.derivations_weight_list;
    
    current_weight = CurrentOperationWeight( category_weight_list, name );
    
    if (current_weight < infinity)
    
        current_derivation = DerivationOfOperation( category_weight_list, name );
        
        Print( Name( category ), " can already compute ", TextAttr.b4, name, TextAttr.reset, " with weight " , current_weight, ".\n" );
        
        if (current_derivation == fail)
            
            if (@IsBound( category.primitive_operations[name] ) && category.primitive_operations[name] == true)
                
                Print( "It was given as a primitive operation.\n" );
                
            else
                
                Print( "It was installed as a final or precompiled derivation.\n" );
                
            end;
            
            currently_installed_funcs = category.added_functions[name];
            
            # delete overwritten funcs
            to_delete = [ ];
            
            for i in (1):(Length( currently_installed_funcs ))
                
                if (ForAny( ((i+1)):(Length( currently_installed_funcs )), j -> currently_installed_funcs[i][2] == currently_installed_funcs[j][2] ))
                    
                    Add( to_delete, i );
                    
                end;
                
            end;
            
            currently_installed_funcs = currently_installed_funcs[Difference( (1):(Length( currently_installed_funcs )), to_delete )];
            
        else
            
            Print( "It was derived by ", TextAttr.b3, DerivationName( current_derivation ), TextAttr.reset, " using \n" );
            
            for x in UsedOperationsWithMultiplesAndCategoryGetters( current_derivation )
                
                if (x[3] == fail)
                    
                    weight_list = category_weight_list;
                    category_getter_string = "";
                    
                else
                    
                    weight_list = x[3](category).derivations_weight_list;
                    category_getter_string = @Concatenation( " in category obtained by applying ", StringGAP( x[3] ) );
                    
                end;
                
                Print( "* ", TextAttr.b2, x[1], TextAttr.reset, " (", x[2], "x)", category_getter_string );
                Print( " installed with weight ", StringGAP( CurrentOperationWeight( weight_list, x[1] ) ) );
                Print( "\n" );
                
            end;
            
            currently_installed_funcs = [ PairGAP( DerivationFunction( current_derivation ), [ ] ) ];
            
        end;
        
        Print( "\nThe following function" );
        
        if (Length( currently_installed_funcs ) > 1)
            Print( "s were" );
        else
            Print( " was" );
        end;
        
        Print( " installed for this operation:\n\n" );
        
        for i in currently_installed_funcs
            
            Print( "Filters: " );
            Print( StringGAP( i[ 2 ] ) );
            Print( "\n\n" );
            Display( i[ 1 ] );
            Print( "\n" );
            Print( "Source: ", FilenameFunc( i[ 1 ] ), ":", StartlineFunc( i[ 1 ] ), "\n" );
            Print( "\n" );
            
        end;
        
        Print( "#######\n\n" );
        
    else
        
        Print( TextAttr.b4, name, TextAttr.reset, " is currently not installed for ", Name( category ), ".\n\n" );
        
    end;
    
    Print( "Possible derivations are:\n\n" );
    
    possible_derivations = List( DerivationsOfOperation( CAP_INTERNAL_DERIVATION_GRAPH, name ), d -> @rec( derivation = d ) );
    
    for final_derivation in CAP_INTERNAL_FINAL_DERIVATION_LIST
        
        for current_derivation in final_derivation.derivations
            
            if (TargetOperation( current_derivation ) == name)
                
                Add( possible_derivations, @rec(
                    derivation = current_derivation,
                    can_compute = UsedOperationsWithMultiplesAndCategoryGetters( final_derivation.dummy_derivation ),
                    cannot_compute = final_derivation.cannot_compute,
                ) );
                
            end;
            
        end;
        
    end;
    
    for current_derivation in possible_derivations
        
        category_filter = CategoryFilter( current_derivation.derivation );
        
        # `SizeScreen()[1] - 3` is taken from the code for package banners
        Print( ListWithIdenticalEntries( SizeScreen()[1] - 3, '-' ), "\n" );
        if (category_filter( category ))
            Print( TextAttr.b4, name, TextAttr.reset, " can be derived by\n" );
        else
            if (IsFilter( category_filter ))
                Print( "If ", Name( category ), " would be ", JoinStringsWithSeparator( Filtered( NamesFilter( category_filter ), name -> @not StartsWith( name, "Has" ) ), " and " ) );
            else
                Print( "If ", Name( category ), " would fulfill the conditions given by\n\n" );
                Display( category_filter );
            end;
            Print( "\nthen ", TextAttr.b4, name, TextAttr.reset, " could be derived by\n" );
        end;
        
        for x in UsedOperationsWithMultiplesAndCategoryGetters( current_derivation.derivation )
            
            if (x[3] == fail)
                
                weight_list = category_weight_list;
                category_getter_string = "";
                
            else
                
                if (category_filter( category ))
                    
                    weight_list = x[3](category).derivations_weight_list;
                    
                else
                    
                    weight_list = fail;
                    
                end;
                
                category_getter_string = @Concatenation( " in the category obtained by applying ", StringGAP( x[3] ) );
                
            end;
            
            if (weight_list == fail)
                
                weight = infinity;
                
            else
                
                weight = CurrentOperationWeight( weight_list, x[1] );
                
            end;
            
            if (weight < infinity)
                Print( "* ", TextAttr.b2, x[1], TextAttr.reset, " (", x[2], "x)", category_getter_string, ", (already installed with weight ", weight,")" );
            else
                Print( "* ", TextAttr.b1, x[1], TextAttr.reset, " (", x[2], "x)", category_getter_string );
            end;
            
            Print( "\n" );
            
        end;
        
        Print( "with additional weight ", DerivationWeight( current_derivation.derivation ) );
        
        @Assert( 0, @IsBound( current_derivation.can_compute ) == @IsBound( current_derivation.cannot_compute ) );
        
        if (@IsBound( current_derivation.can_compute ))
            
            Print( "\n\nas a final derivation\nif the following additional operations could be computed\n" );
            
            found = false;
            
            for x in current_derivation.can_compute
                
                if (x[3] == fail)
                    
                    weight_list = category_weight_list;
                    category_getter_string = "";
                    
                else
                    
                    if (category_filter( category ))
                        
                        weight_list = x[3](category).derivations_weight_list;
                        
                    else
                        
                        weight_list = fail;
                        
                    end;
                
                    category_getter_string = @Concatenation( " in the category obtained by applying ", StringGAP( x[3] ) );
                    
                end;
                
                if (weight_list == fail)
                    
                    weight = infinity;
                    
                else
                    
                    weight = CurrentOperationWeight( weight_list, x[1] );
                    
                end;
                
                if (weight == infinity)
                    
                    Print( "* ", x[1], category_getter_string, "\n" );
                    found = true;
                    
                end;
                
            end;
            
            if (@not found)
                
                Print( "(none)\n" );
                
            end;
            
            Print( "\nand the following additional operations could not be computed\n" );
            
            found = false;
            
            for x in current_derivation.cannot_compute
                
                weight = CurrentOperationWeight( category_weight_list, x );
                
                if (weight < infinity)
                    
                    Print( "* ", x, "\n" );
                    found = true;
                    
                end;
                
            end;
            
            if (@not found)
                
                Print( "(none)\n" );
                
            end;
            
        else
            
            Print( ".\n" );
            
        end;
        
        Print( "\n" );
        
    end;
    
end );

@InstallGlobalFunction( ListPrimitivelyInstalledOperationsOfCategory,
  
  function( arg... )
    local cat, filter, names;
    
    if (Length( arg ) < 1)
        Error( "first argument needs to be <category>" );
    end;
    
    cat = arg[ 1 ];
    
    if (Length( arg ) > 1)
        filter = arg[ 2 ];
    else
        filter = fail;
    end;
    
    if (IsCapCategoryCell( cat ))
        cat = CapCategory( cat );
    end;
    
    if (@not IsCapCategory( cat ))
        Error( "input must be category or cell" );
    end;
    
    names = Filtered( RecNames( cat.primitive_operations ), x -> cat.primitive_operations[x] );
    
    if (filter != fail)
        names = Filtered( names, i -> PositionSublist( i, filter ) != fail );
    end;
    
    return AsSortedList( names );
    
end );

@InstallGlobalFunction( ListInstalledOperationsOfCategory,
  
  function( arg... )
    local category, filter, weight_list, list_of_methods, list_of_installed_methods;
    
    if (Length( arg ) < 1)
        Error( "first argument needs to be <category>" );
    end;
    
    category = arg[ 1 ];
    
    if (Length( arg ) > 1)
        filter = arg[ 2 ];
    else
        filter = fail;
    end;
    
    if (IsCapCategoryCell( category ))
        category = CapCategory( category );
    end;
    
    if (@not IsCapCategory( category ))
        Error( "input is not a category (cell)" );
        return;
    end;
    
    weight_list = category.derivations_weight_list;
    
    list_of_methods = Operations( CAP_INTERNAL_DERIVATION_GRAPH );
    
    list_of_methods = AsSortedList( list_of_methods );
    
    list_of_methods = Filtered( list_of_methods, i -> CurrentOperationWeight( weight_list, i ) < infinity );
    
    if (filter != fail)
        list_of_methods = Filtered( list_of_methods, i -> PositionSublist( i, filter ) != fail );
    end;
    
    return list_of_methods;
    
end );
