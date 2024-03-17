#!/bin/bash

SOURCE_DIR=source
COMPARE_DIR=expected
OUTPUT_DIR=output

if [[ -d ${OUTPUT_DIR} ]]; then rm -fR ${OUTPUT_DIR}; fi
mkdir ${OUTPUT_DIR}

for input_file in ${SOURCE_DIR}/*.mau
do
    echo "${input_file}"

    filename=$(basename ${input_file})

    for format in yaml html
    do
        output_file=${OUTPUT_DIR}/${filename/.mau/.${format}}
        compare_file=${COMPARE_DIR}/${filename/.mau/.${format}}

        echo "  * Processing ${format^^} "
        mau -i ${input_file} -f ${format} -o ${output_file}

        echo -n "    Check: "

        result=$(diff ${compare_file} ${output_file})

        if [[ -z ${result} ]]; then echo "OK"; else echo "FAIL"; fi
    done
done

