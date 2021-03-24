import 'package:flutter/material.dart';
import 'package:gwaliorkart/models/address_data.dart';
import 'package:gwaliorkart/screens/auth_login.dart';
import 'package:gwaliorkart/utils/auth_utils.dart';
import 'package:gwaliorkart/utils/constants.dart';
import 'package:gwaliorkart/widgets/widget_page.dart';

class AddressBook extends StatefulWidget {
  final List<dynamic> addresses;

  AddressBook(this.addresses);

  @override
  _AddressBookState createState() => _AddressBookState();
}

class _AddressBookState extends State<AddressBook> {
  MainAxisAlignment _mStart = MainAxisAlignment.start;
  CrossAxisAlignment _cStart = CrossAxisAlignment.start;
  List<dynamic> _addresses;
  String _token, _customerId, _addressId = '0';

  @override
  void initState() {
    AuthUtils.authToken != null
        ? _token = AuthUtils.authToken
        : _token = _token;
    AuthUtils.userId != null
        ? _customerId = AuthUtils.userId
        : _customerId = _customerId;
    widget.addresses != null
        ? _addresses = widget.addresses
        : _addresses = _addresses;
    super.initState();
  }

  _onPressed() async {
    if (_token != null && _token != '') {
      await Constants.getCustomerAddAddressFormData(
          _customerId, _addressId, context);
    } else {
      MaterialPageRoute authRoute =
          MaterialPageRoute(builder: (context) => AuthLogin());
      Navigator.push(context, authRoute);
    }
  }

  BoxDecoration _boxDecoration = BoxDecoration(
    color: Constants.myWhite,
    border: Border.all(width: 0.1, color: Colors.grey),
  );

  Widget _addressListViewBuilder(final List<dynamic> _addresses) {
    final List<dynamic> _addressList = _addresses.map((_listItem) {
      return AddressData.fromJson(_listItem);
    }).toList();
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _addressList == null ? 0 : _addressList.length,
      itemBuilder: (BuildContext context, int _listIndex) {
        AddressData _address = _addressList[_listIndex];
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          decoration: _boxDecoration,
          child: Column(
              crossAxisAlignment: _cStart,
              mainAxisAlignment: _mStart,
              children: <Widget>[
                Text(
                  "${_address.firstName != null ? _address.firstName.toUpperCase() : ''} ${_address.lastName != null ? _address.lastName.toUpperCase() : ''}",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text("${_address.company != null ? _address.company : ''}"),
                Text(
                    "${_address.address1 != null ? _address.address1 : ''}\n${_address.address2 != null ? _address.address2 : ''}"),
                Text(
                    "${_address.city != null ? _address.city : ''} - ${_address.postcode != null ? _address.postcode : ''}"),
                Text("${_address.zone != null ? _address.zone : ''}"),
                Text("${_address.country != null ? _address.country : ''}"),
                Divider(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => Constants.showShortToastBuilder('Edited'),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 6.5),
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          child: Text(
                            "Edit",
                            style: TextStyle(
                                color: Constants.myWhite,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => Constants.showShortToastBuilder('Deleted'),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 6.5),
                          decoration: BoxDecoration(
                            color: Constants.red300,
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          child: Text(
                            "DELETE",
                            style: TextStyle(
                                color: Constants.myWhite,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
        );
      },
    );
  }

  Widget _addressBodyBuilder(final List<dynamic> _addresses) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: _cStart,
        mainAxisAlignment: _mStart,
        children: [
          _addressListViewBuilder(_addresses),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetPage.addressBookAppBar(),
      body: _addresses != null && _addresses.length > 0
          ? _addressBodyBuilder(_addresses)
          : WidgetPage.noAddressFound('You have no addresses in your account.'),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        child: Icon(
          Icons.add,
          color: Constants.myWhite,
        ),
        onPressed: () async => _onPressed(),
      ),
    );
  }
}
