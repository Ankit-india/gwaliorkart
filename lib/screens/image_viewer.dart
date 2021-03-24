import 'package:flutter/material.dart';
import 'package:gwaliorkart/models/product_detail_model.dart';
import 'package:gwaliorkart/utils/constants.dart';

class ImageViewer extends StatefulWidget {
  final ProductDetailData productRef;

  ImageViewer(this.productRef);

  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  ProductDetailData _product;

  @override
  void initState() {
    super.initState();
    _product = widget.productRef;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 300.0,
                    width: 300.0,
                    child: FadeInImage(
                      image: NetworkImage(_product.thumb != null && _product.thumb != ''
                          ? _product.thumb
                          : ''),
                      placeholder: AssetImage('assets/placeholders/no-product-image.png'),
                    ),
                    /*decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      image: DecorationImage(
                        image: widget.images.getImage(),
                        fit: BoxFit.cover,
                      ),
                    ),*/
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: _imageListBuilder(),
            ),
            Positioned(top: 30, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }

  Widget _imageListBuilder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () {},
          child: Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1),
              border: Border.all(width: 1, color: Constants.grey400),
              image: DecorationImage(
                image: _product.getImage(),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Constants.width(10.0),
        InkWell(
          onTap: () {},
          child: Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1),
              border: Border.all(width: 1, color: Constants.grey400),
              image: DecorationImage(
                image: _product.getImage(),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Constants.width(10.0),
        InkWell(
          onTap: () {},
          child: Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1),
              border: Border.all(width: 1, color: Constants.grey400),
              image: DecorationImage(
                image: _product.getImage(),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Icon(
          Icons.close,
          color: Constants.grey500,
          size: 35,
        ),
      ),
    );
  }
}
