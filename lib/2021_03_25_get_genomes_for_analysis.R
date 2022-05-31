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

sampleKey = read.table(
  "../data/sequencing_sample_key_2.tsv",
  sep = '\t',
  header = TRUE,
  stringsAsFactors = FALSE
  )
sampleKey = sampleKey[ sampleKey$for_analysis == 'Y', ]
sampleKey$Kp_number= paste0( "Kp", sampleKey$Kp_number )

files = c( 
  #WGetFilePaths( "../data/genomes", "fa"), 
  GetFilePaths( "../data/genomes", "fasta")
  )

gIds = sapply( sapply( files, ExtractGenomeNameFromPath ), function(x) 
{
  x = gsub( "_scaffolds", '', x )
  x = gsub( "Sample_", '', x )
  x = gsub( "_assembly", '', x )
  x = gsub( "JV-", '', x )
  return( x )
})

kpNums = sapply( gIds, function(x)
{
  isSample = sampleKey$sample_ID == x
  if ( !TRUE %in% isSample ) return( NA )
  return( sampleKey$Kp_number[ isSample ] )
})

isForAnalysis = !is.na( kpNums )
gIds = gIds[ isForAnalysis ]
kpNums = kpNums[ isForAnalysis ]
for ( i in 1:length( gIds ) )
{
  newFaName = paste0( "../data/fasta/", kpNums[i], ".fasta" )
  system( paste( "mv", files[i], newFaName ) )
}

# ------------------------------------------------------------------------------