# ------------------------------------------------------------------------------
# 
# 2020//
# Ryan D. Crawford
# ------------------------------------------------------------------------------
# 
# ------------------------------------------------------------------------------

# ---- Load Libraries ----------------------------------------------------------

library( ape )
library( maps )
library( phytools )

# ---- Constant Declarations ---------------------------------------------------



# ---- Variable Initializations ------------------------------------------------

cognacTree = read.tree( "../analysis/Bachman_CU8_fastTree_kp_Num_labels.tre" )

wziTree = read.tree( "../analysis/2021_03_25_make_wzi_tree/wzi_fastTree.tre")

# ---- Source Functions --------------------------------------------------------

PlotCoPhylo = function( lhsTree, rhsTree )
{
  # Get rid of any genomes not in both trees 
  isInRhs = lhsTree$tip.label %in% rhsTree$tip.label
  if ( FALSE %in% isInRhs )
    lhsTree = drop.tip( lhsTree, lhsTree$tip.label[ !isInRhs ] )
  isInLhs =  rhsTree$tip.label %in% lhsTree$tip.label 
  if ( FALSE %in% isInRhs )
    rhsTree = drop.tip( rhsTree, rhsTree$tip.label[ !isInLhs ] )

  # Create a vector with the colors
  nTips    = length( lhsTree$tip.label )
  treeCols = rainbow( nTips )
  
  # Create an association matrix for the tip lables
  association = cbind( lhsTree$tip.label, rhsTree$tip.label )
  
  # Make the plot
  cophyloplot(
    lhsTree, 
    rhsTree, 
    assoc          = association,
    length.line    = 4, 
    space          = 500, 
    gap            = 3,
    col            = treeCols,
    show.tip.label = FALSE
    )
}

# ------------------------------------------------------------------------------

PlotCoPhylo( midpoint.root( cognacTree ), midpoint.root( wziTree ) )

# ------------------------------------------------------------------------------

isIn       = cognacTree$tip.label %in% wziTree$tip.label
cognacTree = drop.tip( cognacTree, cognacTree$tip.label[ !isIn ] )
cgDists    = cophenetic.phylo( cognacTree ) 
cgDists    = ClusterMatrix( cgDists, TRUE, TRUE )
geneDists  = cophenetic.phylo( wziTree )

matOrd = sapply( row.names( geneDists ), 
  function(x) which( row.names( cgDists ) == x ) 
  )
geneDists = geneDists[ order( matOrd ), order( matOrd ) ]
identical( row.names( cgDists ), colnames( geneDists ) )


pheatmap::pheatmap( 
  geneDists,
  cluster_rows  = FALSE,
  cluster_cols  = FALSE,
  show_rownames = FALSE,
  show_colnames = FALSE
  )
pheatmap::pheatmap( 
  cgDists, 
  cluster_rows  = FALSE, 
  cluster_cols  = FALSE,
  show_rownames = FALSE,
  show_colnames = FALSE
  )


plot( 
  x    = as.vector( as.dist( cgDists  ) ),
  y    = as.vector( as.dist( geneDists ) ),
  col  = "darkblue",
  xlab = "Core gene distance",
  ylab = "Wzi gene distance",
  pch  = 19
  )

# ---- Save the data -----------------------------------------------------------

save( file = rData, list = ls() )

# ------------------------------------------------------------------------------