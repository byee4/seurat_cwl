# Title     : TODO
# Objective : TODO
# Created by: brianyee
# Created on: 8/18/17

suppressPackageStartupMessages(library("argparse"))
suppressPackageStartupMessages(library("ANYLIBRARY"))

parser <- ArgumentParser()

parser$add_argument("--counts", type="character", nargs='+')

args <- parser$parse_args()
parser$add_argument("--outdir", type="character")

datas <- list()
batch <- 1

for (count in args$counts) {

    countData <- read.table(count,  comment.char="#", header=TRUE, row.names=1, sep='\t')
    colnames(countData) <- paste(colnames(countData), batch, sep = "_")
    datas[[length(datas)+1]] <- countData
    batch = batch + 1


dat <- Reduce(merge, lapply(datas, function(x) data.frame(x, rn = row.names(x))))
rownames(dat) <- dat$rn
dat$rn <- NULL
print(dat[1:3,1:270])
