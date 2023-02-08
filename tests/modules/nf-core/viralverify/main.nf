#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { VIRALVERIFY } from '../../../../modules/nf-core/viralverify/main.nf'

workflow test_viralverify {

    input = [ [ id:'test', single_end:true ], // meta map
            [ file(params.test_data['sarscov2']['illumina']['contigs_fasta'], checkIfExists: true) ]
            ]
        hmm = 'https://utdallas.box.com/s/of2qxonj71l5eeeezm4ce8i8dygmt28r'


    VIRALVERIFY ( input , hmm)
}
