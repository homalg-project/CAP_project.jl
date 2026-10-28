# SPDX-License-Identifier: GPL-2.0-or-later
# LocalesForCAP: Locales, frames, coframes, meet semi-lattices of locally closed subsets, and Boolean algebras of constructible sets
#
# Implementations
#

# two new families:
@BindGlobal( "TheFamilyOfDatastructuresForConstructibleObjects",
        NewFamily( "TheFamilyOfDatastructuresForConstructibleObjects" ) );

@BindGlobal( "TheFamilyOfNodesInDatastructureForConstructibleObjects",
        NewFamily( "TheFamilyOfNodesInDatastructureForConstructibleObjects" ) );

# two new types:
@BindGlobal( "TheTypeDatastructureForConstructibleObjects",
        NewType(  TheFamilyOfDatastructuresForConstructibleObjects,
                IsDatastructureForConstructibleObjects ) );

@BindGlobal( "TheTypeNodeInDatastructureForConstructibleObjects",
        NewType(  TheFamilyOfNodesInDatastructureForConstructibleObjects,
                IsNodeInDatastructureOfConstructibleObjects ) );

SetInfoLevel( InfoSquashDatastructureForConstructibleObjects, 1 );

##
@InstallMethod( AllCoproducts,
        "for a CAP category and a list of objects",
        [ FilterIntersection( IsCapCategory, IsCocartesianCategory, IsThinCategory ), IsList ],
        
  function( cat, objects )
    local l, predicate, func, coproducts_initial_value;
    
    l = Length( objects );
    
    predicate =
      function( coproducts, coproducts_new )
        
        return Length( Last( coproducts_new ) ) == 0 ||
               Length( coproducts ) == l + 1;
        
    end;
    
    func =
      function( coproducts )
        local i, largest_coproducts, new_coproducts, coproducts_new, r, pair, coproduct, m, pos;
        
        i = Length( coproducts );
        
        largest_coproducts = Last( coproducts );
        
        new_coproducts = [ ];
        
        coproducts_new = @Concatenation( coproducts, [ new_coproducts ] );
        
        for r in (i):(l)
            for pair in largest_coproducts
                if (r > Maximum( pair[1] ))
                    
                    coproduct = BinaryCoproduct( cat, pair[2], objects[r] );
                    
                    for m in (2):(i + 1)
                        pos = PositionProperty( coproducts_new[m], entry -> IsEqualForObjects( cat, entry[2], coproduct ) );
                        
                        if (IsInt( pos ))
                            Add( coproducts_new[m][pos][1], r );
                            break;
                        end;
                        
                    end;
                    
                    if (pos == fail)
                        Add( new_coproducts, PairGAP( @Concatenation( pair[1], [ r ] ), coproduct ) );
                    end;
                    
                end;
            end;
        end;
        
        return coproducts_new;
        
    end;
    
    coproducts_initial_value = [ [ PairGAP( [ ], InitialObject( cat ) ) ],
                                  List( (1):(l), i -> PairGAP( [ i ], objects[i] ) ) ];
    
    return CapFixpoint( predicate, func, coproducts_initial_value );
    
end );

##
@InstallGlobalFunction( DatastructureForConstructibleObject,
  function( )
    local C;
    
    C = @rec( 
              counter = 0,
              pre_nodes = [ ],
              pos_nodes = [ ],
              neg_nodes = [ ],
              act_nodes = [ ], ## active nodes
              all_nodes = [ ],
              all_pos_nodes = [ ],
              all_neg_nodes = [ ],
              );
    
    Objectify( TheTypeDatastructureForConstructibleObjects, C );
    
    return C;
    
end );

