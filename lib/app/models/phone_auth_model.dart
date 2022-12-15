import 'package:equatable/equatable.dart';

import 'enums/phone_auth_model.dart';
import 'enums/phone_auth_user_state.dart';

class PhoneAuthModel extends Equatable {
  final PhoneAuthModelState phoneAuthModelState;
  final PhoneAuthUserState userState;
  final String? verificationId;
  final int? verificationToken;
  final String? uid;

  const PhoneAuthModel({
    required this.phoneAuthModelState,
    required this.userState,
    this.verificationId,
    this.verificationToken,
    this.uid,
  });

  PhoneAuthModel copyWith({
    PhoneAuthModelState? phoneAuthModelState,
    PhoneAuthUserState? userState,
    String? verificationId,
    int? verificationToken,
    String? uid,
  }) {
    return PhoneAuthModel(
      phoneAuthModelState: phoneAuthModelState ?? this.phoneAuthModelState,
      userState: userState ?? this.userState,
      verificationId: verificationId ?? this.verificationId,
      verificationToken: verificationToken ?? this.verificationToken,
      uid: uid ?? this.uid,
    );
  }

  @override
  List<Object?> get props => [
        phoneAuthModelState,
        userState,
        verificationId,
        verificationToken,
        uid,
      ];
}
