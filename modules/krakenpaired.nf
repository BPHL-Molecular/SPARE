process krakenpaired {
    input:
        val x
    output:
        //stdout
        val x
        
    """   
    mkdir -p ${params.output}/${x}
    cp ${params.input}/${x}_*.fastq.gz ${params.output}/${x}
    mkdir -p ${params.output}/${x}/kraken_out/
    
    kraken2 --db ${params.db} --use-names --report ${params.output}/${x}/kraken_out/${x}.report --output ${params.output}/${x}/kraken_out/${x}_kraken.out --paired ${params.output}/${x}/${x}_1.fastq.gz ${params.output}/${x}/${x}_2.fastq.gz

    """
}