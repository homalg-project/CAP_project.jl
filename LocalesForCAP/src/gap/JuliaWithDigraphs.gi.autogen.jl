# SPDX-License-Identifier: GPL-2.0-or-later
# LocalesForCAP: Locales, frames, coframes, meet semi-lattices of locally closed subsets, and Boolean algebras of constructible sets
#
# Implementations
#

##
@InstallMethod( Visualize,
        "for a datastructure of a constructible object",
        [ IsDatastructureForConstructibleObjects ],
        
  function( C )
    
    if (IsRunningInJupyter( ))
        
        return Julia.Base.display(
                       Julia.Base.MIME( GAPToJulia( "image/svg+xml" ) ),
                       GAPToJulia( DotToSVG( DotVertexLabelledDigraph( C ) ) ) );
        
    elseif (IsRunningInPluto( ))
        
        JuliaEvalString( "import PlutoUI" );
        
        return Julia.PlutoUI.Show(
                       Julia.Base.MIME( GAPToJulia( "image/svg+xml" ) ),
                       GAPToJulia( DotToSVG( DotVertexLabelledDigraph( C ) ) ) );
        
    end;
    
    TryNextMethod( );
    
end );
