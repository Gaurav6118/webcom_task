part of 'item_cubit.dart';

class ItemState extends Equatable {
  const ItemState(
      {this.status = FormzStatus.pure,
        this.itemCount = 1,
        this.itemPrice = 25,
        this.totalPrice = 0});

  final FormzStatus status;
  final int itemCount;
  final int itemPrice;
  final int totalPrice;

  ItemState copyWith(
      {FormzStatus? status, int? itemCount, int? itemPrice, int? totalPrice}) {
    return ItemState(
      status: status ?? this.status,
      itemCount: itemCount ?? this.itemCount,
      itemPrice: itemPrice ?? this.itemPrice,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  List<Object?> get props => [
    status,
    itemCount,
    itemPrice,
    totalPrice,
  ];
}
