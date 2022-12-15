
import 'package:get/get.dart';

class HomeScreenController extends GetxController{

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  newCurrentIndex(int index){
    _currentIndex = index;
    update();
  }

}