import 'package:exercises/colors/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:exercises/widgets/datepicker.dart';
import 'package:exercises/helpers/helpers.dart';

enum SexeChoice { male, female }

class MyForm extends StatefulWidget {
  final void Function(String) updateFirstname;
  final void Function(String) updateLastname;
  final void Function(String) updateSexe;
  final void Function(String) updateBirthday;
  final void Function(double) updateHeight;
  final void Function(String) updateWeight;
  final void Function(List<String>) updateTechnos;
  final void Function(List<String>) updateHobbies;

  const MyForm({
    super.key,
    required this.updateFirstname,
    required this.updateLastname,
    required this.updateSexe,
    required this.updateBirthday,
    required this.updateHeight,
    required this.updateWeight,
    required this.updateTechnos,
    required this.updateHobbies,
  });

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  Helper helper = Helper();
  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  String birthdayController = "";
  SexeChoice? _sexe = SexeChoice.male;
  String sexeController = 'Homme';
  double heightController = 0;
  var weightController = TextEditingController();

  void updateDatePicker(String newValue) {
    setState(() {
      birthdayController = newValue;
    });
  }

  bool flutterIsChecked = false;
  bool javascriptIsChecked = false;
  bool phpIsChecked = false;

  List<String> technoController = [];

  void updateCheckedTechnos() {
    technoController.clear();
    if (flutterIsChecked) technoController.add("Flutter");
    if (javascriptIsChecked) technoController.add("Javascript");
    if (phpIsChecked) technoController.add("PHP");
  }

  bool swimmingIsChecked = false;
  bool watchingTvIsChecked = false;
  bool gamingIsChecked = false;

  List<String> hobbiesController = [];

  void updateCheckedHobbies() {
    hobbiesController.clear();
    if (swimmingIsChecked) hobbiesController.add("Nager");
    if (watchingTvIsChecked) hobbiesController.add("Regarder la télé");
    if (gamingIsChecked) hobbiesController.add("Jouer aux jeux vidéo");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    void onSubmit(BuildContext context) {
      widget.updateFirstname(firstnameController.text);
      widget.updateLastname(lastnameController.text);
      widget.updateSexe(sexeController);
      widget.updateHeight(heightController);
      widget.updateBirthday(birthdayController);
      widget.updateWeight(weightController.text);
      widget.updateTechnos(technoController);
      widget.updateHobbies(hobbiesController);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Donnée enregistrer!'),
          duration: Duration(seconds: 3),
        ),
      );
    }

    customInput(String label, TextEditingController controller,
        {TextInputType? keyboardType}) {
      return Column(
        children: [
          TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: label,
            ),
            controller: controller,
            keyboardType: keyboardType,
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
          ),
        ],
      );
    }

    customText(String text) {
      return Text(
        text,
        style: const TextStyle(
          fontSize: 17,
        ),
      );
    }

    return Column(
      children: [
        const Text(
          'Formulaire',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
        ),
        // ************** Nom & Prénom **************
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: customInput('Nom', firstnameController),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: customInput('Prénom', lastnameController),
              ),
            ),
          ],
        ),

        // ************** Sexe **************
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: CustomColors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText('Sexe'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: RadioListTile<SexeChoice>(
                          title: const Text('Homme'),
                          value: SexeChoice.male,
                          groupValue: _sexe,
                          onChanged: (SexeChoice? value) {
                            setState(() {
                              _sexe = value;
                              sexeController = 'Homme';
                            });
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: RadioListTile<SexeChoice>(
                          title: const Text('Femme'),
                          value: SexeChoice.female,
                          groupValue: _sexe,
                          onChanged: (SexeChoice? value) {
                            setState(() {
                              _sexe = value;
                              sexeController = 'Femme';
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
        ),
        // ************** Taille **************
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: CustomColors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 5,
            ),
            child: Row(
              children: [
                customText('Taille (cm)'),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: SizedBox(
                      width: size.width,
                      child: Slider(
                        value: heightController,
                        max: 200,
                        divisions: 5,
                        label: heightController.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            heightController = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
        ),
        // ************** Date de naissance **************
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: CustomColors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: customText('Date de naissance'),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(birthdayController),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: MyDatePicker(
                      updateDatePicker: updateDatePicker,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
        ),
        // ************** Poids **************
        customInput(
          'Poids (Kg)',
          weightController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
        // ************** Loisirs **************
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: CustomColors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: customText('Loisirs'),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: swimmingIsChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            swimmingIsChecked = value!;
                            updateCheckedHobbies();
                          });
                        },
                      ),
                      const Text('Nager'),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: watchingTvIsChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            watchingTvIsChecked = value!;
                            updateCheckedHobbies();
                          });
                        },
                      ),
                      const Text('Regarder la télé'),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: gamingIsChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            gamingIsChecked = value!;
                            updateCheckedHobbies();
                          });
                        },
                      ),
                      const Text('Jouer aux jeux vidéo'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
        ),
        // ************** Technos **************
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: CustomColors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: customText('Technos'),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: flutterIsChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            flutterIsChecked = value!;
                            updateCheckedTechnos();
                          });
                        },
                      ),
                      const Text('Flutter'),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: javascriptIsChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            javascriptIsChecked = value!;
                            updateCheckedTechnos();
                          });
                        },
                      ),
                      const Text('Javascript'),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: phpIsChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            phpIsChecked = value!;
                            updateCheckedTechnos();
                          });
                        },
                      ),
                      const Text('PHP'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: OutlinedButton(
            onPressed: () {
              onSubmit(context);
            },
            child: const Text('Valider'),
          ),
        ),
      ],
    );
  }
}
