#!/usr/bin/env bash

SAMPLES=10
TOPP=($(seq 0.1 0.009 1.0))
DIR=cmdc_p_sweep

if [ ! -e $DIR ]; then
    mkdir $DIR
fi

seed=0

for p in "${TOPP[@]}"; do
        ((seed+=1))
        OUTPATH=./${DIR}/output.cmdc.uni.sample${SAMPLES}.topp${p}

        python run_generation_cmdc.py  --model_type gpt2 --model_name gpt2-large\
            --prompts_path cmdc_processed/test.enc.prompt.txt --output_path $OUTPATH\
            --length 20 --p $p --temperature 1. --samples_per_prompt $SAMPLES --seed $seed
    done