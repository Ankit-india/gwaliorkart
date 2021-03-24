import 'package:flutter/material.dart';
import 'package:gwaliorkart/models/product_detail_model.dart';
import 'package:gwaliorkart/utils/constants.dart';

class ProductRatingsAndReviews extends StatefulWidget {
  final ProductDetailData item;

  ProductRatingsAndReviews(this.item);

  @override
  _ProductRatingsAndReviewsState createState() =>
      _ProductRatingsAndReviewsState();
}

class _ProductRatingsAndReviewsState extends State<ProductRatingsAndReviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1),
                    border: Border.all(width: 1, color: Constants.grey300),
                    image: DecorationImage(
                      image: widget.item.getImage(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Constants.width(10.0),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _productName(),
                    Constants.height(5.0),
                    _price(),
                  ],
                ))
              ],
            ),
          ),
          Constants.height(10.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _starRating(),
                _ratingAndReviews(),
                Divider(
                  height: 20.0,
                ),
              ],
            ),
          ),
          Text("ProductRatingsAndReviews"),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        "Product Ratings & Reviews",
        style: TextStyle(color: Constants.myWhite, fontSize: 16.0),
      ),
    );
  }

  Widget _productName() {
    Widget _name;
    if (widget.item.headingTitle != null && widget.item.headingTitle != "") {
      _name = Text(
        widget.item.headingTitle,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 18.0),
      );
    } else {
      _name = Container();
    }
    return _name;
  }

  Widget _price() {
    Widget _priceWidget;
    if (widget.item.price != null && widget.item.price != "") {
      _priceWidget = Text(
        "MRP: " + widget.item.price,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      );
    } else {
      _priceWidget = Container();
    }
    return _priceWidget;
  }

  Widget _starRating() {
    Widget _ratings;
    if (widget.item.rating != null) {
      _ratings = Text(
        "4.2 *",
        style: TextStyle(
            color: Constants.myGreen,
            fontWeight: FontWeight.bold,
            fontSize: 25.0),
      );
    } else {
      _ratings = Container();
    }
    return _ratings;
  }

  Widget _ratingAndReviews() {
    Widget _rating;
    if (widget.item.rating != null && widget.item.rating >= 0) {
      _rating = Column(
        children: <Widget>[
          Constants.height(5),
          Text(
            widget.item.rating.toString() +
                " Ratings & " +
                widget.item.reviews.toString(),
            style: TextStyle(fontSize: 12.0),
          ),
        ],
      );
    } else {
      _rating = Container();
    }
    return _rating;
  }
}
