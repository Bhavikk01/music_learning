import 'dart:ui';

import 'package:flutter/material.dart';
import 'common_helper.dart';
import 'db.dart';
import 'package:flutter/services.dart';

class TempoInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    try{
      int value = int.tryParse(newValue.text)!;
      if (value > 999)
        return oldValue;
    }catch(e){
      if (newValue.text.isNotEmpty)
        return oldValue;
    }
    return newValue;
  }
}

class SelectDrawer extends StatefulWidget {
  final BuildContext mothercontext;

  static int save_num_of_item = 0;

  SelectDrawer(this.mothercontext);

  @override
  _SelectDrawerState createState() => _SelectDrawerState();

// Callbacks for change requirement after user change the sorting parameters
  static List<void Function()?> _updateCallbacks = List.empty(growable: true);

  static int addCallback(void Function() callback) {
    _updateCallbacks.add(callback);
    return _updateCallbacks.length - 1;
  }

  static void removeCallback(int id) {
    if (_updateCallbacks.length > id) _updateCallbacks.removeAt(id);
  }

  static void _callUpdate() {
    for (int i = _updateCallbacks.length - 1; i >= 0; --i) {
      try {
        _updateCallbacks[i]!();
      } catch (e) {}
    }
  }
}

class _SelectDrawerState extends State<SelectDrawer> {
  var tempo = 30;
  var tempoCustom = false;
  var beat1 = 4;
  var beat2 = 4;
  var rhythm = 0;
  var tone = 0;

  var isSelected4by4 = true;
  var isSelected3by4 = false;

  final tempoEditingController = TextEditingController();
  final focusNode = FocusNode();




  void _updateTempo(int value) async {

    if (value == tempo) return;
    if(tempo + value >= 0 && tempo + value <= 360) {
      setState(() {
        tempo += value;
        tempoEditingController.text = tempo.toString();
      });
      _updateTempoFocus(tempo);
      _updatePrefDB('tempo', tempo);
    }


  }

  void _updatePrefDB(String type, int value) async {
    Db.setPref(type, value);
    SelectDrawer._callUpdate();
  }

  void _retrievePref() async {


    final tempo = await Db.getPref('tempo');
    final beat1 = await Db.getPref('beat1');
    final beat2 = await Db.getPref('beat2');
    final rhythm = await Db.getPref('rhythm');
    final tone = await Db.getPref('tone');

    setState(() {
      this.tempo = tempo;
      this.beat1 = beat1;
      this.beat2 = beat2;
      this.rhythm = rhythm;
      this.tone = tone;
      tempoEditingController.text = tempo.toString();
    });
    _updateTempoFocus(tempo);
  }

  @override
  void initState() {
    super.initState();
    _retrievePref();
  }

  void _tempoOnTap(int value) {
      _updateTempo(value);
  }

  void _updateTempoFocus(int value){
    focusNode.unfocus();
  }

  void _beat1Update(int value){
    setState(() {
      this.beat1 = value;
    });
    _updatePrefDB('beat1', value);
  }

  void _beat2Update(int value){
    setState(() {
      this.beat2 = value;
    });
    _updatePrefDB('beat2', value);
  }

  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [


              Column(
                children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(
                        color: Colors.grey.shade300,
                        offset: const Offset(0,0),
                        spreadRadius: 4.0,
                        blurRadius: 15,
                        blurStyle: BlurStyle.outer
                        ),
                        ]
                      ),
                      child: IconButton(
                        onPressed: () {
                          _tempoOnTap(-1);
                        },
                        color: Colors.blue,
                        icon: Icon(
                          Icons.horizontal_rule,
                          size: 35,
                        ),
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 30, 0, 0),
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(
                            color: Colors.grey.shade300,
                            offset: const Offset(0,0),
                            spreadRadius: 4.0,
                            blurRadius: 15,
                            blurStyle: BlurStyle.outer
                        ),
                        ]
                    ),
                    child: InkWell(
                      onTap: () {
                        _tempoOnTap(-5);
                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            ),
                        child: Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text(
                              "-5",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.blue,
                                fontWeight: FontWeight.w600
                              ),
                            )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(

                children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(20, 2, 20, 2),
                    width: 150,
                    child:TextField(

                        controller: tempoEditingController,
                        autocorrect: false,
                        textAlign: TextAlign.center,
                        style: TextStyle(color:tempoCustom?Colors.black:Colors.grey ),
                        selectionHeightStyle: BoxHeightStyle.tight,
                        selectionWidthStyle: BoxWidthStyle.tight,
                        autofocus: false,
                        focusNode: focusNode,
                        enabled: false,
                        decoration: InputDecoration(isDense: true,border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0))),),

                        inputFormatters: [TempoInputFormatter()],
                        onTap: (){
                          setState(() {
                            tempoCustom = true;
                          });

                        },
                        onEditingComplete: (){
                          try{
                            String text = tempoEditingController.text;
                            int value = int.tryParse(text)!;
                            if (value>tempoMax)
                              value = tempoMax;
                            else if (value<tempoMin)
                              value = tempoMin;

                            _updateTempo(value);

                          }catch(e){

                          }
                        },
                        keyboardType:TextInputType.number ,),
                  ),

                  Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text("BPM",
                      style: TextStyle(
                        color: Colors.grey
                      ),))
                ],
              ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20),
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(
                          color: Colors.grey.shade300,
                          offset: const Offset(0,0),
                          spreadRadius: 4.0,
                          blurRadius: 15,
                          blurStyle: BlurStyle.outer
                      ),
                      ]
                  ),
                  child: IconButton(
                    onPressed: () {
                      _tempoOnTap(1);
                    },
                    color: Colors.blue,
                    icon: Icon(
                      Icons.add,
                      size: 35,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 30, 20, 0),
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(
                          color: Colors.grey.shade300,
                          offset: const Offset(0,0),
                          spreadRadius: 4.0,
                          blurRadius: 15,
                          blurStyle: BlurStyle.outer
                      ),
                      ]
                  ),
                  child: InkWell(
                    onTap: () {
                      _tempoOnTap(5);
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Text(
                            "+5",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.blue,
                                fontWeight: FontWeight.w600
                            ),
                          )
                      ),
                    ),
                  ),
                ),
              ],
            ),


          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 40, top: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    _beat1Update(4);
                    _beat2Update(0);
                    isSelected4by4 = true;
                    isSelected3by4 = false;
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: isSelected4by4 ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                        padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                        child: const Text(
                          '4/4',
                          style: TextStyle(color: drawerTextColor),
                        )
                    ),
                  ),
                ),
              ),



              Container(
                padding: EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    _beat1Update(3);
                    _beat2Update(0);
                    isSelected4by4 = false;
                    isSelected3by4 = true;
                  },
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: isSelected3by4 ? Colors.blue : Colors.grey,
                          borderRadius: BorderRadius.circular(8)),
                      child: Container(
                          padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                          child: const Text(
                            '3/4',
                            style: TextStyle(color: drawerTextColor),
                          )
                      )),
                ),
              ),
            ],
          ),
        ),

      ],
    );

  }
}
