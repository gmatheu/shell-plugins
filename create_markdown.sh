#! /bin/bash

PLUGIN_DIR=$1
PLUGIN_FILE=${2:-init.sh}

target_file=${PLUGIN_DIR}/README.md
source_file=${PLUGIN_DIR}/${PLUGIN_FILE}

grep -e '^##' ${source_file} | sed -e 's/##//' > ${target_file}

echo '' >> ${target_file}
echo '' >> ${target_file}
echo '## Functions' >> ${target_file}
echo '' >> ${target_file}
grep -B 1 -e '  ###' ${source_file} |\
    sed -e 's/###//' |\
    sed -E 's|^(..*).*\(\).*\{|### \1|' |\
    sed -e 's/--//' >> ${target_file}

echo '' >> ${target_file}
echo '' >> ${target_file}
echo '## Aliases' >> ${target_file}
echo '' >> ${target_file}
grep -e '^alias' ${source_file} |\
    sed -e 's/alias /* */' -e 's/=/*: /' >> ${target_file}

echo "Resulting file"
echo "=========================="

cat $target_file | gum format
