process VIRALVERIFY {
    tag "$meta.id"
    label 'process_medium'

    conda "bioconda::viralverify=1.1"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/viralverify:1.1--hdfd78af_0':
        'quay.io/biocontainers/viralverify:1.1--hdfd78af_0' }"

    input:
    tuple val(meta), path(fasta)
    path(hmm)

    output:
    tuple val(meta), path("*.csv"), emit: csv
    path "versions.yml"           , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    // def prefix = task.ext.prefix ?: thr // Sensitivity threshold (minimal absolute score to classify sequence, default = 7)
    // def prefix = task.ext.prefix ?: p  // Output predicted plasmidic contigs separately

    """
    viralverify \\
        -t ${task.cpus} \\
        -f ${fasta} \\
        -o ${prefix}.csv \\
        --hmm ${hmm} \\
        $args
    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        viralverify: \$(viralverify -version 1.1)
    END_VERSIONS
    """
}
