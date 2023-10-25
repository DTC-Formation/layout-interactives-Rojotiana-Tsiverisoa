import 'dart:io';
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
  String firstnameController = "...";
  String lastnameController = "";
  String sexeController = "...";
  String birthdayController = "";
  String age = "";
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
                  child: ElevatedButton(
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
                                        onPressed: _pickCoverImageFromGallery,
                                        child: const Row(
                                          children: [
                                            Icon(Icons.image),
                                            Text('Gallery'),
                                          ],
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(
                                              right: 10, left: 10),
                                          child: Text('Or')),
                                      ElevatedButton(
                                        onPressed: _pickCoverImageFromCamera,
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
                  ),
                )
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
                    child: ElevatedButton(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed:
                                              _pickProfileImageFromGallery,
                                          child: const Row(
                                            children: [
                                              Icon(Icons.image),
                                              Text('Gallery'),
                                            ],
                                          ),
                                        ),
                                        const Padding(
                                            padding: EdgeInsets.only(
                                                right: 10, left: 10),
                                            child: Text('Or')),
                                        ElevatedButton(
                                          onPressed:
                                              _pickProfileImageFromCamera,
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
                  text: TextSpan(
                    text: 'Liste des technologies: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: technoController.join(', '),
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
                  text: TextSpan(
                    text: 'Loisirs: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: hobbyController.join(', '),
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
