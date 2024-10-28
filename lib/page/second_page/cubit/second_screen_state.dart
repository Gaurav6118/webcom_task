part of 'second_screen_cubit.dart';

class SecondScreenState extends Equatable {
  const SecondScreenState(
      {this.status = FormzStatus.pure,
      this.totalPrice = ''});

  final FormzStatus status;
  final String totalPrice;

  SecondScreenState copyWith(
      {FormzStatus? status, String? totalPrice}) {
    return SecondScreenState(
      status: status ?? this.status,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  List<Object?> get props => [
        status,
        totalPrice,
      ];
}
