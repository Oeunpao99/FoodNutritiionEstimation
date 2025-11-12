import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fnapp/screens/progress_screens.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class FoodRecognitionScreen extends StatefulWidget {
  final String scanOption;

  const FoodRecognitionScreen({Key? key, required this.scanOption})
      : super(key: key);

  @override
  _FoodRecognitionScreenState createState() => _FoodRecognitionScreenState();
}

class _FoodRecognitionScreenState extends State<FoodRecognitionScreen> {
  File? _image;
  String _result = "No food detected.";
  String _nutritionInfo = "Nutrition details will appear here.";
  bool _isLoading = false; // Loading state

  final List<String> _foodClasses = [
    "Amok",
    "apple",
    "BorBor",
    "Cha Loc Lac",
    "Chicken Rice",
    "Lemongrass BBQ Beef Skewers",
    "Lort Cha",
    "Nom Banh Chok",
    "Omelette Rice with Pork",
    "Orange Fruit",
    "Red Curry Coconut Wings",
    "Samlar KorKour"
  ];

  final Map<String, Map<String, double>> _nutritionData = {
    "Amok": {"calories": 453, "carbs": 22, "fat": 9, "protein": 38},
    "apple": {"calories": 30.55, "carbs": 6.08, "fat": 0.23, "protein": 0.57},
    "BorBor": {"calories": 342.05, "carbs": 51.63, "fat": 0.1, "protein": 3.99},
    "Cha Loc Lac": {
      "calories": 338.7,
      "carbs": 11.42,
      "fat": 4.4,
      "protein": 30.93
    },
    "Chicken Rice": {
      "calories": 216.84,
      "carbs": 11.94,
      "fat": 2.48,
      "protein": 48.01
    },
    "Lemongrass BBQ Beef Skewers": {
      "calories": 611.65,
      "carbs": 13.43,
      "fat": 3.5,
      "protein": 88.49
    },
    "Lort Cha": {
      "calories": 216.84,
      "carbs": 11.94,
      "fat": 2.48,
      "protein": 48.01
    },
    "Nom Banh Chok": {
      "calories": 523.31,
      "carbs": 29.95,
      "fat": 1.73,
      "protein": 8.11
    },
    "Omelette Rice with Pork": {
      "calories": 275.08,
      "carbs": 19.01,
      "fat": 10.12,
      "protein": 4.96
    },
    "Orange Fruit": {
      "calories": 216.84,
      "carbs": 11.94,
      "fat": 2.48,
      "protein": 48.01
    },
    "Red Curry Coconut Wings": {
      "calories": 789.54,
      "carbs": 38.59,
      "fat": 3.18,
      "protein": 19.66
    },
    "Samlar KorKour": {
      "calories": 974.73,
      "carbs": 166.61,
      "fat": 96.03,
      "protein": 15.44
    },
  };

