// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class BodyMassIndex extends StatefulWidget {
  const BodyMassIndex({super.key});

  @override
  State<BodyMassIndex> createState() {
    return _BodyMassIndexState();
  }
}

class _BodyMassIndexState extends State<BodyMassIndex> {
  double? bmi;
  String category="";
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  int selected = 0;

  void _getBMI() {
    final height = double.parse(_heightController.text);
    final weight = double.parse(_weightController.text);
    final heightIsValid = height <= 0;
    final weightIsValid = weight <= 0;
    if (heightIsValid || weightIsValid) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Please make sure a valid height and weight are entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }
    setState(() {
      bmi = weight / ((height / 100) * (height / 100));
    });
  }

  void _getCategory(double bmi){
    setState(() {
      if (bmi < 18.5) {
      category="Underweight";
    } else if (bmi >= 18.5 && bmi < 24.9) {
      category="Normal weight";
    } else if (bmi >= 25 && bmi < 29.9) {
     category="Overweight";
    } else {
      category="Obesity";
    }
    });
  }

  Widget genderRadio(String type, int index,Color c) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selected = index;
        });
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(150, 80),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: BorderSide(color: (selected == index) ? Colors.black : Colors.grey),
        backgroundColor: (selected==index)? c: Colors.grey,
        
      ),
      child: Text(type,style: TextStyle(
        color: (selected==index)? Colors.white: Colors.black,
        fontSize: 20
      ),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(197, 16, 29, 39),
          title: const Text("BMI Calculator",
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 184, 233, 226),
                  Color.fromARGB(255, 255, 255, 255),
                ],begin: Alignment.topCenter,end: Alignment.bottomCenter),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: double.infinity, height: 20),
                       const Center(
                        child: Text(
                          "Select Gender",
                          style: TextStyle(fontSize: 20,color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: double.infinity, height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          genderRadio('Male', 1,const Color.fromARGB(255, 60, 74, 226)),
                          const SizedBox(width: 20),
                          genderRadio('Female', 0,const Color.fromARGB(255, 221, 69, 198)),
                        ],
                      ),
                      const SizedBox(width: double.infinity, height: 30),
                      const Text("Your Height in Cm:", style: TextStyle(fontSize: 20)),
                      const SizedBox(width: double.infinity, height: 8),
                      TextField(
                        textAlign: TextAlign.center,
                        controller: _heightController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "Enter Height in Cm",
                          suffixText: 'cm',
                        ),
                      ),
                      const SizedBox(width: double.infinity, height: 30),
                      const Text("Your Weight in Kg:", style: TextStyle(fontSize: 20)),
                      const SizedBox(width: double.infinity, height: 8),
                      TextField(
                        textAlign: TextAlign.center,
                        controller: _weightController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "Enter Weight in Kg",
                          suffixText: 'Kg',
                        ),
                      ),
                      const SizedBox(height: 40),
                      Container(
                        color: Colors.blue,
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
                          onPressed: (){
                            _getBMI();
                            _getCategory(bmi!);
                          },
                          child: const Text(
                            'Calculate',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        width: double.infinity,
                        child: const Text(
                          'Your BMI is:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        width: double.infinity,
                        child: Text(
                          bmi == null ? '' : bmi!.toStringAsFixed(2),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        width: double.infinity,
                        child: Text("Category: $category",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}