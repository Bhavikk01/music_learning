import 'package:flutter/material.dart';

class BatchCircle extends StatelessWidget {

  final String subTitle;
  final int count;

  const BatchCircle({
    Key? key, required this.subTitle, required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff27AEE1)
          ),

          child: Center(
            child: Text(
                count.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 12
              ),
            ),
          ),

        ),

        Padding(
          padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
          child: Text(
            subTitle,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13
            ),
          ),
        )
      ],
    );
  }
}

