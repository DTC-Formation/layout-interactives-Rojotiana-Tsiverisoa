import 'package:flutter/material.dart';
import './form.dart';
import 'package:exercises/helpers/helpers.dart';

class Preview extends StatefulWidget {
  const Preview({super.key});

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  Helper helper = Helper();
  String firstnameController = "...";
  String lastnameController = "";
  String sexeController = "...";
  String birthdayController = "";
  String age = "";
  double heightController = 0;
  String weightController = "";
  double bmiController = 0;

  void updateFirstname(String newValue) {
    setState(() {
      firstnameController = newValue;
    });
  }

  void updateLastname(String newValue) {
    setState(() {
      lastnameController = newValue;
    });
  }

  void updateSexe(String newValue) {
    setState(() {
      sexeController = newValue;
    });
  }

  void updateHeight(double newValue) {
    setState(() {
      heightController = newValue;
    });
  }

  void updateBirthday(String newValue) {
    setState(() {
      birthdayController = newValue;
      age = "${helper.ageCalculator(birthdayController).toString()} ans";
    });
  }

  void updateWeight(String newValue) {
    setState(() {
      weightController = newValue;
      bmiController = helper.bmiCalculator(
          heightController, (double.parse(weightController)));
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Image.network(
                  'https://images.pexels.com/photos/18096084/pexels-photo-18096084/free-photo-of-homme-mains-appareil-photo-photographe.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                  width: size.width,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 50),
              child: SizedBox(
                width: 150,
                height: 150,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://images.pexels.com/photos/18250682/pexels-photo-18250682/free-photo-of-studio-portrait.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                ),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // ************** Fullname **************
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    text: 'Nom et prénom: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: "$firstnameController $lastnameController",
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),

              // ************** Age - Sexe - Taille **************
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Age: ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(
                                text: age,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Sexe: ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(
                                text: sexeController,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Taille: ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(
                                text: '$heightController (cm)',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ************** Liste des technologies **************
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: const TextSpan(
                    text: 'Liste des technologies: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: '....',
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),

              // ************** BMI **************
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    text: 'BMI: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: bmiController.toStringAsFixed(2),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),

              // ************** Loisirs **************
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: const TextSpan(
                    text: 'Loisirs: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: '....',
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),

              const Divider(),

              MyForm(
                updateFirstname: updateFirstname,
                updateLastname: updateLastname,
                updateSexe: updateSexe,
                updateHeight: updateHeight,
                updateBirthday: updateBirthday,
                updateWeight: updateWeight,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
