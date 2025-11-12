// import 'package:image/image.dart'
//     as img; // Add this dependency to handle image loading and preprocessing
// import 'package:tflite_flutter/tflite_flutter.dart';

// // Function to load and preprocess image
// Future<List<List<List<List<double>>>>> preprocessImage(String imagePath) async {
//   // Load the image from the assets (or file system)
//   var image = img.decodeImage(await File(imagePath).readAsBytes())!;

//   // Resize the image to match model input size (e.g., 224x224)
//   var resizedImage = img.copyResize(image, width: 224, height: 224);

//   // Convert image to a list of pixels and normalize (e.g., values between 0 and 1)
//   List<List<List<List<double>>>> processedImage = [];
//   for (var y = 0; y < 224; y++) {
//     List<List<double>> row = [];
//     for (var x = 0; x < 224; x++) {
//       var pixel = resizedImage.getPixel(x, y);
//       var r = img.getRed(pixel) / 255.0;
//       var g = img.getGreen(pixel) / 255.0;
//       var b = img.getBlue(pixel) / 255.0;
//       row.add([r, g, b]); // Assuming the model expects RGB values
//     }
//     processedImage.add(row);
//   }
//   return processedImage;
// }

// // Load the model and run inference
// Future<void> runInference(String imagePath) async {
//   // Load the model
//   final interpreter =
//       await Interpreter.fromAsset('assets/food_classifier.tflite');

//   // Preprocess the image
//   var input = await preprocessImage(imagePath);

//   // Define the output shape
//   var output = List.filled(1 * 2, 0)
//       .reshape([1, 2]); // Adjust shape based on your model's output

//   // Run inference
//   interpreter.run(input, output);

//   // Print the result
//   print(output);

//   // If the model has multiple inputs/outputs
//   var input0 = [1.23];
//   var input1 = [2.43];

//   // input: List<Object>
//   var inputs = [input0, input1, input0, input1];

//   var output0 = List<double>.filled(1, 0);
//   var output1 = List<double>.filled(1, 0);

//   // output: Map<int, Object>
//   var outputs = {0: output0, 1: output1};

//   // Inference with multiple inputs/outputs
//   interpreter.runForMultipleInputs(inputs, outputs);

//   // Print the multiple outputs
//   print(outputs);

//   // Close the interpreter
//   interpreter.close();
// }
