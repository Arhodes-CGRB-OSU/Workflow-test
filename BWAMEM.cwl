class: CommandLineTool
id: "bwa-mem-0.7.15 base tool"
label: "BWA v0.7.15"

cwlVersion: v1.0

#dct:creator:
#  id: "http://orcid.org/0000-0003-0342-8531"
#  foaf:name: Adelaide Rhodes
#  foaf:mbox: "mailto:adelaide.rhodes@gmail.com"

requirements:
  - class: DockerRequirement
    dockerPull: "biocontainers/bwa:latest" 
      
hints:
  - class: ResourceRequirement
    coresMin: 1
    ramMin: 1000

inputs:
  M_flag:
    type: boolean
    doc: "Mark shorter split hits as secondary"
    inputBinding:
      position: 1
      prefix: -M
  threads:
    type: int
    inputBinding:
      position: 2
      prefix: -t
  fasta:
    type: File
    doc: "Indexed reference genome to be use for alignment"
    inputBinding:
      position: 3
    secondaryFiles:
      - ".amb"
      - ".ann"
      - ".pac"
      - ".bwt"
      - ".sa"
  fastq1:
    type: File
    doc: "Fastq file to be analyzed"
    inputBinding:
      position: 4
  fastq2:
    type: File?
    doc: "optional second fastq file"
    inputBinding:
      position: 5

outputs:
  output.sam:
    type: File
    doc: "Alignments in sam format"
    outputBinding:
      glob: 'output.sam'

stdout: output.sam

baseCommand: ["bwa","mem"]
