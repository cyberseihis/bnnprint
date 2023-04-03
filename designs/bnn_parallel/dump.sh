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
    iverilog -c cmdfile.cmd -y ../argmax/ bndemo.v -o products/${fruit}_bp.v -E
    iverilog -c cmdfile.cmd tbbndemo.v -o products/tb${fruit}_bp.v -E
done
