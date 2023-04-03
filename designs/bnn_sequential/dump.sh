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
    iverilog -c cmdfile.cmd -y ../argmax/ wrap_seq_bnn.v -o products/${fruit}_bs.v -E
    iverilog -c cmdfile.cmd tbwrap_seq_bnn.v -o products/tb${fruit}_bs.v -E
done
