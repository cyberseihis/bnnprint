datasets=(
    "cardio"
    "gasId"
    "Har"
    "pendigits"
    "winequality_red"
    "winequality_white")
for fruit in "${datasets[@]}"
do
    sed "s/DATASETNAME/$fruit/g" template.cmd > cmdfile.cmd
    iverilog -c cmdfile.cmd -y ../argmax/ wrap_seq_tnn.v -o products/${fruit}_ts.v -E
    iverilog -c cmdfile.cmd tbwrap_seq_tnn.v -o products/tb${fruit}_ts.v -E
done
