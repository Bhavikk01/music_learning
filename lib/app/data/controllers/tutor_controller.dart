
import 'package:get/get.dart';

import '../../models/tutors.dart';
import '../repo/tutor_repo.dart';

class TutorController extends GetxController{
  final TutorRepo tutorRepo;
  TutorController({required this.tutorRepo});

  List<Tutor> tutorList = [];

  getAllTutors() async {
    tutorList = [];
    var response = await tutorRepo.getAllTutors();
    var tutors = response.body;

    for(var element in tutors){
      tutorList.add(Tutor.fromMap(element));
    }
    tutorList.sort(((a, b) => (a.createdAt ?? 0).compareTo(b.createdAt ?? 0)));
    return tutorList;
  }

  getTutor(String tutorId) async{
    Response response = await tutorRepo.getTutor(tutorId);

    final tutor = Tutor.fromMap(response.body);

    return tutor;
  }

  getTutorByPhoneNumber(String phoneNumber) async {
    return await tutorRepo.getTutorByPhoneNumber(phoneNumber);

  }
}