from flask import Flask, render_template, request, jsonify
from keras.models import load_model
from keras.preprocessing import image
import numpy as np

app = Flask(__name__)
# Loading custom trained model
custom_model = load_model('ecgdiseasepredictionmodel.h5')

@app.route('/', methods=['GET'])
def hello_word():
    return render_template('index.html')

@app.route('/', methods=['POST'])
def predict():
    imagefile = request.files['imagefile']
    image_path = "./images/" + imagefile.filename
    imagefile.save(image_path)   
    # Load and preprocess the image for prediction
    img = image.load_img(image_path, target_size=(224, 224))
    img_array = image.img_to_array(img)
    img_array = img_array / 255.0  # Normalize pixel values to the range [0, 1]
    img_data = np.expand_dims(img_array, axis=0)

    # Use your custom model for prediction
    result = custom_model.predict(img_data)

    # Get the predicted class index
    itemindex = np.argmax(result, axis=1)

    # Map the class index to the disease name
    reverse_mapping = ['N', 'M', 'S', 'Q', 'F', 'V']
    prediction_name = reverse_mapping[itemindex[0]]

    # Print the diagnosis information
    print("Probability of " + prediction_name + " is: " + str(np.max(result)))
    print("Final Diagnosis result: " + prediction_name)

    # Provide name for predicted result
    heart_disease = ''
    if prediction_name == "N":
        heart_disease = "Non-ectopic"
    elif prediction_name == "M":
        heart_disease = "Multifocal Atrial Tachycardia"
    elif prediction_name == "S":
        heart_disease = "Supraventricular ectopic"
    elif prediction_name == "Q":
        heart_disease = "Nodal"
    elif prediction_name == "F":
        heart_disease = "Atrial Flutter"
    elif prediction_name == "V":
        heart_disease = "Ventricular ectopic"
    else:
        heart_disease = "Normal Disease"

    print("Diagnosis: " + heart_disease)

    return jsonify({
        "message": heart_disease
    })

    # return render_template('index.html', prediction=heart_disease)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=4000)
