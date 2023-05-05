datasets=()
type=bnn1
for file in ../../models/$type/bitstrings/*; do datasets+=("$(basename "${file%%_*}")"); done
suffix=$(basename "$PWD")
rm products/*
rm tests/*
for fruit in "${datasets[@]}"
do
    sed "s/DATASETNAME/$fruit/g" template.cmd > cmdfile.cmd
    sed "s/TYPE/$type/g" -i cmdfile.cmd
    sed "s/SUFFIX/$suffix/g" -i cmdfile.cmd
    cp ../../trainingdata/samples/${fruit}.memh ./
    iverilog -c cmdfile.cmd modular_${suffix}.v -o products/${fruit}_${type}_${suffix}.v -E
    iverilog -c cmdfile.cmd tbmodular_${suffix}.v -o products/tb${fruit}_${type}_${suffix}.v -E
    iverilog -c cmdfile.cmd products/tb${fruit}_${type}_${suffix}.v products/${fruit}_${type}_${suffix}.v -o vtmp.vvp
    vvp  vtmp.vvp >  tests/v${fruit}_${type}_${suffix}.tst
    rm cmdfile.cmd
    rm vtmp.vvp
done
rm *.memh
