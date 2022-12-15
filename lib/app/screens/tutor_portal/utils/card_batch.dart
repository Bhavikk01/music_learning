// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../batch_screen.dart';
import 'batch_circle.dart';

class CardWorkoutBank extends StatelessWidget {

  final data;
  final int index;

  const CardWorkoutBank({
    Key? key,this.data, required this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border:  Border.all(color: Colors.grey),
            boxShadow: [BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 2
            )]
        ),
        width: MediaQuery.of(context).size.width * 0.7,
        padding: const EdgeInsets.fromLTRB(10 , 16, 10, 16),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Text(
                'Batch $index',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 42.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BatchCircle(subTitle: 'Students', count: data['userIds'] != null ? data['userIds'].length : 0 ,),
                  BatchCircle(subTitle: 'Sessions', count: data['sessionsTaken'] ?? 0,),
                  BatchCircle(subTitle: 'Workouts', count: data['assignedHomeworks'] ?? 0,),
                  IconButton(
                    padding: const EdgeInsets.only(bottom: 20),
                      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => BatchScreen(data: data, index: index))),
                      icon: const Icon(
                          Icons.chevron_right,
                          color: Colors.black,
                      ))
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}

