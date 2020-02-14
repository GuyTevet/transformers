#!/usr/bin/env bash

SAMPLES=10
TEMPS=($(seq 0.1 0.01 1.11))
DIR=cmdc_sweep

if [ ! -e $DIR ]; then
    mkdir $DIR
fi

seed=0

for t in "${TEMPS[@]}"; do
        ((seed+=1))
        OUTPATH=./${DIR}/output.cmdc.uni.sample${SAMPLES}.temp${t}

        python run_generation_cmdc.py  --model_type gpt2 --model_name gpt2-large\
            --prompts_path cmdc_processed/test.enc.prompt.txt --output_path $OUTPATH\
            --length 20 --p=1. --temperature $t --samples_per_prompt $SAMPLES --seed $seed
    done