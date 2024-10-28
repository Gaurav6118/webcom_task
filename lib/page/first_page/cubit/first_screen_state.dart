part of 'first_screen_cubit.dart';

class FirstScreenState extends Equatable {
  const FirstScreenState({
    this.status = FormzStatus.pure,
    this.name = const Validator.pure(),
    this.selectedDate,
    this.occupationList = const [],
    this.gender = "Male",
    this.occupation = "Select Occupation",
    this.imagePath = "",
    this.age = "",
  });

  final FormzStatus status;
  final Validator name;
  final DateTime? selectedDate;
  final String gender;
  final List<String> occupationList;
  final String occupation;
  final String imagePath;
  final String age;

  FirstScreenState copyWith({
    FormzStatus? status,
    Validator? name,
    DateTime? selectedDate,
    String? gender,
    List<String>? occupationList,
    String? occupation,
    String? imagePath,
    String? age,
  }) {
    return FirstScreenState(
      status: status ?? this.status,
      name: name ?? this.name,
      selectedDate: selectedDate ?? this.selectedDate,
      gender: gender ?? this.gender,
      occupationList: occupationList ?? this.occupationList,
      occupation: occupation ?? this.occupation,
      imagePath: imagePath ?? this.imagePath,
      age: age ?? this.age,
    );
  }

  @override
  List<Object?> get props => [
        status,
        name,
        selectedDate,
        gender,
        occupationList,
        occupation,
        imagePath,
        age
      ];
}
