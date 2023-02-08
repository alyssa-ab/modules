#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { VIRALVERIFY } from '../../../../modules/nf-core/viralverify/main.nf'

workflow test_viralverify {

    input = [ [ id:'test', single_end:true ], // meta map
            [ file(params.test_data['sarscov2']['illumina']['contigs_fasta'], checkIfExists: true) ]
            ]
        hmm = '/modules/nf-core/viralverify/hmm/nbc_hmms.hmm'


    VIRALVERIFY ( input , hmm)
}
