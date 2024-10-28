import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webcom/help/box_style.dart';
import 'package:webcom/help/route_arugument.dart';
import 'package:webcom/help/app_config.dart' as config;
import 'package:webcom/page/first_page/cubit/first_screen_cubit.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key, this.routeArguments});

  final RouteArguments? routeArguments;

  static Route route({RouteArguments? routeArguments}) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
            create: (context) {
              return FirstScreenCubit();
            },
            child: const FirstScreen()));
  }

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final nameController = TextEditingController();
  final occupationController = TextEditingController();

  @override
  void initState() {
    nameController.addListener(() {
      if (nameController.text.isNotEmpty) {
        context
            .read<FirstScreenCubit>()
            .onNameChanged(value: nameController.text.trim());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    occupationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirstScreenCubit, FirstScreenState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              leading: const SizedBox(),
              centerTitle: true,
              title: const Text('First Screen'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(config.AppConfig(context).appWidth(5)),
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        errorText:
                            state.name.invalid ? "Please enter name" : null,
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.red,
                              width: config.AppConfig(context).appWidth(0.2)),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.red,
                              width: config.AppConfig(context).appWidth(0.6)),
                        ),
                        hintText: 'Enter Name',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).focusColor,
                          ),
                        ),
                        fillColor: Colors.transparent,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              config.AppConfig(context).appHeight(1.0)),
                        ),
                        contentPadding: EdgeInsets.all(
                            config.AppConfig(context).appWidth(2.0)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              config.AppConfig(context).appHeight(1.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: config.AppConfig(context).appHeight(2),
                    ),
                    CommonContainer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Age: ${state.selectedDate != null ? state.age : 'Select Age'}'),
                          IconButton(
                            icon: const Icon(
                              Icons.calendar_month,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              context
                                  .read<FirstScreenCubit>()
                                  .pickDate(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: config.AppConfig(context).appHeight(2),
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 'Male',
                          groupValue: state.gender,
                          fillColor: WidgetStateProperty.all(Colors.blue),
                          onChanged: (value) {
                            context
                                .read<FirstScreenCubit>()
                                .onChangeGender(gender: value.toString());
                          },
                        ),
                        const Text('Male'),
                        Radio(
                          value: 'Female',
                          groupValue: state.gender,
                          fillColor: WidgetStateProperty.all(Colors.blue),
                          onChanged: (value) {
                            context
                                .read<FirstScreenCubit>()
                                .onChangeGender(gender: value.toString());
                          },
                        ),
                        const Text('Female'),
                      ],
                    ),
                    SizedBox(
                      height: config.AppConfig(context).appHeight(2),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: DropdownButton<String>(
                        elevation: 0,
                        dropdownColor: Colors.lightBlue[50],
                        menuWidth: config.AppConfig(context).appWidth(80),
                        hint: const Text("Select Occupation)"),
                        value: state.occupation,
                        onChanged: (newValue) {
                          context
                              .read<FirstScreenCubit>()
                              .onChangeOccupation(value: newValue);
                        },
                        items: state.occupationList.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                      ),
                    ),
                    state.occupation == 'Other'
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: config.AppConfig(context).appHeight(2),
                              ),
                              TextFormField(
                                controller: occupationController,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: 'Enter Occupation',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).focusColor,
                                    ),
                                  ),
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        config.AppConfig(context)
                                            .appHeight(1.0)),
                                  ),
                                  contentPadding: EdgeInsets.all(
                                      config.AppConfig(context).appWidth(2.0)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        config.AppConfig(context)
                                            .appHeight(1.0)),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: config.AppConfig(context).appHeight(2),
                    ),
                    InkWell(
                      onTap: () {
                        showUploadOptions().then((value){
                          context.read<FirstScreenCubit>().addProfilePhotoPath(value: value);
                        });
                      },
                      child: CommonContainer(
                        height: 30,
                        borderColor: state.imagePath.isNotEmpty ? Colors.transparent : Colors.black,
                        child: state.imagePath.isNotEmpty ?
                        Image.file(File(state.imagePath),fit: BoxFit.cover,)
                        : Icon(
                          Icons.add_a_photo,
                          size: config.AppConfig(context).appHeight(15),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: config.AppConfig(context).appHeight(10),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (state.status.isValid) {
                          if (state.age.isNotEmpty) {
                            if (state.gender.isNotEmpty) {
                              if (state.occupation.isNotEmpty &&
                                  state.occupation != "Select Occupation") {
                                if (state.occupation == 'Other') {
                                  // enter other occupation
                                  if (occupationController.text
                                      .trim()
                                      .isEmpty) {
                                    showToast(
                                        message: "Please Enter Occupation");
                                  } else {
                                    if (state.imagePath.isNotEmpty) {
                                      Navigator.of(context).pushNamed(
                                          '/SecondScreen',
                                          arguments: RouteArguments(
                                            name: state.name.value.toString(),
                                            age: state.age.toString(),
                                            gender: state.gender.toString(),
                                            occupation: occupationController
                                                .text
                                                .trim()
                                                .toString(),
                                            profilePhoto:
                                                state.imagePath.toString(),
                                          ));
                                    } else {
                                      // select camera image
                                      showToast(
                                          message: "Please Add Profile Photo");
                                    }
                                  }
                                } else {
                                  if (state.imagePath.isNotEmpty) {
                                    Navigator.of(context)
                                        .pushNamed('/SecondScreen',
                                            arguments: RouteArguments(
                                              name: state.name.value.toString(),
                                              age: state.age.toString(),
                                              gender: state.gender.toString(),
                                              occupation:
                                                  state.occupation.toString(),
                                              profilePhoto:
                                                  state.imagePath.toString(),
                                            ));
                                  } else {
                                    // select camera image
                                    showToast(
                                        message: "Please Add Profile Photo");
                                  }
                                }
                              } else {
                                // select occupation
                                showToast(message: "Please Select Occupation");
                              }
                            } else {
                              //gender
                              showToast(message: "Please Select Gender");
                            }
                          } else {
                            //age
                            showToast(message: "Please Select Age");
                          }
                        } else {
                          showToast(message: "Please Enter name");
                        }
                      },
                      child: const Text('Continue'),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  // Method to pick the image
  Future<dynamic> pickImage({ImageSource? source}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source!);
    return pickedFile!.path;
  }

  // Method to show bottom sheet
  Future<dynamic> showUploadOptions() {
   return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: config.AppConfig(context).appHeight(20),
          width: config.AppConfig(context).appWidth(100),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Upload Image", style: TextStyle(fontSize: 20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      pickImage(source: ImageSource.camera).then((value){
                        if(value != null){
                          Navigator.of(context).pop(value);
                        }
                      });
                    }, // Pick from camera
                    child: const Text("Camera"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      pickImage(source: ImageSource.gallery).then((value){
                        if(value != null){
                          Navigator.of(context).pop(value);
                        }
                      });
                    }, // Pick from gallery
                    child: const Text("Gallery"),
                  ),
                ],
              )
            ],
          ),
        );
      },
    ).then((value){
      if(value != null){
        return value;
      }
    });
  }

  void showToast({String? message}) {
    Fluttertoast.showToast(
      msg: message!,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
