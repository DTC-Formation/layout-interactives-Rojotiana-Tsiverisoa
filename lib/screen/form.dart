import 'package:flutter/material.dart';

enum SexeChoice { male, female }

class MyForm extends StatefulWidget {
  final void Function(String) updateFirstname;
  final void Function(String) updateLastname;
  final void Function(String) updateSexe;
  final void Function(double) updateSize;
  const MyForm({
    super.key,
    required this.updateFirstname,
    required this.updateLastname,
    required this.updateSexe,
    required this.updateSize,
  });

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  SexeChoice? _sexe = SexeChoice.male;
  String sexeController = 'male';
  double sizeController = 0;

  @override
  Widget build(BuildContext context) {
    void onSubmit() {
      widget.updateFirstname(firstnameController.text);
      widget.updateLastname(lastnameController.text);
      widget.updateSexe(sexeController);
      widget.updateSize(sizeController);
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
              value: sizeController,
              max: 200,
              divisions: 5,
              label: sizeController.round().toString(),
              onChanged: (double value) {
                setState(() {
                  sizeController = value;
                });
              },
            ),
          ],
        ),
        // ************** Date de naissance **************
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
