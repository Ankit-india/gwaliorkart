// import 'package:flutter/material.dart';
// import 'package:gwaliorkart/models/order_data.dart';
// import 'package:gwaliorkart/utils/constants.dart';
// import 'package:gwaliorkart/widgets/widget_page.dart';
//
// class OrderHistory extends StatefulWidget {
//   final OrderData orderRes;
//
//   OrderHistory(this.orderRes);
//
//   @override
//   _OrderHistoryState createState() => _OrderHistoryState();
// }
//
// class _OrderHistoryState extends State<OrderHistory> {
//   MainAxisAlignment _mStart = MainAxisAlignment.start;
//   MainAxisAlignment _mCenter = MainAxisAlignment.center;
//   CrossAxisAlignment _cStart = CrossAxisAlignment.start;
//   CrossAxisAlignment _cCenter = CrossAxisAlignment.center;
//   OrderData _orderData;
//   final BoxDecoration _decoration = BoxDecoration(
//     color: Constants.myWhite,
//     border: Border.all(width: 0.1, color: Colors.grey),
//   );
//
//   @override
//   void initState() {
//     widget.orderRes != null
//         ? _orderData = widget.orderRes
//         : _orderData = _orderData;
//     super.initState();
//   }
//
//   Widget _orderHistoryBuilder(context, OrderData _order, _) {
//     return InkWell(
//         onTap: () => null,
//         child: Container(
//           padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
//           decoration: _decoration,
//           child: Column(
//             crossAxisAlignment: _cStart,
//             mainAxisAlignment: _mStart,
//             children: [
//               Text("Hello"),
//             ],
//           ),
//         ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: WidgetPage.orderHistoryAppBar(),
//       body: _orderData != null &&
//               _orderData.orders != null &&
//               _orderData.orders.length > 0
//           ? _orderHistoryBuilder(context, _orderData, '_')
//           : WidgetPage.noItemFound('You have not made any previous orders!'),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:gwaliorkart/models/address_data.dart';
import 'package:gwaliorkart/models/order_data.dart';
import 'package:gwaliorkart/utils/auth_utils.dart';
import 'package:gwaliorkart/utils/constants.dart';
import 'package:gwaliorkart/widgets/error_screen.dart';
import 'package:gwaliorkart/widgets/widget_page.dart';

class OrderHistory extends StatefulWidget {
  // final OrderData orderRes;
  // OrderHistory(this.orderRes);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  MainAxisAlignment _mStart = MainAxisAlignment.start;
  MainAxisAlignment _mCenter = MainAxisAlignment.center;
  CrossAxisAlignment _cStart = CrossAxisAlignment.start;
  CrossAxisAlignment _cCenter = CrossAxisAlignment.center;
  OrderData _orderData;
  Key _key;
  String _customerId;
  final BoxDecoration _decoration = BoxDecoration(
    color: Constants.myWhite,
    border: Border.all(width: 0.1, color: Colors.grey),
  );

  @override
  void initState() {
    AuthUtils.userId != null && AuthUtils.userId != ''
        ? _customerId = AuthUtils.userId
        : _customerId = _customerId;
    // widget.orderRes != null
    //     ? _orderData = widget.orderRes
    //     : _orderData = _orderData;
    super.initState();
  }

  Widget _itemBuilder(BuildContext context, dynamic _order, int _) {
    return InkWell(
      onTap: () async =>
          await Constants.goToOrderDetailPage('1', _order.orderId, context),
      child: Card(
        elevation: 2.0,
        child: Container(
          padding: EdgeInsets.all(8.0),
          // decoration: _decoration,
          child: Column(
            crossAxisAlignment: _cStart,
            mainAxisAlignment: _mStart,
            children: [
              Text("Order ID: ${_order.orderId}"),
              Constants.height(5.0),
              Text("Customer: ${_order.name}"),
              Constants.height(5.0),
              Text("No. of Products: ${_order.products.toString()}"),
              Constants.height(5.0),
              Text("Status: ${_order.status}"),
              Constants.height(5.0),
              Text("Total: ${_order.total}"),
              Constants.height(5.0),
              Text("Date Added: ${_order.dateAdded}"),
            ],
          ),
          /*child: Column(
              crossAxisAlignment: _cStart,
              mainAxisAlignment: _mStart,
              children: [
                WidgetPage.richText('Order ID: ', _order.orderId),
                Constants.height(5.0),
                WidgetPage.richText('Customer: ', _order.name),
                Constants.height(5.0),
                WidgetPage.richText('No. of Products: ', _order.products.toString()),
                Constants.height(5.0),
                WidgetPage.richText('Status: ', _order.status),
                Constants.height(5.0),
                WidgetPage.richText('Total: ', _order.total),
                Constants.height(5.0),
                WidgetPage.richText('Date Added: ', _order.dateAdded),
              ],
            ),*/
        ),
      ),
    );
  }

  PagewiseListView _pageWiseListView() {
    return PagewiseListView(
      key: _key,
      pageSize: 10,
      itemBuilder: this._itemBuilder,
      pageFuture: (pageIndex) => OrderUtils.getOrder('1', pageIndex + 1),
      errorBuilder: (context, error) {
        return Text(error.toString());
      },
      showRetry: false,
      noItemsFoundBuilder: (BuildContext context) {
        return WidgetPage.noItemFound('You have not made any previous orders!');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetPage.orderHistoryAppBar(),
      body: _pageWiseListView(),
    );
  }
}
