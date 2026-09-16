## BiocJobs job script: inspect
##
## The declared interface lives in ../read-10x-counts.yaml.
## jobParams() parses the command line against that declaration, so by the
## time it returns, every value below is typed, validated and defaulted.

## Test command (R)
## BiocJobs::runJob(BiocJobs::readJob("inst/biocjobs/inspect.yaml"), params = list(loom_file = "test-data/matrix.mtx"))

params <- BiocJobs::jobParams("DropletUtils", "inspect")

suppressPackageStartupMessages(library(DropletUtils))
suppressPackageStartupMessages(library(LoomExperiment))

## ---- inputs -------------------------------------------------------------

tmpdir <- tempdir()

### process test inputs
## I think nextflow will fail if the inputs don't exist, so this might be reduncant?
stopifnot(file.exists(params$loom_file))
stopifnot(!file.exists(params$outfile))

# dropletutils_input_dir <- file.path(tmpdir, "tenx_input_dir")
# dir.create(dropletutils_input_dir)

# invisible(file.symlink(from = params$mtx_file, to = file.path(dropletutils_input_dir)))
# invisible(file.symlink(from = params$barcodes_file, to = file.path(dropletutils_input_dir)))
# invisible(file.symlink(from = params$genes_file, to = file.path(dropletutils_input_dir)))

## ---- task ---------------------------------------------------------------

library(LoomExperiment)
sce <- import(params$loom_file, format = "loom", type = "SingleCellLoomExperiment")

## ---- outputs ------------------------------------------------------------

capture.output(print(sce), file = params$outfile)

## Provenance to the job log.
message(paste(utils::capture.output(utils::sessionInfo()), collapse = "\n"))
