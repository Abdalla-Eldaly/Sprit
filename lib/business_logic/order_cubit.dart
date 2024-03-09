import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:qr_ieee/data/model/Data.dart';
import 'package:qr_ieee/data/model/OrdersModel.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());
  
  Future<List<Data>> getOrder(String phoneNumber) async {
    dynamic data = await rootBundle.loadString('assets/jsons/orders.json');
    data = json.decode(data);
    OrdersModel orders = OrdersModel.fromJson(data);
    List<Data> ordersList = [];
    for (Data order in orders.data!) {
      if (order.phone == phoneNumber) {
        ordersList.add(order);
      }
    }
    return ordersList;
  }
}
