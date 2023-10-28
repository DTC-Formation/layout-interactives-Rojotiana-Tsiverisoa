import 'dart:io';
import 'package:exercises/colors/my_colors.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';

import 'package:exercises/helpers/helpers.dart';
import 'package:exercises/screen/form.dart';

class Preview extends StatefulWidget {
  const Preview({super.key});

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  Helper helper = Helper();
  String firstnameController = "John";
  String lastnameController = "Doe";
  String sexeController = "Homme";
  String birthdayController = "";
  String age = "45";
  double heightController = 0;
  String weightController = "";
  double bmiController = 0;
  List<String> technoController = [''];
  List<String> hobbyController = [''];

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

  void updateTechnos(List<String> newValue) {
    setState(() {
      technoController = newValue;
    });
  }

  void updateHobbies(List<String> newValue) {
    setState(() {
      hobbyController = newValue;
    });
  }

  File? _selectedProfileImage, _selectedCoverImage;

  Future _pickProfileImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;
    setState(() {
      _selectedProfileImage = File(returnedImage.path);
      Navigator.pop(context);
    });
  }

  Future _pickCoverImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;
    setState(() {
      _selectedCoverImage = File(returnedImage.path);
      Navigator.pop(context);
    });
  }

  Future _pickProfileImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage == null) return;
    setState(() {
      _selectedProfileImage = File(returnedImage.path);
      Navigator.pop(context);
    });
  }

  Future _pickCoverImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage == null) return;
    setState(() {
      _selectedCoverImage = File(returnedImage.path);
      Navigator.pop(context);
    });
  }

  // File? _image;

  // Future _pickImage(ImageSource source) async {
  //   final image = await ImagePicker().pickImage(source: source);
  //   if (image == null) return;
  //   File? img = File(image.path);
  //   img = await _cropImage(imageFile: img);
  //   setState(() {
  //     _image = img;
  //   });
  // }

  // Future<File?> _cropImage({required File imageFile}) async {
  //   CroppedFile? croppedImage =
  //       await ImageCropper().cropImage(sourcePath: imageFile.path);
  //   if (croppedImage == null) return null;
  //   return File(croppedImage.path);
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    customInput(String title, String value) {
      var customInput = Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Container(
              width: size.width,
              height: 45,
              padding: const EdgeInsets.only(top: 10, left: 5),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: CustomColors.grey,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: Text(value),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
            ),
          ],
        ),
      );
      return customInput;
    }

    takePictureButton(var action1, var action2) {
      var button = ElevatedButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 170,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Pick image from',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: action1,
                            child: const Row(
                              children: [
                                Icon(Icons.image),
                                Text('Gallery'),
                              ],
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.only(right: 10, left: 10),
                              child: Text('Or')),
                          ElevatedButton(
                            onPressed: action2,
                            child: const Row(
                              children: [
                                Icon(Icons.photo_camera),
                                Text('Camera'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(5),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        child: const Icon(
          Icons.photo_camera,
        ),
      );

      return button;
    }

    return Column(
      children: [
        Stack(
          children: [
            Stack(
              children: [
                SizedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: _selectedCoverImage != null
                        ? Image.file(
                            _selectedCoverImage!,
                            width: size.width,
                            height: 220,
                            fit: BoxFit.cover,
                          )
                        : Image(
                            image: const AssetImage('assets/images/cover.webp'),
                            width: size.width,
                            height: 220,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 10,
                  child: takePictureButton(
                    _pickCoverImageFromGallery,
                    _pickCoverImageFromCamera,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 140, left: 10),
              child: Stack(
                children: [
                  _selectedProfileImage != null
                      ? SizedBox(
                          width: 135,
                          height: 135,
                          child: CircleAvatar(
                            child: ClipOval(
                              child: Image.file(
                                _selectedProfileImage!,
                                width: size.width,
                                height: size.height,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(
                          width: 135,
                          height: 135,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/profile.jpg'),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(top: 95, left: 80),
                    child: takePictureButton(
                      _pickProfileImageFromGallery,
                      _pickProfileImageFromCamera,
                    ),
                  ),
                ],
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
              customInput('Nom', firstnameController),
              customInput('Prénom', lastnameController),
              customInput('Age', age),
              customInput('Sexe', sexeController),
              customInput('Taille (cm)', heightController.toStringAsFixed(0)),
              customInput(
                'Liste des technologies',
                technoController.join(', '),
              ),
              customInput('BMI', bmiController.toStringAsFixed(2)),
              customInput('Loisirs', hobbyController.join(', ')),
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
                updateTechnos: updateTechnos,
                updateHobbies: updateHobbies,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
