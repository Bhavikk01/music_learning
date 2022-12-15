
// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:flutter/material.dart';

class BatchCard extends StatelessWidget {

  final userData;

  const BatchCard({
    Key? key,required this.userData,
  }) : super(key: key);



  static const  cHeadingStyle = TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins');



  static const  cSubHeadingStyle = TextStyle(
      fontSize: 15,
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontFamily: 'Poppins');


  dateConverter(date) {
    if(date == null) {
      return 'Null';
    }

    var newDate = '';

    newDate = '${DateTime.fromMicrosecondsSinceEpoch(date).day}-${DateTime.fromMicrosecondsSinceEpoch(date).month}-${DateTime.fromMicrosecondsSinceEpoch(date).year}';
    return newDate;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(top: 16),
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

      child: Column(
        children: [
           Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Center(
              child: Text(
                userData['user']['name']?? 'Student Name',
                style: cHeadingStyle,
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: const [
                  Text('WorkOuts', style: cSubHeadingStyle,),
                  Text('Joined on',style: cSubHeadingStyle ),
                  Text('Birthday',style: cSubHeadingStyle ),

                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text(': ${userData['completedHomeworkCount']}/${userData['allHomeworksCount']}' , style: cSubHeadingStyle,),
                  Text(': ${dateConverter(userData['joiningDate'])}',style: cSubHeadingStyle),
                  Text(': ${dateConverter(userData['user']['dob'])}',style: cSubHeadingStyle),

                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
