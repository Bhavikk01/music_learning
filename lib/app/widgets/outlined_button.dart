import 'package:flutter/material.dart';

class OutlinedButton extends StatelessWidget {
  const OutlinedButton({Key? key, this.child, this.onPressed}) : super(key: key);
  final Widget? child;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: onPressed,
          child:Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Color(0x44000000),
                  blurRadius: 2
              )
            ],
            borderRadius: BorderRadius.circular(30.0)
        ),
        child: child
    ));
  }
}