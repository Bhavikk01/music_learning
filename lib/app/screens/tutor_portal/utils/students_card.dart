// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class StudentsCard extends StatelessWidget {
  const StudentsCard({
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

    return InkWell(
      onTap: () => {
        // ignore: avoid_print
        function == null ? print('Null function') : function()
      },
      child: Container(
        margin: const EdgeInsets.only(top: 32),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border:  Border.all(color: Colors.grey),
            boxShadow: [BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 2
            )]
        ),
        width: MediaQuery.of(context).size.width * 0.75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/images/male.png', width: 70,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Text(data['user']['name'] ?? 'Student Name', style: headingStyle,)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: const [
                        Text('Workouts', style: subHeadingStyle,),
                        Text('Attendance',style: subHeadingStyle ),
                        Text('Joined on',style: subHeadingStyle ),
                        Text('Birthday',style: subHeadingStyle ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 48),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(': ${data['completedHomeworkCount']}/${data['allHomeworksCount']}', style: subHeadingStyle,),
                          const Text(': 90/100(90%)',style: subHeadingStyle),
                          Text(": ${dateConverter(data['joiningDate'])}",style: subHeadingStyle),
                          const Text(': 18th Nov',style: subHeadingStyle),

                        ],
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