##
@InstallMethod( NodeInDatastructureOfConstructibleObject,
        "for a datastructure of a constructible object, an object in a thin category, and a Boolean",
        [ IsDatastructureForConstructibleObjects, IsObjectInThinCategory, IsBool ],
        
  function( C, A, b )
    local parents, number, level, N, nodes, all_nodes, context, counter, p, n;
    
    parents = ValueOption( "parents" );
    
    if (parents == fail)
        parents = [ ];
    end;
    
    number = ValueOption( "number" );
    
    N = @rec( 
              constructible_object = C,
              object = A,
              parity = b,
              number = number,
              level = 0,
              act_parents = parents, ## active parents
              act_children = [ ],    ## active children
              all_parents = ShallowCopy( parents ),
              all_children = [ ],
              );
    
    Objectify( TheTypeNodeInDatastructureForConstructibleObjects, N );
    
    if (b == true)
        
        ## positive node
        if (@not parents == [ ])
            N.level = parents[1].level + 1;
        else
            N.level = 1;
        end;
        nodes = C.pos_nodes;
        all_nodes = C.all_pos_nodes;
        
    elseif (b == false)
        
        ## negative node
        if (parents == [ ])
            Error( "I cannot create a negative node with no parents\n" );
        end;
        N.level = parents[1].level;
        nodes = C.neg_nodes;
        all_nodes = C.all_neg_nodes;
        
    else
        
        ## pre-node, these are the ones returned when calling Pop( C )
        if (number == 0 || ( IsString( number ) && number[1] == '0' ))
            N.level = 1;
        else
            N.level = parents[1].level + 1;
        end;
        
        nodes = C.pre_nodes;
        
        if (ValueOption( "first" ) == true)
            C.pre_nodes = @Concatenation( [ N ], nodes );
        else
            Add( nodes, N );
        end;
        
        context = ValueOption( "context" );
        
        if (@not context == fail)
            N.context = context;
        end;
        
        return N;
        
    end;
    
    if (b == false)
        p = PositionProperty( nodes, a -> a == N );
    end;
    
    if (b == true || p == fail)
        counter = C.counter + 1;
        C.counter = counter;
        N.number = counter;
        Add( nodes, N );
        Add( all_nodes, N );
        Add( C.all_nodes, N );
        Add( C.act_nodes, N );
        Perform( parents, function( node ) Add( node.act_children, N ); end );
        Perform( parents, function( node ) Add( node.all_children, N ); end );
    else ## b == false && @not p == fail
        ## an equal negative node already exists
        n = nodes[p];
        AppendNew( n.act_parents, N.act_parents );
        AppendNew( n.all_parents, N.all_parents );
        N = n;
    end;
    
    return N;
    
end );

##
@InstallMethod( IsHomSetInhabited,
        "for two nodes in a datastructure of a constructible object",
        [ IsNodeInDatastructureOfConstructibleObjects, IsNodeInDatastructureOfConstructibleObjects ],
        
  function( N1, N2 )
    
    return IsHomSetInhabited( N1.object, N2.object );
    
end );

##
@InstallMethod( ==,
        "for two nodes in a datastructure of a constructible object",
        [ IsNodeInDatastructureOfConstructibleObjects, IsNodeInDatastructureOfConstructibleObjects ],
        
  function( N1, N2 )
    
    return N1.object == N2.object;
    
end );

##
@InstallMethod( Attach,
        "for a node in a datastructure of a constructible object, an object in a thin category, and a list of objects in a thin category",
        [ IsNodeInDatastructureOfConstructibleObjects, IsObjectInThinCategory, IsList ],
        
  function( N, pos_node, L )
    local C, pos_nodes, p, neg_nodes, pre_nodes, q, i, neg_node;
    
    if (@not N.parity == fail)
        Error( "the first argument N is not a pre-node\n" );
    end;
    
    if (N.number == fail)
        Error( "the pre-node has no number\n" );
    end;
    
    ## the underlying datastructure of a constructible object
    C = N.constructible_object;
    
    pos_nodes = List( C.pos_nodes, n -> n.object );
    
    p = Position( pos_nodes, pos_node );
    
    if (@not p == fail)
        pos_node = C.pos_nodes[p];
        AppendNew( pos_node.act_parents, N.act_parents );
        AppendNew( pos_node.all_parents, N.all_parents );
        Perform( N.act_parents, function( node ) Add( node.act_children, pos_node ); end );
        Perform( N.all_parents, function( node ) Add( node.all_children, pos_node ); end );
    else
        pos_node = NodeInDatastructureOfConstructibleObject( C, pos_node, true; parents = N.act_parents );
    end;
    
    neg_nodes = List( C.neg_nodes, n -> n.object );
    
    pre_nodes = [ ];
    
    for i in (1):(Length( L ))
        neg_node = L[i];
        if (IsInitial( neg_node ))
            continue;
        end;
        q = Position( neg_nodes, neg_node );
        if (q == fail)
            neg_node = NodeInDatastructureOfConstructibleObject( C, neg_node, false; parents = [ pos_node ] );
            Add( pre_nodes, neg_node );
        else
            neg_node = C.neg_nodes[q];
            if (p == fail)
                Add( neg_node.act_parents, pos_node );
                Add( neg_node.all_parents, pos_node );
                Add( pos_node.act_children, neg_node );
                Add( pos_node.all_children, neg_node );
            end;
        end;
    end;
    
    pre_nodes = List( pre_nodes,
                       neg_node -> NodeInDatastructureOfConstructibleObject( C, neg_node.object, fail; parents = [ neg_node ], number = neg_node.number ) );
    
    return [ pre_nodes, pos_node ];
    
end );

##
@InstallMethod( IsDone,
        "for a datastructure of a constructible object",
        [ IsDatastructureForConstructibleObjects ],
        
  function( C )
    
    return IsEmpty( C.pre_nodes );
    
end );

