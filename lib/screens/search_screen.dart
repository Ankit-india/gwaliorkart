import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gwaliorkart/models/search_model.dart';
import 'package:gwaliorkart/screens/home.dart';
import 'package:gwaliorkart/screens/searched_list_data.dart';
import 'package:gwaliorkart/utils/constants.dart';
import 'package:gwaliorkart/widgets/error_screen.dart';
import 'package:gwaliorkart/widgets/loader.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _keyword;
  Size _deviceSize;
  int numOfAddedItem = 1;
  bool _isAdded = false;

  @override
  void initState() {
    super.initState();
    _keyword = TextEditingController();
  }

  Future<dynamic> _getSearchData() async {
    if (_keyword.text != '' && _keyword.text != null) {
      return await SearchPageUtils.getSearchingPageList(_keyword.text);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        appBar: _appBar(),
        body: _futureBuilder(),
      ),
    );
  }

  FutureBuilder _futureBuilder() {
    return FutureBuilder<dynamic>(
      future: _getSearchData(),
      key: ValueKey(_keyword.text),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Loader();
          case ConnectionState.done:
          default:
            if (snapshot.hasError) {
              print("Error:= ${snapshot.error}");
              return ErrorScreen(snapshot.error, 1);
            } else {
              return _searchedDataListViewBuilder(snapshot.data);
            }
        }
      },
    );
  }

  Widget _appBar() {
    _deviceSize = MediaQuery.of(context).size;
    return AppBar(
      elevation: 0.0,
      title: Text(
        "Search Product",
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      leading: Builder(builder: (BuildContext context) {
        return IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: _backToPromise,
        );
      }),
      actions: <Widget>[
        IconButton(
          icon: Image.asset(
            "assets/icons/scanner.png",
            color: Constants.myWhite,
            width: 25,
          ),
          onPressed: () {
//              _scan();
          },
        ),
        IconButton(
            icon: Icon(
              Icons.keyboard_voice,
              size: 30,
            ),
            onPressed: () {}),
      ],
      bottom: _searchBar(),
    );
  }

  PreferredSize _searchBar() {
    return PreferredSize(
      preferredSize: Size(_deviceSize.height, 55),
      child: Container(
        height: 45,
        width: _deviceSize.width,
        margin: EdgeInsets.all(010),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Constants.myWhite,
            borderRadius: BorderRadius.circular(5)),
        child: TextFormField(
          autofocus: true,
          controller: _keyword,
          keyboardType: TextInputType.text,
          cursorColor: Constants.primary_green,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide:
                  const BorderSide(color: Constants.primary_green, width: 1.5),
            ),
            hintText: 'Search 18000+ products',
            hintStyle: TextStyle(fontSize: 14.5),
            prefixIcon: Icon(Icons.search),
            suffix: Visibility(
              visible: _keyword.text != '',
              child: IconButton(
                icon: const Icon(
                  Icons.clear,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _keyword.clear();
                  });
                },
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide:
                  const BorderSide(color: Constants.primary_green, width: 1.5),
            ),
          ),
          onFieldSubmitted: (term) {
            if (_keyword.text == '') {
              Constants.showShortToastBuilder("Please type to search");
            }
          },
        ),
      ),
    );
  }

  /*Widget _searchedDataListViewBuilder(final Map<String, dynamic> _snapshot) {
    Widget _listWidget;
    if (_snapshot != null && _snapshot['products'].length > 0) {
      final List<dynamic> productList = _snapshot['products'].map((items) {
        return SearchData.fromJson(items);
      }).toList();

      _listWidget = ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: productList == null ? 0 : productList.length,
          itemBuilder: (BuildContext context, int index) {
            SearchData productData = productList[index];

            Widget _itemNameText() {
              Widget _itemName;
              if (index == 0) {
                _itemName = Column(
                  children: <Widget>[
                    Constants.height(5.0),
                    Text(
                      productData.name,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                );
              } else {
                _itemName = Text(
                  productData.name,
                  style: TextStyle(fontWeight: FontWeight.w500),
                );
              }
              return _itemName;
            }

            Widget _ratingWidget() {
              Widget _rating;
              if (productData.rating != null && productData.rating >= 0) {
                _rating = Column(
                  children: <Widget>[
                    Text(
                      "Rating: " + productData.rating.toString(),
                      style: TextStyle(color: Constants.myGreen),
                    ),
                    Constants.height(5),
                  ],
                );
              } else {
                _rating = Container();
              }
              return _rating;
            }

            Widget _itemRealPriceText() {
              Widget _price;
              if (productData.specialPrice() != '' &&
                  productData.specialPrice() != null) {
                _price = RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: 'MRP: ',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      children: [
                        TextSpan(
                          text: productData.price,
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ]),
                );
              } else {
                _price = Text(
                  productData.price,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                );
              }
              return _price;
            }

            Widget _itemDiscountPriceText() {
              Widget _price;
              if (productData.specialPrice() != '') {
                _price = Text(
                  productData.specialPrice(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                );
              } else {
                _price = Text("");
              }
              return _price;
            }

            Text _rsText = Text(
              "Rs " + productData.saved().toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w500),
            );

            Text _savedText = Text(
              "SAVED",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w500),
            );

            Column _savedPriceText = Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _rsText,
                Constants.height(2),
                _savedText,
              ],
            );

            EdgeInsets _stackPadding() {
              EdgeInsets _padding;
              if (productData.saved() > 0 && productData.saved() != null) {
                _padding = EdgeInsets.only(top: 10.0);
              } else {
                _padding = EdgeInsets.only(top: 0);
              }
              return _padding;
            }

            Widget _savedPriceView() {
              Widget _stack;
              if (productData.saved() > 0 && productData.saved() != null) {
                _stack = Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: new BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                    child: _savedPriceText,
                  ),
                );
              } else {
                _stack = Container();
              }
              return _stack;
            }

            Widget _addButton(final bool isAdded) {
              Widget buttonSection;
              if (isAdded == false) {
                buttonSection = InkWell(
                  onTap: () {
                    setState(() {
                      _isAdded = true;
                    });
                    Constants.showShortToastBuilder("Item added into the kart");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      "ADD",
                      style: TextStyle(
                          color: Constants.myWhite,
                          fontWeight: FontWeight.w500),
                    ),
                    padding:
                    EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
                  ),
                );
              } else {
                buttonSection = Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isAdded = false;
                        });
                        Constants.showShortToastBuilder('Item removed');
                      },
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(width: 1, color: Colors.red),
                        ),
                        child: Icon(
                          Icons.remove,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Constants.width(10.0),
                    Text(
                      numOfAddedItem.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                    Constants.width(10.0),
                    InkWell(
                      onTap: () {
                        Constants.showShortToastBuilder('Item added');
                      },
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(width: 1, color: Colors.red),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return buttonSection;
            }

            Widget _divider() {
              if (index != productList.length - 1) {
                return Divider();
              } else {
                return Container();
              }
            }

            Widget _listBodyWidget() {
              Widget _widget;
              Widget _listBuilder = Container(
                color: Constants.myWhite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return ProductDetails(
                                    int.parse(productData.productId));
                              }));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                  padding: _stackPadding(),
                                  height: 120.0,
                                  width: 100.0,
                                  child: productData.getImage(),
                                ),
                                _savedPriceView(),
                              ],
                            ),
                            Constants.width(10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  _itemNameText(),
                                  Constants.height(5),
                                  Constants.height(15),
                                  _ratingWidget(),
                                  Constants.height(5),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          _itemRealPriceText(),
                                          Constants.height(2),
                                          _itemDiscountPriceText(),
                                        ],
                                      ),
                                      _addButton(_isAdded),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    _divider(),
                  ],
                ),
              );
              if (_snapshot['products'].length > 6) {
                _widget = Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("That's All folks!"),
                        ],
                      ),
                    ),
                    _listBuilder,
                  ],
                );
              } else {
                _widget = _listBuilder;
              }
              return _widget;
            }

            return _listBodyWidget();
          });
    } else {
      _listWidget = Container(
        color: Constants.myWhite,alignment: Alignment.center,
        child: Text(
          "No item found.",
          style: TextStyle(
              fontSize: 18.0,
              color: Constants.grey500,
              fontWeight: FontWeight.w500),
        ),
      );
    }
    return _listWidget;
  }*/

  _searchedDataListViewBuilder(final Map<String, dynamic> _snapshot) {
    if (_snapshot == null) {
      return Container();
    } else if (_snapshot['products'].length > 0) {
      Timer(Duration(seconds: 0), () {
        _goToSearchListData(_snapshot);
      });
      return Container();
    } else {
      return Container(
        color: Constants.myWhite,
        alignment: Alignment.center,
        child: Text(
          "No item found.",
          style: TextStyle(
              fontSize: 18.0,
              color: Constants.grey500,
              fontWeight: FontWeight.w500),
        ),
      );
    }
  }

  Future _goToSearchListData(final Map<String, dynamic> snapshotData) async {
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                SearchedListData(_keyword.text, snapshotData)));
  }

  Future<bool> _willPopCallback() async {
    return _backToPromise();
  }

  _backToPromise() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => Home()));
  }
}

