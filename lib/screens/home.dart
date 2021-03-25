import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:gwaliorkart/models/cart_data.dart';
import 'package:gwaliorkart/screens/auth_login.dart';
import 'package:gwaliorkart/screens/basket.dart';
import 'package:gwaliorkart/screens/categories.dart';
import 'package:gwaliorkart/screens/change_location.dart';
import 'package:gwaliorkart/screens/drawer_page.dart';
import 'package:gwaliorkart/screens/landing.dart';
import 'package:gwaliorkart/screens/my_account.dart';
import 'package:gwaliorkart/screens/offers.dart';
import 'package:gwaliorkart/screens/search.dart';
import 'package:gwaliorkart/screens/search_screen.dart';
import 'package:gwaliorkart/utils/auth_utils.dart';
import 'package:gwaliorkart/utils/constants.dart';
import 'package:gwaliorkart/utils/storage_utils.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Landing _landingPage;
  Categories _categoriesPage;
  Search _searchPage;
  Offers _offersPage;
  Basket _basketPage;

  List<Widget> pages;
  int _selectedIndex = 0, _quantity, _itemInCart, _productCartId;
  Size _deviceSize;
  Widget _currentPage;

  ScrollController _scrollBottomBarController;
  bool _showAppbar = true, isScrollingDown = false, _show = true;
  DateTime currentBackPressTime;
  String qrCode = "";
  // final Geolocator _geoLocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress = '', _customerId, _vouchers, _coupon, _reward;

  @override
  void initState() {
    _customerId = AuthUtils.userId;
    _getCurrentLocation();
//    _getCartListData();
    _scrollBottomBarController = ScrollController();
    _landingPage = Landing(_scrollBottomBarController);
    _categoriesPage = Categories(_scrollBottomBarController);
    _searchPage = Search(_scrollBottomBarController);
    _offersPage = Offers(_scrollBottomBarController);
    _basketPage = Basket(_scrollBottomBarController);
    pages = [_landingPage, _categoriesPage, _searchPage, _basketPage];
    _currentPage = _landingPage;
    myScroll();
    super.initState();
  }

  Future<dynamic> _getCartListData() async {
    await CartUtils.getCartList(
            _customerId != null && _customerId != "" ? _customerId : "-",
            _vouchers != null && _vouchers != "" ? _vouchers : "-",
            _coupon != null && _coupon != "" ? _coupon : "-",
            _reward != null && _reward != "" ? _reward : "-")
        .then((dynamic _response) async {
      if (_response != null) {
        if (_response.containsKey('text_count')) {
          setState(() {
            _itemInCart = _response['text_count'];
          });
        }
      }
    }).catchError((_onError) {
      print("\ngetCartData catchError:=> $_onError\n");
    });
  }

  @override
  void dispose() {
    _scrollBottomBarController.removeListener(() {});
    super.dispose();
  }

  void showBottomBar() {
    setState(() {
      _show = true;
    });
  }

  void hideBottomBar() {
    setState(() {
      _show = false;
    });
  }

  Future<void> myScroll() async {
    _scrollBottomBarController.addListener(() {
      if (_scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          hideBottomBar();
        }
      }
      if (_scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          showBottomBar();
        }
      }
    });
  }

  Future<void> _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position _position) {
      setState(() {
        _currentPosition = _position;
      });

      _getAddressFromLatLng();
    }).catchError((_e) {
      print("\ngetCurrentPosition catchError:= $_e\n");
    });
  }

  Future<void> _getAddressFromLatLng() async {
    try {
      await placemarkFromCoordinates(
              _currentPosition.latitude, _currentPosition.longitude)
          .then((List<Placemark> p) async {
        Placemark _place = p[0];
        setState(() {
          _currentAddress =
              "${_place.locality} ${_place.administrativeArea} ${_place.postalCode}, ${_place.country}";
        });
        await StorageProvider.setCurrentLocationInfo(
                _place.locality != null ? _place.locality : '',
                _place.subAdministrativeArea != null
                    ? _place.subAdministrativeArea
                    : '',
                _place.administrativeArea != null
                    ? _place.administrativeArea
                    : '',
                _place.country != null ? _place.country : '',
                _place.postalCode != null ? _place.postalCode : '')
            .then((dynamic _value) async {
          await AuthUtils.getUserInfo();
        }).catchError((_onError) {
          print("\n\nsetCurrentLocationInfo catchError:=> $_onError\n\n");
        });
      }).catchError((onError) {
        print("placemarkFromCoordinates catchError:=> $onError");
      });
    } catch (_exp) {
      print("\nplaceMarkFromCoOrdinates catch:= $_exp\n");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: _showAppbar
          ? _appBarBuilder(_currentPage)
          : PreferredSize(
              child: Container(),
              preferredSize: Size(0.0, 0.0),
            ),
      bottomNavigationBar: _show
          ? bottomNavigationBarBuilder()
          : Container(
              color: Colors.transparent,
              width: 0.0,
              height: 0.0,
            ),
      drawer: DrawerPage(),
      body: WillPopScope(child: _currentPage, onWillPop: onWillPop),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Tap back again to leave');
      return Future.value(false);
    }
    return Future.value(true);
  }

  TextStyle _locationStyle = TextStyle(
      fontFamily: 'Gotham', fontSize: 12.0, fontWeight: FontWeight.w400);
  TextOverflow _ellipsis = TextOverflow.ellipsis;

  AppBar _appBarBuilder(Widget currentPage) {
    _deviceSize = MediaQuery.of(context).size;
    AppBar _appBarTab;
    if (currentPage.toString() == 'Landing') {
      _appBarTab = AppBar(
        title: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Constants.height(4.0),
              Text(
                'Your Location',
                style: Constants.gotham13bold,
              ),
              Constants.height(4.0),
              InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return ChangeLocation();
                })),
                splashColor: Constants.primary_green,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: _currentPosition != null && _currentAddress != null
                          ? Text(
                              _currentAddress != '' ? _currentAddress : '',
                              overflow: _ellipsis,
                              style: _locationStyle,
                            )
                          : Container(),
                    ),
                    /*Expanded(
                      child: _currentPosition != null
                          ? Container(
                        child: Text(
                          _currentAddress != null
                              ? _currentAddress
                              : Constants.smallLoader().toString(),
                          overflow: _ellipsis,
                          style: _locationStyle,
                        ),
                      )
                          : Constants.smallLoader(),
                    ),*/
                    Constants.height(2.0),
                    Icon(
                      Icons.edit,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          _userIconButton(),
        ],
        bottom: _preferredSizeWithSearchBar(currentPage),
      );
    } else if (currentPage.toString() == 'Categories') {
      _appBarTab = AppBar(
        title: Text(
          "Shop By Category",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        bottom: _preferredSizeWithSearchBar(currentPage),
      );
    } else if (currentPage.toString() == 'Search') {
      _appBarTab = AppBar(
        title: Text(
          "Search Product",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Image.asset(
              "assets/icons/scanner.png",
              color: Constants.myWhite,
              width: 25,
            ),
            onPressed: () => null,
          ),
          IconButton(
              icon: Icon(
                Icons.keyboard_voice,
                size: 30,
              ),
              onPressed: () {
                Constants.showShortToastBuilder('Speak');
              }),
        ],
        bottom: _preferredSizeWithSearchBar(currentPage),
      );
    } else if (currentPage.toString() == 'Offers') {
      _appBarTab = AppBar(
        title: Text(
          'Offers',
          style: TextStyle(fontFamily: 'Gotham'),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              size: 25.0,
            ),
            onPressed: () async => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => SearchScreen())),
          ),
        ],
      );
    } else if (currentPage.toString() == 'Basket') {
      _appBarTab = AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              size: 25,
            ),
            onPressed: () async => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => SearchScreen())),
          ),
          IconButton(
              icon: Icon(
                Icons.more_vert,
                size: 25,
              ),
              onPressed: () {}),
        ],
        title: Text(
          'Shopping Cart',
          style: TextStyle(fontFamily: 'Gotham', fontSize: 16.0),
        ),
        centerTitle: true,
      );
    }
    return _appBarTab;
  }

  IconButton _userIconButton() {
    return IconButton(
        splashColor: Constants.primary_green,
        icon: Icon(
          Icons.account_circle,
        ),
        onPressed: () async {
          if (AuthUtils.authToken != null && AuthUtils.authToken != '') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return MyAccount();
              }),
            );
          } else {
            MaterialPageRoute authRoute =
                MaterialPageRoute(builder: (context) => AuthLogin());
            Navigator.push(context, authRoute);
          }
        });
  }

  PreferredSize _preferredSizeWithSearchBar(final Widget currentPage) {
    return PreferredSize(
      preferredSize: Size(_deviceSize.height, 55),
      child: InkWell(
        onTap: () async => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => SearchScreen())),
        child: Container(
          height: 42,
          width: _deviceSize.width,
          margin: EdgeInsets.all(010),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Constants.myWhite,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: <Widget>[
              Constants.width(10.0),
              Icon(Icons.search, color: Constants.grey600),
              Constants.width(10.0),
              Text(
                'Search 18000+ products',
                style: TextStyle(fontSize: 14.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBar bottomNavigationBarBuilder() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(
            'Home',
            style: Constants.gotham13normal,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          title: Text(
            'Categories',
            style: Constants.gotham13normal,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text(
            'Search',
            style: Constants.gotham13normal,
          ),
        ),
        BottomNavigationBarItem(
//          icon: Stack(
//            children: <Widget>[
//              IconButton(
//                icon: Icon(
//                  Icons.shopping_cart,
//                ),
//                onPressed: null,
//              ),
//              Positioned(top: 10,right: 15,
//                child: Text(
//                  _itemInCart != null ? _itemInCart.toString() : '0',
//                  style: TextStyle(
//                      color: Colors.white,
//                      fontSize: 12.0,
//                      fontWeight: FontWeight.w500),
//                ),
//              )
//            ],
//          ),
          icon: Icon(Icons.shopping_basket),
          title: Text(
            'Basket',
            style: Constants.gotham13normal,
          ),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedFontSize: 15.0,
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
          _currentPage = pages[index];
        });
      },
      type: BottomNavigationBarType.fixed,
    );
  }

/*final List<Widget> _children = [
    Landing(_scrollBottomBarController),
    Categories(_scrollBottomBarController),
    Search(_scrollBottomBarController),
    Offers(_scrollBottomBarController),
    Basket(_scrollBottomBarController)
  ];*/
}