##
@InstallMethod( MinimalLevelOfPreNodes,
        "for a datastructure of a constructible object",
        [ IsDatastructureForConstructibleObjects ],
        
  function( C )
    
    if (C.pre_nodes == [ ])
        return infinity;
    end;
    
    return Minimum( List( C.pre_nodes, N -> N.level ) );
    
end );

##
@InstallMethod( Pop,
        "for a datastructure of a constructible object",
        [ IsDatastructureForConstructibleObjects ],
        
  function( C )
    
    if (@not IsEmpty( C.pre_nodes ))
        return Remove( C.pre_nodes, 1 );
    end;
    
    return fail;
    
end );

##
@InstallMethod( Remove,
        "for a node in a datastructure of a constructible object",
        [ IsNodeInDatastructureOfConstructibleObjects ],
        
  function( pos_node )
    local level, Level, C, pos_nodes, p, act_nodes, neg_node, neg_nodes, children,
          grandparents, child, spouses, grandparent, aunts;
    
    if (@not pos_node.parity == true)
        Error( "the given argument pos_node is not a positive node\n" );
    elseif (@not Length( pos_node.act_parents ) == 1)
        Error( "expected exactly one parent but found ", Length( pos_node.act_parents ), "\n" );
    end;
    
    level = ValueOption( "level" );
    
    if (level == fail)
        Level = "";
        level = "";
    else
        Level = "Level ";
    end;
    
    @Info( InfoSquashDatastructureForConstructibleObjects, 2, Level, level,
          " in RMV: removed ", pos_node.number, " -> ", pos_node.act_parents[1].number );
    
    C = pos_node.constructible_object;
    
    pos_nodes = C.pos_nodes;
    
    p = IdenticalPosition( pos_nodes, pos_node );
    
    if (p == fail)
        Error( "pos_node not among pos_nodes\n" );
    end;
    
    Remove( pos_nodes, p );
    
    act_nodes = C.act_nodes;
    
    p = IdenticalPosition( act_nodes, pos_node );
    
    if (p == fail)
        Error( "pos_node not among act_nodes\n" );
    end;
    
    Remove( act_nodes, p );
    
    neg_node = pos_node.act_parents[1];
    
    if (@not neg_node.parity == false)
        Error( "neg_node is not a negative node\n" );
    elseif (@not Length( neg_node.act_children ) == 1)
        Error( "expected exactly one child but found ", Length( neg_node.act_children ), "\n" );
    end;
    
    neg_nodes = C.neg_nodes;
    
    p = IdenticalPosition( neg_nodes, neg_node );
    
    if (p == fail)
        Error( "neg_node not among neg_nodes\n" );
    end;
    
    Remove( neg_nodes, p );
    
    p = IdenticalPosition( act_nodes, neg_node );
    
    if (p == fail)
        Error( "neg_node not among act_nodes\n" );
    end;
    
    Remove( act_nodes, p );
    
    children = pos_node.act_children;
    
    grandparents = neg_node.act_parents;
    
    for child in children
        spouses = child.act_parents;
        p = IdenticalPosition( spouses, pos_node );
        if (p == fail)
            Error( "pos_node is not among the spouses\n" );
        end;
        Remove( spouses, p );
        AppendNew( spouses, grandparents );
    end;
    
    if (@not children == pos_node.act_children)
        Error( "not children == pos_node.act_children" );
    elseif (@not grandparents == neg_node.act_parents)
        Error( "not grandparents == neg_node.act_parents" );
    end;
    
    for grandparent in grandparents
        aunts = grandparent.act_children;
        p = IdenticalPosition( aunts, neg_node );
        ## p == fail in CavenderFarrisNeyman_reduced.g:
        ## #I  Level 3 in RMV: removed 116 -> 20
        if (p == fail)
            #Error( "neg_node is not among the aunts\n" );
        else
            Remove( aunts, p );
        end;
        AppendNew( aunts, children );
    end;
    
end );
    
##
@InstallMethod( SquashOnce,
        "for a datastructure of a constructible object",
        [ IsDatastructureForConstructibleObjects ],
        
  function( C )
    local visualize, pos_node, parents, act_nodes, neg_nodes, children;
    
    visualize = ValueOption( "visualize" );
    
    if (visualize == true)
        Visualize( C );
    end;
    
    for pos_node in ShallowCopy( C.pos_nodes )
        
        parents = pos_node.act_parents;
        
        if (Length( parents ) == 1 && Length( parents[1].act_children ) == 1 &&
           IsHomSetInhabited( parents[1].object, pos_node.object ))
            
            Remove( pos_node );
            
        end;
        
    end;
    
    act_nodes = ShallowCopy( C.pos_nodes );
    neg_nodes = [ ];
    
    for pos_node in C.pos_nodes
        
        children = pos_node.act_children;
        
        AppendNew( act_nodes, children );
        AppendNew( neg_nodes, children );
        
    end;
    
    C.act_nodes = act_nodes;
    C.neg_nodes = neg_nodes;
    
    ## update pre_nodes
    neg_nodes = List( neg_nodes, N -> N.number );
    C.pre_nodes = Filtered( C.pre_nodes, N -> N.number in neg_nodes );
    
    return C;
    
end );
    
