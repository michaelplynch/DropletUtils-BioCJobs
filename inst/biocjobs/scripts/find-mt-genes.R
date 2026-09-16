## BiocJobs job script: find-mt-genes
##
## The declared interface lives in ../find-mt-genes.yaml.
## jobParams() parses the command line against that declaration, so by the
## time it returns, every value below is typed, validated and defaulted.

## Test command (R)
## BiocJobs::runJob(BiocJobs::readJob("inst/biocjobs/find-mt-genes.yaml"), params = list(loom_file = "sce.loom", prefix = "MT-", outfile = "mt_genes.txt"))

params <- BiocJobs::jobParams("DropletUtils", "find-mt-genes")

suppressPackageStartupMessages(library(LoomExperiment))

## ---- inputs -------------------------------------------------------------

stopifnot(!file.exists(params$loom_file)) # Unnecessary for Nextflow

## ---- task ---------------------------------------------------------------

sce <- import(params$loom_file, format = "loom", type = "SingleCellLoomExperiment")

mt_gene_ids <- rownames(sce)[startsWith(rownames(sce), params$mt_prefix)]

## ---- outputs ------------------------------------------------------------

cat(mt_gene_ids, file = params$outfile, sep = "\n")
cat(mt_gene_ids, sep = "\n")

## Provenance to the job log.
message(paste(utils::capture.output(utils::sessionInfo()), collapse = "\n"))