  // get http => null;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: widget.scanOption == 'camera'
          ? ImageSource.camera
          : ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _isLoading = true; // Start loading
      });

      await _runInference(pickedFile.path);
    }
  }

  Future<List<List<List<List<double>>>>> _preprocessImage(
      String imagePath) async {
    var image = img.decodeImage(await File(imagePath).readAsBytes())!;
    var resizedImage = img.copyResize(image, width: 224, height: 224);

    return List.generate(1, (_) {
      return List.generate(224, (y) {
        return List.generate(224, (x) {
          var pixel = resizedImage.getPixel(x, y);
          return [
            img.getRed(pixel) / 255.0,
            img.getGreen(pixel) / 255.0,
            img.getBlue(pixel) / 255.0,
          ];
        });
      });
    });
  }

  Future<void> _runInference(String imagePath) async {
    try {
      final interpreter = await Interpreter.fromAsset(
          'assets/images/food_classifier_model.tflite');
      var input = await _preprocessImage(imagePath);
      var output = List.filled(1 * _foodClasses.length, 0.0)
          .reshape([1, _foodClasses.length]);

      interpreter.run(input, output);
      interpreter.close();

      List<double> scores = List<double>.from(output[0]);
      int predictedIndex =
          scores.indexOf(scores.reduce((a, b) => a > b ? a : b));
      String foodName = _foodClasses[predictedIndex];
      Map<String, double> nutrition = _nutritionData[foodName] ?? {};

      await Future.delayed(Duration(seconds: 2)); // Simulate processing time

      setState(() {
        _result = foodName;
        _nutritionInfo = nutrition.isNotEmpty
            ? "🍽️ $foodName\n\n"
                "🔥 Calories: ${nutrition['calories']} kcal\n"
                "🍞 Carbs: ${nutrition['carbs']} g\n"
                "🥑 Fat: ${nutrition['fat']} g\n"
                "🍗 Protein: ${nutrition['protein']} g"
            : "⚠️ Nutrition data not available.";
        _isLoading = false; // Stop loading
      });

      _showAddToServingDialog(foodName, nutrition);
    } catch (e) {
      setState(() {
        _result = "❌ Error detecting food.";
        _nutritionInfo = "⚠️ An error occurred during food recognition.";
        _isLoading = false; // Stop loading
      });
      print("Error during inference: $e");
    }
  }

  void _showAddToServingDialog(String foodName, Map<String, double> nutrition) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add to Serving"),
          content: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Would you like to add ",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
                TextSpan(
                  text: "$foodName",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                TextSpan(
                  text: " to your serving?\n\nNutrition:\n",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
                TextSpan(
                  text: "Calories: ${nutrition['calories']} kcal\n",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
                TextSpan(
                  text: "Carbs: ${nutrition['carbs']} g\n",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
                TextSpan(
                  text: "Fat: ${nutrition['fat']} g\n",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
                TextSpan(
                  text: "Protein: ${nutrition['protein']} g",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildServingButton(0.5),
                SizedBox(width: 16),
                _buildServingButton(1),
                SizedBox(width: 16),
                _buildServingButton(1.5),
                SizedBox(width: 16),
                _buildServingButton(2),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildServingButton(double servingSize) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
        _saveMeal(servingSize);
      },
      child: Text(
        "$servingSize",
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 21, 205, 11),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  void _saveMeal(double servingSize) async {
    Map<String, double> selectedNutrition = _nutritionData[_result] ?? {};

    if (selectedNutrition.isNotEmpty) {
      selectedNutrition.update('calories', (value) => value * servingSize);
      selectedNutrition.update('carbs', (value) => value * servingSize);
      selectedNutrition.update('fat', (value) => value * servingSize);
      selectedNutrition.update('protein', (value) => value * servingSize);

      // Print data before sending
      print("Sending data: ${{
        'user_id': '20', // Replace with actual user ID
        'calories': selectedNutrition['calories'].toString(),
        'fat': selectedNutrition['fat'].toString(),
        'protein': selectedNutrition['protein'].toString(),
        'carbs': selectedNutrition['carbs'].toString(),
        'serving_size': servingSize.toString(),
      }}");

      try {
        final response = await http.post(
          Uri.parse(
              'http://10.0.2.2/php-practics/fnapp/fnapp_backend/save_meal.php'),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: {
            'user_id': '20',
            'calories': selectedNutrition['calories'].toString(),
            'fat': selectedNutrition['fat'].toString(),
            'protein': selectedNutrition['protein'].toString(),
            'carbs': selectedNutrition['carbs'].toString(),
            'serving_size': servingSize.toString(),
          },
        );

        print("Response: ${response.statusCode}, ${response.body}");

        if (response.statusCode == 200) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ProgressScreens(
                userId: 'yourUserId', // Pass the userId
                nutritionData: {
                  'calories': 1500, // Pass the nutrition data
                  'protein': 50,
                  'fat': 40,
                  'carbs': 200,
                },
              ),
            ),
          );
        } else {
          print('Error: ${response.statusCode}, ${response.body}');
        }
      } catch (e) {
        print('Exception: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Recognition'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading) CircularProgressIndicator(),
            if (!_isLoading) ...[
              // Outer Circle for Progress
              CircleAvatar(
                radius: 150, // Outer circle size
                backgroundColor: Colors.blue.shade100,
                child: CircleAvatar(
                  radius: 140, // Inner circle size for image
                  backgroundColor: Colors.transparent,
                  child: _image == null
                      ? Icon(
                          Icons.camera_alt,
                          size: 100,
                          color: Colors.blue.shade600,
                        )
                      : ClipOval(
                          child: Image.file(
                            _image!,
                            fit: BoxFit.cover,
                            width: 280,
                            height: 280,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                _result,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                _nutritionInfo,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text("Scan or Upload Food"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
