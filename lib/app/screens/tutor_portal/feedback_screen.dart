import 'package:flutter/material.dart';

import '../../widgets/main_button.dart';


class SendFeedback extends StatefulWidget {
  const SendFeedback({Key? key}) : super(key: key);

  @override
  State<SendFeedback> createState() => _SendFeedbackState();
}

class _SendFeedbackState extends State<SendFeedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top+40,),
          Text('Add Comment', style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.black),),
          const SizedBox(height: 20,),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0x11C4C4C4),
              border: Border.all()
            ),
            child:  const TextField(
              maxLines: 10,
              minLines: 4,
              decoration: InputDecoration(
                hintText: 'Add Comment',
                border: InputBorder.none, fillColor: Color(0x11C4C4C4),
              ),
            ),
          ),
          const Expanded(child: SizedBox(),),
          const Padding(padding: EdgeInsets.all(20), child: MainButton(title: 'Send Feedback'))
        ],
      ),
    );
  }
}
