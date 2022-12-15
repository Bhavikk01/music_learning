
// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class StudentSubmissionCard extends StatelessWidget {
  const StudentSubmissionCard({
    Key? key,
    this.function, this.homeworkData, this.userData
  }) : super(key: key);

  final homeworkData, userData, function;

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
        margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
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
            Image.asset('assets/male.png', width: 70,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: const Text('Varun Mamagain', style: headingStyle,)),
                const Text('Fur Elise Part 1', style: subHeadingStyle,),
                const Text('4/4 Submissions',style: subHeadingStyle ),
                const Text('28 Feb 2022',style: subHeadingStyle ),

              ],
            ),
            const Icon(Icons.chevron_right, color: Colors.black, size: 58,)
          ],
        ),
      ),
    );
  }
}

