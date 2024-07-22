Welcome to the Performer repository! This repository is meant to fine-tune sequence-to-expression models using paired whole genome sequencing (WGS) and gene expression data. We focus on [Enformer](https://www.nature.com/articles/s41592-021-01252-x), although the code used here can be adapted to other models.

Our preprint is out! Find it [here]()

NOTE: Not all necessary data is provided in this repository. This is because some of the data is protected (GTEx WGS and ROSMAP data) while other data is large and easily found online (hg38 reference genome). Thus, for this repository to be used as-is, protected data must first be retrieved. This repository can still be used as a starting point for those that do not have access to protected data, or are interested in using different datasets.

# Requirements
1. Clone the repository
2. Download [miniforge3](https://github.com/conda-forge/miniforge)
3. Install the requirements
```
eval “$(/PATH/TO/MINIFORGE3/bin/conda shell.bash hook)" #specify path to miniforge3 conda executable
conda env create -f environment.yml #install requirements
```
4. (Optional) update SLURM job scripts under `code/submission_scripts` to accommodate your requirements and directory locations. For example, the stderr/stdout locations must be changed to match your file structure, as does the activation of the conda environment. If you are not using a SLURM job scheduler, update the job scripts accordingly.
5. (Optional) Follow the [Weights & Biases quickstart](https://docs.wandb.ai/quickstart). W&B is used to track training experiments and metadata from past runs is parsed in subsequent experiments. For example, when performing in silico mutagenesis, information like sequence length, training tissue, and training genes is used. Examples of these metadata files can be found under `code/metadata_from_past_runs`. If you prefer not to use W&B, then (1) all `wandb` calls in python scripts must be removed, (2) `config` files must be restructured within python training scripts, and (3) metadata files should be generated to maintain compatibility.


# Example Usage
To train single-gene and multi-gene Performer models on Whole Blood GTEx data using ~300 genes, run:
```
sh .code/submission_scripts/submit_gtex.sh
```
This will launch 6 SLURM jobs (3 single-gene & 3 multi-gene; training 3 replicates per model using different train/validation/test folds). Each job will be launched via `code/submission_scripts/slurm_train_gtex.sh`. Please update `slurm_train_gtex.sh` to match your requirements (see requirement #4 above). `slurm_train_gtex.sh` will launch `train_gtex.py` using configurations (e.g., learning rate, training tissue) from `code/configs/blood_config.yaml`. `train_gtex.py` will select the ~300 genes used in the paper and fine-tune Enformer’s pre-trained weights using paired WGS & RNA-seq.

## TODO:
1. Code to convert WGS VCF -> consensus sequence fasta
2. Add point 6 to requirements to process protected data with expected filestructure
