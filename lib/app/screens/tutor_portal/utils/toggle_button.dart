import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {

  final String titleOne, titleTwo;
  final  Function function1, function2;
  const ToggleButton({Key? key, required this.titleOne, required this.titleTwo, required this.function1, required this.function2}) : super(key: key);

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

const double width = 300.0;
const double height = 60.0;
const double loginAlign = -1;
const double signInAlign = 1;
const Color selectedColor = Color(0xff27AEE1);
const Color normalColor = Colors.black54;

class _ToggleButtonState extends State<ToggleButton> {
  late double xAlign;
  late Color loginColor;
  late Color signInColor;

  @override
  void initState() {
    super.initState();
    xAlign = loginAlign;
    loginColor = selectedColor;
    signInColor = normalColor;
  }

  @override
  Widget build(BuildContext context) {



    return Center(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 2,
              blurStyle: BlurStyle.outer
            ),],
            color: const Color(0xffF6F6F6),
            borderRadius: const BorderRadius.all(
              Radius.circular(50.0),
            ),
          ),
          child: Stack(
            children: [
              AnimatedAlign(
                alignment: Alignment(xAlign, 0),
                duration: const Duration(milliseconds: 300),
                child: Container(
                  width: width * 0.5,
                  height: height,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50.0),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    xAlign = loginAlign;
                    loginColor = selectedColor;
                    widget.function1();
                    signInColor = normalColor;
                  });
                },
                child: Align(
                  alignment: const Alignment(-1, 0),
                  child: Container(
                    width: width * 0.5,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      widget.titleOne,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: loginColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    xAlign = signInAlign;
                    signInColor = selectedColor;
                    widget.function2();
                    loginColor = normalColor;
                  });
                },
                child: Align(
                  alignment: const Alignment(1, 0),
                  child: Container(
                    width: width * 0.5,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      widget.titleTwo,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: signInColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}