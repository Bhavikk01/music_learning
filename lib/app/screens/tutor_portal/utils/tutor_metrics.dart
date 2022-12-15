// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

Column TutorMetric({required String value, required String type}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(
        child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle
          ),
          child: Center(child: Text(value,
            style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontFamily: 'Poppins',
            ),
          )),
        ),
      ),
       SizedBox(
        width: 120,
        child: Center(
          child: Text(
           type,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 15
            ),
          ),
        ),
      ),
    ],
  );
}

