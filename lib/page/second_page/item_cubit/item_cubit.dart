import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'item_state.dart';

class ItemCubit extends Cubit<ItemState> {
  ItemCubit() : super(const ItemState());

  void increment() {
    var count = state.itemCount + 1;
    var totalPrice = state.itemPrice * count;
    emit(state.copyWith(totalPrice: totalPrice, itemCount: count));
  }

  void decrement() {
    if (state.itemCount > 1) {
      var count = state.itemCount - 1;
      var totalPrice = state.itemPrice * count;
      emit(state.copyWith(totalPrice: totalPrice, itemCount: count));
    }
  }
}
