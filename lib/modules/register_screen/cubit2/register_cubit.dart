
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medai_app/model/user_model.dart';
import 'package:medai_app/modules/register_screen/cubit2/register_state.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>{
  SocialRegisterCubit():super(SocialRegisterInitialState());
  static SocialRegisterCubit get(context)=>BlocProvider.of(context);
  void userRegister({
    @required String name,
    @required String phone,
    @required String email,
    @required  String password,

  }){

    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
        .then((value){
          print(value.user.email);
          print(value.user.uid);
          CreateUser(
              name: name,
              phone: phone,
              email: email,
              uId: value.user.uid);
         // emit(SocialRegisterSuccessState());
        }).catchError((error){
          emit(SocialRegisterErrorState(error.toString()));
    });


  }

  void CreateUser({
    @required String name,
    @required String phone,
    @required String email,
    @required String uId,

  }){
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      image: 'https://image.freepik.com/free-vector/cute-cool-astronaut-with-jacket-jeans-cartoon-vector-icon-illustration-science-fashion-icon-concept-isolated-premium-vector-flat-cartoon-style_138676-3318.jpg',
      uId: uId,
      bio: 'Write Your Description bio .. ',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance.
    collection("users")
        .doc(uId).set(model.toMap())
        .then((value) {
          emit(SocialCreateSuccessState());
    }).catchError((error){
      emit(SocialCreateErrorState(error.toString()));
    });

}

  IconData suffixIcon = Icons.visibility;
  bool isPassword = true;
  void isChangePasswordVisibility(){
    isPassword = !isPassword ;
    suffixIcon = isPassword ?Icons.visibility:Icons.visibility_off_outlined;
    emit(SocialRegisterChangeIcon());
  }
}