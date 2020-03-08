#!/usr/bin/env bash

SAMPLES=10
TOPK_FILE=logspace_1_32k_101.txt
DIR=cmdc_k_sweep

if [ ! -e $DIR ]; then
    mkdir $DIR
fi

seed=0

cat $TOPK_FILE | while read k
do
    ((seed+=1))
    OUTPATH=./${DIR}/output.cmdc.uni.sample${SAMPLES}.topk${k}

    python run_generation_cmdc.py  --model_type gpt2 --model_name gpt2-large\
        --prompts_path cmdc_processed/test.enc.prompt.txt --output_path $OUTPATH\
        --length 20 --k $k --temperature 1. --samples_per_prompt $SAMPLES --seed $seed
done