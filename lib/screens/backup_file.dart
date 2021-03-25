/*
import 'package:flutter/material.dart';

class HideShowWidget extends StatefulWidget {
  @override
  HideShowWidgetState createState() => HideShowWidgetState();
}

class HideShowWidgetState extends State<HideShowWidget> {
  bool visibilityTag = false;
  bool visibilityObs = false;

  void _changed(bool visibility, String field) {
    setState(() {
      if (field == "tag"){
        visibilityTag = visibility;
      }
      if (field == "obs"){
        visibilityObs = visibility;
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
        appBar: new AppBar(backgroundColor: new Color(0xFF26C6DA)),
        body: new ListView(
          children: <Widget>[
            new Container(
              margin: new EdgeInsets.all(20.0),
              child: new FlutterLogo(size: 100.0, colors: Colors.blue),
            ),
            new Container(
                margin: new EdgeInsets.only(left: 16.0, right: 16.0),
                child: new Column(
                  children: <Widget>[
                    visibilityObs ? new Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        new Expanded(
                          flex: 11,
                          child: new TextField(
                            maxLines: 1,
                            style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
                                labelText: "Observation",
                                isDense: true
                            ),
                          ),
                        ),
                        new Expanded(
                          flex: 1,
                          child: new IconButton(
                            color: Colors.grey[400],
                            icon: const Icon(Icons.cancel, size: 22.0,),
                            onPressed: () {
                              _changed(false, "obs");
                            },
                          ),
                        ),
                      ],
                    ) : new Container(),

                    visibilityTag ? new Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        new Expanded(
                          flex: 11,
                          child: new TextField(
                            maxLines: 1,
                            style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
                                labelText: "Tags",
                                isDense: true
                            ),
                          ),
                        ),
                        new Expanded(
                          flex: 1,
                          child: new IconButton(
                            color: Colors.grey[400],
                            icon: const Icon(Icons.cancel, size: 22.0,),
                            onPressed: () {
                              _changed(false, "tag");
                            },
                          ),
                        ),
                      ],
                    ) : new Container(),
                  ],
                )
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new InkWell(
                    onTap: () {
                      visibilityObs ? null : _changed(true, "obs");
                    },
                    child: new Container(
                      margin: new EdgeInsets.only(top: 16.0),
                      child: new Column(
                        children: <Widget>[
                          new Icon(Icons.comment, color: visibilityObs ? Colors.grey[400] : Colors.grey[600]),
                          new Container(
                            margin: const EdgeInsets.only(top: 8.0),
                            child: new Text(
                              "Observation",
                              style: new TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                color: visibilityObs ? Colors.grey[400] : Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ),
                new SizedBox(width: 24.0),
                new InkWell(
                    onTap: () {
                      visibilityTag ? null : _changed(true, "tag");
                    },
                    child: new Container(
                      margin: new EdgeInsets.only(top: 16.0),
                      child: new Column(
                        children: <Widget>[
                          new Icon(Icons.local_offer, color: visibilityTag ? Colors.grey[400] : Colors.grey[600]),
                          new Container(
                            margin: const EdgeInsets.only(top: 8.0),
                            child: new Text(
                              "Tags",
                              style: new TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                color: visibilityTag ? Colors.grey[400] : Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ),
              ],
            )
          ],
        )
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gwaliorkart/utils/constants.dart';
import 'package:intl/intl.dart';

class CheckBoxList extends StatefulWidget {
  @override
  _CheckBoxListState createState() => _CheckBoxListState();
}

class _CheckBoxListState extends State<CheckBoxList> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  var options = [];
  List<dynamic> _optionVal = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text("Testing File"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            children: <Widget>[
              FormBuilder(
                key: _fbKey,
                initialValue: {
                  'date': DateTime.now(),
                  'accept_terms': false,
                },
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: <Widget>[
                    FormBuilderDateTimePicker(
                      name: "date",
                      inputType: InputType.date,
                      format: DateFormat("yyyy-MM-dd"),
                      decoration:
                          InputDecoration(labelText: "Appointment Time"),
                    ),
                    FormBuilderSlider(
                      name: "slider",
                      validator: FormBuilderValidators.min(context, 6),
                      min: 0.0,
                      max: 10.0,
                      initialValue: 1.0,
                      divisions: 20,
                      decoration:
                          InputDecoration(labelText: "Number of things"),
                    ),
                    FormBuilderCheckbox(
                      name: 'accept_terms',
                      decoration: InputDecoration(
                        labelText:
                            "I have read and agree to the terms and conditions",
                      ),
                      validator: FormBuilderValidators.required(context),
                      title: Text('Title'),
                    ),
                    FormBuilderDropdown(
                      name: "gender",
                      decoration: InputDecoration(labelText: "Gender"),
                      // initialValue: 'Male',
                      hint: Text('Select Gender'),
                      validator: FormBuilderValidators.required(context),
                      items: ['Male', 'Female', 'Other']
                          .map((gender) => DropdownMenuItem(
                              value: gender, child: Text("$gender")))
                          .toList(),
                    ),
                    FormBuilderTextField(
                      name: "age",
                      decoration: InputDecoration(labelText: "Age"),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.numeric(context),
                        FormBuilderValidators.max(context, 70),
                      ]),
                    ),
                    FormBuilderSegmentedControl(
                      decoration:
                          InputDecoration(labelText: "Movie Rating (Archer)"),
                      name: "movie_rating",
                      options: List.generate(5, (i) => i + 1)
                          .map(
                              (number) => FormBuilderFieldOption(value: number))
                          .toList(),
                    ),
                    FormBuilderSwitch(
                      decoration: InputDecoration(
                          labelText: 'I Accept the terms and conditions'),
                      name: "accept_terms_switch",
                      initialValue: true,
                      title: Text('Title'),
                    ),
                    FormBuilderTouchSpin(
                      decoration: InputDecoration(labelText: "Stepper"),
                      name: "stepper",
                      initialValue: 10,
                      step: 1,
                    ),
                    FormBuilderRating(
                      decoration: InputDecoration(labelText: "Rate this form"),
                      name: "rate",
                      iconSize: 32.0,
                      initialValue: 1,
                      max: 5,
                    ),
                    FormBuilderCheckboxGroup(
                      decoration: InputDecoration(
                          labelText: "The language of my people"),
                      name: "languages",
                      initialValue: options,
                      options: [
                        FormBuilderFieldOption(value: "Dart"),
                        FormBuilderFieldOption(value: "Kotlin"),
                        FormBuilderFieldOption(value: "Java"),
                        FormBuilderFieldOption(value: "Swift"),
                        FormBuilderFieldOption(value: "Objective-C"),
                      ],
                      onChanged: (dynamic _newVal) {
                        setState(() {
                          options = _newVal;
                          print("_newCheckVal:= $options");
                        });
                      },
                    ),
                    FormBuilderCheckboxGroup(
                      decoration: InputDecoration(
                          labelText: "The language of my coding"),
                      name: "tempered",
                      initialValue: _optionVal,
                      activeColor: Constants.myGreen,
                      options: [
                        FormBuilderFieldOption(value: "Dart"),
                        FormBuilderFieldOption(value: "Kotlin"),
                        FormBuilderFieldOption(value: "Java"),
                        FormBuilderFieldOption(value: "Swift"),
                        FormBuilderFieldOption(value: "Objective-C"),
                      ],
                      onChanged: (dynamic _newVal) {
                        setState(() {
                          _optionVal = _newVal;
                          print("changedLanguage:= $_optionVal");
                        });
                      },
                    ),
                    FormBuilderChoiceChip(
                      name: "favorite_ice_cream",
                      options: [
                        FormBuilderFieldOption(
                            child: Text("Vanilla"), value: "vanilla"),
                        FormBuilderFieldOption(
                            child: Text("Chocolate"), value: "chocolate"),
                        FormBuilderFieldOption(
                            child: Text("Strawberry"), value: "strawberry"),
                        FormBuilderFieldOption(
                            child: Text("Peach"), value: "peach"),
                      ],
                    ),
                    FormBuilderFilterChip(
                      name: "pets",
                      options: [
                        FormBuilderFieldOption(
                            child: Text("Cats"), value: "cats"),
                        FormBuilderFieldOption(
                            child: Text("Dogs"), value: "dogs"),
                        FormBuilderFieldOption(
                            child: Text("Rodents"), value: "rodents"),
                        FormBuilderFieldOption(
                            child: Text("Birds"), value: "birds"),
                      ],
                    ),
                    FormBuilderSignaturePad(
                      decoration: InputDecoration(labelText: "Signature"),
                      name: "signature",
                      height: 100,
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  MaterialButton(
                    child: Text("Submit"),
                    onPressed: () {
                      if (_fbKey.currentState.saveAndValidate()) {
                        print(_fbKey.currentState.value);
                      }
                    },
                  ),
                  MaterialButton(
                    child: Text("Reset"),
                    onPressed: () {
                      _fbKey.currentState.reset();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

//  Navigator RouteSettings
/*onTap: () {
                  MaterialPageRoute _accountRoute =
                  MaterialPageRoute(builder: (context) => EditAccount(EditAccountData(firstName,lastName,emailId,phoneNo)));
                  Navigator.push(context, _accountRoute).then((value) {
                    Navigator.of(context).pop();
                  });
                },*/

