import os
import argparse

def run(params):

    input_list = [os.path.join(params.i, f) for f in os.listdir(params.i) if f.endswith('.txt')]

    for in_path in input_list:

        f_in = open(in_path, 'r', encoding='ISO-8859-1')
        f_out_prompt = open(os.path.join(params.o, os.path.basename(in_path)).replace('.txt','.prompt.txt'), 'w')
        f_out_end = open(os.path.join(params.o, os.path.basename(in_path)).replace('.txt','.end.txt'), 'w')

        for line in f_in:

            # process line
            line = line.replace(" ' ", "'")
            # line = line.replace(" i ", " I ")
            line = line.replace("  ", " ")
            # line = line[0].upper() + line[1:] if len(line) > 0 else line

            # check validity
            words = line.split(' ')
            valid_words = [w for w in words if len(w) > 0]
            if len(valid_words) < params.prompt_len + 1:
                continue

            # write output
            f_out_prompt.write(' '.join(valid_words[:params.prompt_len]) + '\n')
            f_out_end.write(' '.join(valid_words[params.prompt_len:]))

        f_in.close(); f_out_prompt.close(); f_out_end.close()

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Generate internal experimet")

    # main parameters
    parser.add_argument("-i", type=str, default='cmdc_raw', help='Input dir')
    parser.add_argument("-o", type=str, default='cmdc_processed', help='Output dir')
    parser.add_argument("-prompt_len", type=int, default='3', help='Num of words in prompt')
    params = parser.parse_args()
    run(params)