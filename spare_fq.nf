#!/usr/bin/env nextflow

/*
Note:
Before running the script, please set the parameters in the config file params.yaml
*/

//Step1:input data files
nextflow.enable.dsl=2
def L001R1Lst = []
def sampleNames = []
myDir = file("$params.input")

myDir.eachFileMatch ~/.*_1.fastq.gz/, {L001R1Lst << it.name}
//myDir.eachFileMatch ~/.*.bam/, {L001R1Lst << it.name}
L001R1Lst.sort()
L001R1Lst.each{
   def x = it.minus("_1.fastq.gz")
     println x
   sampleNames.add(x)
}
//println L001R1Lst
//println sampleNames


//Step2: process the inputed data
A = Channel.fromList(sampleNames)
A.view()

include { krakenpaired } from './modules/krakenpaired.nf'
include { bracken } from './modules/bracken.nf'

workflow {
   //bam2fastq(A) | pbsmrtlink | statistics | variant | view
   krakenpaired(A)|bracken|view
}
