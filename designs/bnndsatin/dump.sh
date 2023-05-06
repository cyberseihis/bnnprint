datasets=()
type=bnn1
for file in ../../models/$type/bitstrings/*; do datasets+=("$(basename "${file%%_*}")"); done
suffix=$(basename "$PWD")
rm products/*
rm tests/*
for fruit in "${datasets[@]}"
do
    sed "s/DATASETNAME/$fruit/g" template.cmd > cmdfile${fruit}.cmd
    sed "s/TYPE/$type/g" -i cmdfile${fruit}.cmd
    sed "s/SUFFIX/$suffix/g" -i cmdfile${fruit}.cmd
    cp ../../trainingdata/samples/${fruit}.memh ./
    iverilog -c cmdfile${fruit}.cmd modular_${suffix}.v -o products/${fruit}_${type}_${suffix}.v -E
    iverilog -c cmdfile${fruit}.cmd tbmodular_${suffix}.v -o products/tb${fruit}_${type}_${suffix}.v -E
    iverilog -c cmdfile${fruit}.cmd products/tb${fruit}_${type}_${suffix}.v products/${fruit}_${type}_${suffix}.v -o vtmp${fruit}.vvp
    vvp vtmp${fruit}.vvp >  tests/v${fruit}_${type}_${suffix}.tst &
    # rm cmdfile${fruit}.cmd
    # rm vtmp${fruit}.vvp
done
# rm *.memh
