

julia> true
true

julia> Length( ListInstalledOperationsOfCategory( SkeletalFinSets ) )
399

julia> BooleanAlgebras = Opposite( SkeletalFinSets )
Opposite( SkeletalFinSets )

julia> Length( ListPrimitivelyInstalledOperationsOfCategory( BooleanAlgebras ) )
294

julia> Length( ListInstalledOperationsOfCategory( BooleanAlgebras ) )
324

julia> Opposite( BooleanAlgebras )
SkeletalFinSets

julia> FS = Opposite( WrapperCategory( BooleanAlgebras, @rec( ) ) )
Opposite( WrapperCategory( Opposite( SkeletalFinSets ) ) )

julia> Length( ListPrimitivelyInstalledOperationsOfCategory( FS ) )
294

julia> Length( ListInstalledOperationsOfCategory( FS ) )
336