//###################################################################
/*
Had the same issue, the following worked for me (below code is in FirstPage()):

Navigator.push( context, MaterialPageRoute( builder: (context) => SecondPage()), ).then((value) => setState(() {}));

After you pop back from SecondPage() to FirstPage() the "then" statement will run and refresh the page.
*/


//ExpansionTile close auto

// import 'package:flutter/material.dart';
// import 'package:meta/meta.dart';
//
//
// class AddNewAddress extends StatefulWidget {
//   @override
//   AddNewAddressState createState() => AddNewAddressState();
// }
//
// class AddNewAddressState extends State<AddNewAddress> {
//
//   final GlobalKey<AppExpansionTileState> expansionTile = new GlobalKey();
//   String foos = 'One';
//
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       home: new Scaffold(
//         appBar: new AppBar(
//           title: const Text('ExpansionTile'),
//         ),
//         body: new AppExpansionTile(
//             key: expansionTile,
//             title: new Text(this.foos),
//             backgroundColor: Theme
//                 .of(context)
//                 .accentColor
//                 .withOpacity(0.025),
//             children: <Widget>[
//               new ListTile(
//                 title: const Text('One'),
//                 onTap: () {
//                   setState(() {
//                     this.foos = 'One';
//                     expansionTile.currentState.collapse();
//                   });
//                 },
//               ),
//               new ListTile(
//                 title: const Text('Two'),
//                 onTap: () {
//                   setState(() {
//                     this.foos = 'Two';
//                     expansionTile.currentState.collapse();
//                   });
//                 },
//               ),
//               new ListTile(
//                 title: const Text('Three'),
//                 onTap: () {
//                   setState(() {
//                     this.foos = 'Three';
//                     expansionTile.currentState.collapse();
//                   });
//                 },
//               ),
//             ]
//         ),
//       ),
//     );
//   }
// }
//
// // --- Copied and slightly modified version of the ExpansionTile.
//
// const Duration _kExpand = const Duration(milliseconds: 200);
//
// class AppExpansionTile extends StatefulWidget {
//   const AppExpansionTile({
//     Key key,
//     this.leading,
//     @required this.title,
//     this.backgroundColor,
//     this.onExpansionChanged,
//     this.children: const <Widget>[],
//     this.trailing,
//     this.initiallyExpanded: false,
//   })
//       : assert(initiallyExpanded != null),
//         super(key: key);
//
//   final Widget leading;
//   final Widget title;
//   final ValueChanged<bool> onExpansionChanged;
//   final List<Widget> children;
//   final Color backgroundColor;
//   final Widget trailing;
//   final bool initiallyExpanded;
//
//   @override
//   AppExpansionTileState createState() => new AppExpansionTileState();
// }
//
// class AppExpansionTileState extends State<AppExpansionTile> with SingleTickerProviderStateMixin {
//   AnimationController _controller;
//   CurvedAnimation _easeOutAnimation;
//   CurvedAnimation _easeInAnimation;
//   ColorTween _borderColor;
//   ColorTween _headerColor;
//   ColorTween _iconColor;
//   ColorTween _backgroundColor;
//   Animation<double> _iconTurns;
//
//   bool _isExpanded = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = new AnimationController(duration: _kExpand, vsync: this);
//     _easeOutAnimation = new CurvedAnimation(parent: _controller, curve: Curves.easeOut);
//     _easeInAnimation = new CurvedAnimation(parent: _controller, curve: Curves.easeIn);
//     _borderColor = new ColorTween();
//     _headerColor = new ColorTween();
//     _iconColor = new ColorTween();
//     _iconTurns = new Tween<double>(begin: 0.0, end: 0.5).animate(_easeInAnimation);
//     _backgroundColor = new ColorTween();
//
//     _isExpanded = PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
//     if (_isExpanded)
//       _controller.value = 1.0;
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void expand() {
//     _setExpanded(true);
//   }
//
//   void collapse() {
//     _setExpanded(false);
//   }
//
//   void toggle() {
//     _setExpanded(!_isExpanded);
//   }
//
//   void _setExpanded(bool isExpanded) {
//     if (_isExpanded != isExpanded) {
//       setState(() {
//         _isExpanded = isExpanded;
//         if (_isExpanded)
//           _controller.forward();
//         else
//           _controller.reverse().then<void>((value) {
//             setState(() {
//               // Rebuild without widget.children.
//             });
//           });
//         PageStorage.of(context)?.writeState(context, _isExpanded);
//       });
//       if (widget.onExpansionChanged != null) {
//         widget.onExpansionChanged(_isExpanded);
//       }
//     }
//   }
//
//   Widget _buildChildren(BuildContext context, Widget child) {
//     final Color borderSideColor = _borderColor.evaluate(_easeOutAnimation) ?? Colors.transparent;
//     final Color titleColor = _headerColor.evaluate(_easeInAnimation);
//
//     return new Container(
//       decoration: new BoxDecoration(
//           color: _backgroundColor.evaluate(_easeOutAnimation) ?? Colors.transparent,
//           border: new Border(
//             top: new BorderSide(color: borderSideColor),
//             bottom: new BorderSide(color: borderSideColor),
//           )
//       ),
//       child: new Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           IconTheme.merge(
//             data: new IconThemeData(color: _iconColor.evaluate(_easeInAnimation)),
//             child: new ListTile(
//               onTap: toggle,
//               leading: widget.leading,
//               title: new DefaultTextStyle(
//                 style: Theme
//                     .of(context)
//                     .textTheme
//                     .subhead
//                     .copyWith(color: titleColor),
//                 child: widget.title,
//               ),
//               trailing: widget.trailing ?? new RotationTransition(
//                 turns: _iconTurns,
//                 child: const Icon(Icons.expand_more),
//               ),
//             ),
//           ),
//           new ClipRect(
//             child: new Align(
//               heightFactor: _easeInAnimation.value,
//               child: child,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     _borderColor.end = theme.dividerColor;
//     _headerColor
//       ..begin = theme.textTheme.subhead.color
//       ..end = theme.accentColor;
//     _iconColor
//       ..begin = theme.unselectedWidgetColor
//       ..end = theme.accentColor;
//     _backgroundColor.end = widget.backgroundColor;
//
//     final bool closed = !_isExpanded && _controller.isDismissed;
//     return new AnimatedBuilder(
//       animation: _controller.view,
//       builder: _buildChildren,
//       child: closed ? null : new Column(children: widget.children),
//     );
//   }
// }