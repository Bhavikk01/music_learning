// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class ReviewStudentCard extends StatelessWidget {
  final data;
  const ReviewStudentCard({
    Key? key, this.data,
  }) : super(key: key);

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
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text(data['name'],
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700
                ),),
              Text('${data['attempedTime']}/${data['noSubmissionsRequired']}',
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 16
                  )),
              Text(dateConverter(data['createdAt']),
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 16
                  ))
            ],
          ),
          IconButton(onPressed: () => {}, icon: const Icon(Icons.chevron_right, size: 48,color: Colors.black,))
        ],
      ),
    );
  }
}


