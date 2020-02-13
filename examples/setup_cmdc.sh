#!/usr/bin/env bash

cmdc_raw=cmdc_raw
cmdc_processed=cmdc_processed


# download Cornell Movie Dialog Corpus
if [ ! -e "./$cmdc_raw" ]; then
    echo "== Download Cornell Movie Dialog Corpus =="
    mkdir $cmdc_raw
    wget -c 'https://www.dropbox.com/s/ncfa5t950gvtaeb/test.enc?dl=0' -O cmdc_raw/test.enc.txt
    wget -c 'https://www.dropbox.com/s/48ro4759jaikque/test.dec?dl=0' -O cmdc_raw/test.dec.txt
    wget -c 'https://www.dropbox.com/s/gu54ngk3xpwite4/train.enc?dl=0' -O cmdc_raw/train.enc.txt
    wget -c 'https://www.dropbox.com/s/g3z2msjziqocndl/train.dec?dl=0' -O cmdc_raw/train.dec.txt
    python preprocess_cmdc.py --dirpath cmdc_raw
fi

# process roc stories
echo "== Process Cornell Movie Dialog Corpus =="
rm -r $cmdc_processed
mkdir $cmdc_processed
python process_cmdc.py -i $cmdc_raw -o $cmdc_processed