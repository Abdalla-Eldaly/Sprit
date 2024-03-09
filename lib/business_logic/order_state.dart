part of 'order_cubit.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}
class OrderLoaded extends OrderState {}
class OrderFailed extends OrderState {}
