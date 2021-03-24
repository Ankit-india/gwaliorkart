import 'package:flutter/material.dart';
import 'package:gwaliorkart/models/order_data.dart';
import 'package:gwaliorkart/utils/auth_utils.dart';
import 'package:gwaliorkart/utils/constants.dart';
import 'package:gwaliorkart/widgets/widget_page.dart';

class OrderDetail extends StatefulWidget {
  final OrderData order;

  OrderDetail(this.order);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  MainAxisAlignment _mStart = MainAxisAlignment.start;
  MainAxisAlignment _mCenter = MainAxisAlignment.center;
  CrossAxisAlignment _cStart = CrossAxisAlignment.start;
  CrossAxisAlignment _cCenter = CrossAxisAlignment.center;
  OrderData _orderData;
  String _customerId;

  @override
  void initState() {
    _customerId = AuthUtils.userId;
    widget.order != null ? _orderData = widget.order : _orderData = _orderData;
    super.initState();
  }

  Widget _productDetailSection() {
    return Text("Product Name");
  }

  Widget _orderDetailBuilder() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: _cStart,
        mainAxisAlignment: _mStart,
        children: [
          WidgetPage.orderDetails(_orderData, context),
          Constants.height(30.0),
          WidgetPage.addressSection(_orderData, context),
          Constants.height(30.0),
          WidgetPage.productDetailSection(_orderData, context),
          Constants.height(30.0),
          WidgetPage.historySection(_orderData, context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetPage.dynamicAppBar('Order Details'),
      body: _orderData != null
          ? _orderDetailBuilder()
          : WidgetPage.noItemFound('No order found!'),
    );
  }
}
