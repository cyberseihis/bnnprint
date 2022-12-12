import larq as lq
import keras


def contextise(mname: str):
    model = keras.models.load_model(mname)
    with lq.context.quantized_scope(True):
        model.save("bin"+mname)  # save binarized weights
