import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:webcom/model/validator.dart';

part 'first_screen_state.dart';

class FirstScreenCubit extends Cubit<FirstScreenState> {
  FirstScreenCubit() : super( const FirstScreenState(
    occupationList: ['Select Occupation', 'Student', 'Teacher', 'Doctor', 'Other']
  ));

  void onNameChanged({String? value}) {
    emit(state.copyWith(
        name: Validator.dirty(value.toString()),
        status: Formz.validate([
          Validator.dirty(value.toString()),
          state.name,
        ])));
  }


  void pickDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      final age = calculateAge(pickedDate);
      emit(state.copyWith(selectedDate: pickedDate, age: age));
    }

    emit(state.copyWith(selectedDate: pickedDate));
  }

  String calculateAge(DateTime birthDate) {
    final today = DateTime.now();
    int years = today.year - birthDate.year;
    int months = today.month - birthDate.month;
    int days = today.day - birthDate.day;

    if (days < 0) {
      months -= 1;
      days += DateTime(today.year, today.month, 0).day;
    }
    if (months < 0) {
      years -= 1;
      months += 12;
    }

    return '$years years, $months months, $days days';
  }

  void onChangeGender({String? gender}){
    emit(state.copyWith(gender: gender));
  }

  void onChangeOccupation({String? value}) {
    emit(state.copyWith(occupation: value));
  }
  void addProfilePhotoPath({String? value}) {
    emit(state.copyWith(imagePath: value));
  }
}
