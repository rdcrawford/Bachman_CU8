# ------------------------------------------------------------------------------
# 
# 2020//
# Ryan D. Crawford
# ------------------------------------------------------------------------------
# 
# ------------------------------------------------------------------------------

# ---- Load Libraries ----------------------------------------------------------

library( cognac )

# ---- Variable Initializations ------------------------------------------------

fastaFiles = GetFilePaths( "../data/", ".fasta" )
gffFiles   = GetFilePaths( "../data/annotations/", ".gff" )

# ------------------------------------------------------------------------------

# Generate the alignment
algnEnv = cognac(
  fastaFiles    = fastaFiles,
  featureFiles  = gffFiles,
  runId         = "Bachman_CU8",
  njTree        = TRUE,
  keepTempFiles = TRUE,
  mapNtToAa     = TRUE,
  outDir        = outDir
  )

# ------------------------------------------------------------------------------