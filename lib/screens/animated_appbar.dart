import 'package:flutter/material.dart';

class AnimatedAppbar extends StatefulWidget {
  @override
  _AnimatedAppbarState createState() => _AnimatedAppbarState();
}

class _AnimatedAppbarState extends State<AnimatedAppbar>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Stack(
            children: <Widget>[
              Transform.translate(
                offset: Offset(0, -_controller.value * 64),
                child: Container(
                  height: 56.0,
                  child: AppBar(
                    title: Text('Title'),
                    leading: Icon(
                      Icons.arrow_back,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (_controller.isCompleted) {
                    _controller.reverse();
                  } else {
                    _controller.forward();
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 56.0),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'DATA WYDANIA:',
                                style: TextStyle(color: Colors.black),
                              ),
                              Text('10/09/2019',
                                  style: TextStyle(color: Colors.black))
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('UNIKALNY KOD:',
                                  style: TextStyle(color: Colors.black)),
                              Text('e-86-tC-9',
                                  style: TextStyle(color: Colors.black))
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(height: 8.0),
                          Image.network(
                            'http://via.placeholder.com/640x360',
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}