##
@InstallMethod( RemoveObsoleteSubtrahends,
        "for a datastructure of a constructible object",
        [ IsDatastructureForConstructibleObjects ],
        
  function( C )
    local level, Level, visualize, act_nodes, neg_nodes, pos_node, act_children, children, node;
    
    level = ValueOption( "level" );
    
    if (level == fail)
        Level = "";
        level = "";
    else
        Level = "Level ";
    end;
    
    visualize = ValueOption( "visualize" );
    
    if (visualize == true)
        Visualize( C );
    end;
    
    act_nodes = ShallowCopy( C.pos_nodes );
    neg_nodes = [ ];
    
    for pos_node in C.pos_nodes
        
        act_children = pos_node.act_children;
        
        children = MaximalObjects( act_children, IsHomSetInhabited );
        
        if (Length( children ) < Length( act_children ))
            @Info( InfoSquashDatastructureForConstructibleObjects, 2, Level, level,
                  " in RMV: removing from node ", pos_node.number, " the obsolete subtrahends ",
                  Difference( List( act_children, node -> node.number ), List( children, node -> node.number ) ),
                  ", remaining: ", List( children, node -> node.number ) );
        end;
        
        pos_node.act_children = children;
        
        AppendNew( act_nodes, children );
        AppendNew( neg_nodes, children );
        
    end;
    
    C.act_nodes = act_nodes;
    C.neg_nodes = neg_nodes;
    
    ##  update active parents of all active nodes
    for node in act_nodes
        node.act_parents = Filtered( node.act_parents, x -> @not IdenticalPosition( act_nodes, x ) == fail );
    end;
    
    ## update pre_nodes
    neg_nodes = List( neg_nodes, N -> N.number );
    C.pre_nodes = Filtered( C.pre_nodes, N -> N.number in neg_nodes );
    
    return C;
    
end );

##
@InstallMethod( Squash,
        "for a datastructure of a constructible object",
        [ IsDatastructureForConstructibleObjects ],
        
  function( C )
    local l;
    
    @Info( InfoSquashDatastructureForConstructibleObjects, 2, "----------------------------------------" );
    
    while true
        
        l = Length( C.act_nodes );
        
        SquashOnce( C );
        
        RemoveObsoleteSubtrahends( C );
        
        if (l == Length( C.act_nodes ))
            break;
        end;
        
    end;
    
    return C;
    
end );

##
@InstallMethod( AsUnionOfMultipleDifferences,
        "for a datastructure of a constructible object",
        [ IsDatastructureForConstructibleObjects ],
        
  function( C )
    local A, pos_node, D, children;
    
    A = [ ];
    
    for pos_node in C.pos_nodes
        children = pos_node.act_children;
        if (children == [ ])
            D = [ pos_node.object - 0 ];
        else
            D = List( children, neg_node -> pos_node.object - neg_node.object );
        end;
        D = CallFuncList( AsMultipleDifference, D );
        Add( A, D );
    end;
    
    if (A == [ ])
        if (@IsBound( C.InitialObject ))
            A = C.InitialObject;
        else
            Error( "the list A constructed out of the datastructure of a constructible object C is empty and C.InitialObject is not bound\n" );
        end;
    else
        A = UnionOfMultipleDifferences( A );
    end;
    
    A.C = C;
    
    return A;
    
end );

##
@InstallMethod( ViewString,
        "for a datastructure of a constructible object",
        [ IsDatastructureForConstructibleObjects ],
        
  function( C )
    
    return @Concatenation( "<data structure for a constructible object: #pos=", Length( C.pos_nodes ), ", #neg=", Length( C.neg_nodes ), ">" );
    
end );

##
@InstallMethod( ViewString,
        "for a node in a datastructure of a constructible object",
        [ IsNodeInDatastructureOfConstructibleObjects ],
        
  function( N )
    local parity, str;
    
    parity = N.parity;
    
    if (parity == true)
        str = "Positive ";
    elseif (parity == false)
        str = "Negative ";
    else
        str = "Pre-";
    end;
    
    str = @Concatenation( "node number ",
           StringGAP( N.number ),
           " in a datastructure of a constructible object containing: " );
    
    return @Concatenation( str, DisplayString( N.object ) );
    
end );

##
@InstallMethod( DisplayString,
        "for a node in a datastructure of a constructible object",
        [ IsNodeInDatastructureOfConstructibleObjects ],
        
  function( N )
    
    return DisplayString( N.object );
    
end );