/*Widget _searchedDataListViewBuilder(final Map<String, dynamic> _snapshot) {
    Widget _widget;
    Widget _searchList = Container(
      alignment: Alignment.center,
      child: Text("data Hai"),
    );
    Widget _noItem = Container(
      alignment: Alignment.center,
      child: Text(
        "No item found.",
        style: TextStyle(
            fontSize: 18.0,
            color: Constants.grey500,
            fontWeight: FontWeight.w500),
      ),
    );

    _snapshot != null
        ? _snapshot['products'].length != 0
            ? _widget = _searchList
            : _widget = _noItem
        : _widget = _noItem;
    return _widget;
  }*/

/*
// Transition Navigate Page Route
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => new _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('First Page'),
      ),
      body: new Center(
        child: new RaisedButton(
          child: new Text('Goto Second Page'),
          onPressed: () {
            Navigator.of(context).push(new SecondPageRoute());
          },
        ),
      ),
    );
  }
}

class SecondPageRoute extends CupertinoPageRoute {
  SecondPageRoute()
      : super(builder: (BuildContext context) => new SecondPage());


  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: new SecondPage());
  }
}

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => new _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Second Page'),
      ),
      body: new Center(
        child: new Text('This is the second page'),
      ),
    );
  }
}*/

/*import 'dart:async';

import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {

  StreamController<int> _controller = StreamController<int>();

  int _seconds = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          MyTextWidget(stream: _controller.stream), //just update this widget
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.add_circle),
                onPressed: ()=> _controller.add(_seconds--),
                iconSize: 150.0,
              ),
              IconButton(
                icon: Icon(Icons.remove_circle),
                onPressed: ()=> _controller.add(_seconds++),
                iconSize: 150.0,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class MyTextWidget extends StatefulWidget{

  final Stream<int> stream;

  MyTextWidget({this.stream});

  @override
  _MyTextWidgetState createState() => _MyTextWidgetState();
}

class _MyTextWidgetState extends State<MyTextWidget> {

  int secondsToDisplay = 0;

  void _updateSeconds(int newSeconds) {
    setState(() {
      secondsToDisplay = newSeconds;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.stream.listen((seconds) {
      _updateSeconds(seconds);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      secondsToDisplay.toString(),
      textScaleFactor: 5.0,
    );
  }
}*/
