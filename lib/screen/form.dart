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

  const MyForm({
    super.key,
    required this.updateFirstname,
    required this.updateLastname,
    required this.updateSexe,
    required this.updateBirthday,
    required this.updateHeight,
    required this.updateWeight,
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
  String sexeController = 'male';
  double heightController = 0;
  var weightController = TextEditingController();

  void updateDatePicker(String newValue) {
    setState(() {
      birthdayController = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    void onSubmit() {
      widget.updateFirstname(firstnameController.text);
      widget.updateLastname(lastnameController.text);
      widget.updateSexe(sexeController);
      widget.updateHeight(heightController);
      widget.updateBirthday(birthdayController);
      widget.updateWeight(weightController.text);
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
        // ************** Nom **************
        TextField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Nom',
          ),
          controller: firstnameController,
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
        ),

        // ************** Prénom **************
        TextField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Prénom',
          ),
          controller: lastnameController,
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
        ),

        // ************** Sexe **************
        // Row(
        // children: [
        const Text('Sexe'),
        RadioListTile<SexeChoice>(
          title: const Text('Male'),
          value: SexeChoice.male,
          groupValue: _sexe,
          onChanged: (SexeChoice? value) {
            setState(() {
              _sexe = value;
              sexeController = 'male';
            });
          },
        ),
        RadioListTile<SexeChoice>(
          title: const Text('Female'),
          value: SexeChoice.female,
          groupValue: _sexe,
          onChanged: (SexeChoice? value) {
            setState(() {
              _sexe = value;
              sexeController = 'female';
            });
          },
        ),
        // ],
        // ),

        // ************** Taille **************
        Row(
          children: [
            const Text('Taille (cm)'),
            Slider(
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
          ],
        ),
        // ************** Date de naissance **************
        Row(
          children: [
            const Text('Date de naissance'),
            MyDatePicker(
              updateDatePicker: updateDatePicker,
            ),
            Text(birthdayController),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
        ),
        // ************** Poids **************
        TextField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Poids (Kg)',
          ),
          controller: weightController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
        ),

        // ************** Loisirs **************
        Align(
          alignment: Alignment.center,
          child: OutlinedButton(
            onPressed: onSubmit,
            child: const Text('Valider'),
          ),
        )
      ],
    );
  }
}
