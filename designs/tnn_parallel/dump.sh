datasets=(
    "cardio"
    "gasId"
    "Har"
    "pendigits"
    "winered"
    "winewhite")
suffix=tp
for fruit in "${datasets[@]}"
do
    sed "s/DATASETNAME/$fruit/g" template.cmd > cmdfile.cmd
    iverilog -c cmdfile.cmd modular_${suffix}.v -o products/${fruit}_${suffix}.v -E
    iverilog -c cmdfile.cmd tbmodular_${suffix}.v -o products/tb${fruit}_${suffix}.v -E
    iverilog -c cmdfile.cmd products/tb${fruit}_${suffix}.v products/${fruit}_${suffix}.v -o vtmp.vvp
    vvp  vtmp.vvp >  tests/v${fruit}_${suffix}.tst
    rm cmdfile.cmd
    rm vtmp.vvp
done
