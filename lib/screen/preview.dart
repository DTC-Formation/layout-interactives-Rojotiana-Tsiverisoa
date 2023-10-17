import 'package:flutter/material.dart';
import './form.dart';

class Preview extends StatefulWidget {
  const Preview({super.key});

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  String firstnameController = "...";
  String lastnameController = "";
  String sexeController = "...";
  double sizeController = 0;

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

  void updateSize(double newValue) {
    setState(() {
      sizeController = newValue;
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
                          text: const TextSpan(
                            text: 'Age: ',
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
                                text: '$sizeController (cm)',
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
                  text: const TextSpan(
                    text: 'BMI',
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
                updateSize: updateSize,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
