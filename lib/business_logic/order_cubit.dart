import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:qr_ieee/data/model/Data.dart';
import 'package:qr_ieee/data/model/OrdersModel.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  List<Data> ordersList = [];
  
  Future<void> getOrder(String phoneNumber) async {
    try {
      dynamic data = await rootBundle.loadString('assets/jsons/orders.json');
      data = json.decode(data);
      OrdersModel orders = OrdersModel.fromJson(data);
      ordersList.clear();
      for (Data order in orders.data!) {
        if (order.phone == phoneNumber) {
          ordersList.add(order);
        }
      }
      emit(OrderLoaded());
    } catch (e) {
      emit(OrderFailed());
    }

  }
}
