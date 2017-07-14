class:  Workflow
id: "bwa-mem-0.15 to samtools view"
label: "WorkFlowTest v1.0"

cwlVersion: v1.0

dct:creator:{'@id': 'http://orcid.org/0000-0003-0342-8531', 'foaf:name': Adelaide Rhodes, 
'foaf:mbox': mailto:adelaide.rhodes@gmail.com}

inputs:
  - id: fastq1
    type: File
    doc: "Required first fastq file"
  - id: fastq2
    type: File?
    doc: "Optional second fastq file"
  - id: fasta
    type: File
    doc: "BWA Indexed reference fasta file with secondary files in same directory"
    secondaryFiles:
      - ".amb"
      - ".ann"
      - ".pac"
      - ".bwt"
      - ".sa" 
  - id: output_filename
    type: string
  - id: threads
    type: int

outputs:
  - id: output
    type: File
    doc: "Alignments in BAM format"
    outputSource: samtoolsview/output

steps:
  - id: bwamem
    in:
      - { id: fastq1, source: "#fastq1" }
      - { id: index, source: "#reference" }
      - { id: threads, source: "#threads" }
    out:
      - { id: output.sam }
    run: BWAMEM.cwl
  - id: samtoolsview
    in:
      - { id: input, source: "#bwamem/output.sam" }
      - { id: output_name, source: "#output_filename" }
    out:
      - { id: output }
    run: SAMTOOLS-VIEW.cwl
