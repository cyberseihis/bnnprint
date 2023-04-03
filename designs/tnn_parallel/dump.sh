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
    iverilog -c cmdfile.cmd -y ../argmax/ tndemo.v -o products/${fruit}tnn.v -E
    iverilog -c cmdfile.cmd tbtndemo.v -o products/tb${fruit}tnn.v -E
done
