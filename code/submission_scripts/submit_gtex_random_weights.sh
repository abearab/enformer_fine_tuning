# config_path=configs/blood_config.yaml
config_path=configs/multi_gene_196kb_blood.yaml
model_type=MultiGene
seed=0

# for fold in 0 1 2; do
for fold in 0; do
    for random_weights in 0 1; do
        sbatch slurm_train_gtex_random_weights.sh $config_path $fold $seed $model_type $random_weights
    done
done

