
// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class StudentMinimumCard extends StatelessWidget {
  const StudentMinimumCard({
    Key? key,
    required this.data,
    this.function
  }) : super(key: key);

  final data, function;

  static const  headingStyle = TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins');



  static const  subHeadingStyle = TextStyle(
      fontSize: 15,
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontFamily: 'Poppins');


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        // ignore: avoid_print
        function == null ? print('Null function') : function()
      },
      child: Container(
        margin: const EdgeInsets.only(top: 32),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border:  Border.all(color: Colors.grey),
            boxShadow: [BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 2
            )]
        ),
        width: MediaQuery.of(context).size.width * 0.85,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Text(data == null ? 'Name' : data['user']['name']?? 'Student Name', style: headingStyle,)
            ),
            IconButton(onPressed: () => {function()}, icon: const Icon(Icons.chevron_right, color: Colors.black, size: 24,))
          ],
        ),
      ),
    );
  }
}

