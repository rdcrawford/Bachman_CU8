# ------------------------------------------------------------------------------
# 
# 2021//
# Ryan D. Crawford
# ------------------------------------------------------------------------------
# 
# ------------------------------------------------------------------------------

# ---- Load Libraries ----------------------------------------------------------

library( cognac )

# ------------------------------------------------------------------------------

MakeBlastDb = function( faPath, outDir, type )
{
  if ( missing( type ) ) type = "nucl"
  gId     = ExtractGenomeNameFromPath( faPath )
  outFile = paste0( outDir, gId )
  system( paste("makeblastdb -dbtype", type, "-in ", faPath, "-out", outFile ) )
  return( outFile )
}

ReadBlastData = function( tsv )
{
  if ( !file.exists( tsv ) ) return( NULL )
  # Read in the blast data
  blastData = read.table(
    tsv,
    header           = FALSE,
    sep              = '\t',
    fill             = TRUE,
    quote            = "",
    stringsAsFactors = FALSE
    )

  return( blastData )
}

RunBlast = function( qPath, dbPath, outDir )
{
  # Create the path for the output file
  outFile = paste0(
    outDir,
    ExtractGenomeNameFromPath( qPath ),
    "_blast_data.tsv"
    )

  # Create the command to run blast
  cmd = paste0(
    # "blastx",
    "tblastn",
    " -outfmt \"6 qseqid sseqid qstart qend start send nident slen sseq\"",
    " -query ", qPath,
    " -db ", dbPath,
    " -out ", outFile
    )

  # Run the blast command
  system( cmd )

  # Returnthe path to the blast results
  return( outFile )
}

CalcSubjId = function( blastData, subject )
{
  # Find any matches to the current subject
  isSubj = blastData[ , S_SEQ_ID ] == subject

  # If there are no matches to the current subject, return 0
  if ( !TRUE %in% isSubj ) return( 0.0 )

  pId = sapply( which( isSubj ), function(i) CalcPercId( i, blastData ) )

  return( max( pId ) )
}

CalcPercId = function( idx, blastData )
{
  return( )
}

# ------------------------------------------------------------------------------

wziLen = nchar( ParseFasta( "../data/wzi.faa" ) )

fastaFiles = GetFilePaths( "../data/fasta" )

blastDbs = sapply( fastaFiles, MakeBlastDb, outDir = "../data/blastdbs/" )

blastResuls = sapply( blastDbs, 
  function(x) list( ReadBlastData( 
    RunBlast( "../data/wzi.faa", x, "../data/blast_results/" ) 
    ) ) 
  )

# ------------------------------------------------------------------------------

N_IDENT = 6
S_SEQ   = 8

faa = sapply( 1:length( blastResuls ), function(j)
{
  if ( !length( blastResuls[[j]] ) ) return( NA )
  
   pId = sapply( 1:nrow( blastResuls[[j]] ),
    function(i) blastResuls[[j]][ i, N_IDENT ] / wziLen
    )
  
  return( blastResuls[[j]][ which.max( pId ), S_SEQ ] )
})

faa = gsub( '-', '', faa )

genomeIds = sapply( fastaFiles, ExtractGenomeNameFromPath )

sink( "../analysis/2021_03_25_make_wzi_tree/wzi_alleles.faa" )
for ( i in 1:length( faa ) )
  cat( '>', genomeIds[i], '\n', faa[i], '\n', sep = '' )
sink()

# ---- Save the data -----------------------------------------------------------

save( file = "../data/2021_03_25_blast_analysis.rData", list = ls() )

# ------------------------------------------------------------------------------