
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medai_app/modules/login_screens/cubit1/login_state.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>{
  SocialLoginCubit():super(SocialLoginInitialState());
  static SocialLoginCubit get(context)=>BlocProvider.of(context);
  void userLogin({
  @required String email,
  @required  String password,

  }){

    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).
    then((value){
      print(value.user.uid);
     // print('Token Id :${ value.user.getIdToken()}');
      emit(SocialLoginSuccessState(uid:value.user.uid ));
    }).
    catchError((error){emit(SocialLoginErrorState(error.toString()));});

  }

  IconData suffixIcon = Icons.visibility;
  bool isPassword = true;
  void isChangePasswordVisibility(){
    isPassword = !isPassword ;
    suffixIcon = isPassword ?Icons.visibility:Icons.visibility_off_outlined;
    emit(SocialLoginChangeIcon());
  }
}