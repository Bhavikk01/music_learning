import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../constants/constants.dart';
import 'utility_card.dart';

class UtilitiesScreen extends StatefulWidget {
  const UtilitiesScreen({Key? key}) : super(key: key);

  @override
  State<UtilitiesScreen> createState() => _UtilitiesScreenState();
}

class _UtilitiesScreenState extends State<UtilitiesScreen> {
  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(16.w),
      crossAxisSpacing: 16.w,
      mainAxisSpacing: 16.h,
      children: const [
        UtilityCard(
          imgPath: Constants.metronomeImagePath,
          url: Constants.metronomeUrl,
        ),
        UtilityCard(
          imgPath: Constants.tanpuraImagePath,
          url: Constants.tanpuraUrl,
        ),
        UtilityCard(
          imgPath: Constants.tunerImagePath,
          url: Constants.tunerUrl,
        ),
      ],
    );
  }
}
