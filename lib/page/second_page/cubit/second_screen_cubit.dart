import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'second_screen_state.dart';

class SecondScreenCubit extends Cubit<SecondScreenState> {
  SecondScreenCubit() : super(const SecondScreenState());

  void onShowTotalPrice({String? value}) {
    emit(state.copyWith(totalPrice: value!));
  }
}
