import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medai_app/layout/cubit1/states.dart';
import 'package:medai_app/model/message_model.dart';
import 'package:medai_app/model/post_model.dart';
import 'package:medai_app/model/user_model.dart';
import 'package:medai_app/modules/Chat_screens/ChatPage.dart';
import 'package:medai_app/modules/feeds_screens/feedPage.dart';
import 'package:medai_app/modules/setting_screen/settingPage.dart';
import 'package:medai_app/modules/user_screen/userPage.dart';
import 'package:medai_app/share/network/compontent/conestanc.dart';

class SocialCubit extends Cubit<SocialStates>{
  SocialCubit():super(SocialInitialState());
  static SocialCubit get(context)=>BlocProvider.of(context);

  UserModel userModel;
  void getUserData(){
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance
        .collection("users").doc(uId).get()
        .then((value) {
          userModel = UserModel.fromJson(value.data());
          print(value.id);
          emit(SocialGetUserSuccessState());
    }).catchError((error){
      emit(SocialGetUserErrorState
        (error: error.toString()));
    });
  }
  List<Widget> widgetScreens=[
    FeedScreen(),
    ChatScreen(),
    Container(),
    UserScreen(),
    SettingScreen(),
  ];
  int currentIndex = 0;
  void ChangeBottomNav(int index){
    if(index ==1) getUsers();
    if (index == 2)
      emit(SocialChangeScreenToNewPostState());
    else{
      currentIndex = index;
      emit(SocialChangeBottomState());
    }

  }

///////////////////
  File profileImage;
  var picker = ImagePicker();
  Future <void> getImage() async {
    //final pickedFile = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        profileImage = File(pickedFile.path);
        print(pickedFile.path);
        emit(SocialGetImageSuccessState());
      } else {
        print('No image selected.');
        emit(SocialGetImageErrorState());
      }

  }
///////////
  String imageUrl= '';
  void uploadProfileImage(){
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
          value.ref.getDownloadURL().then((value) {
            emit(SocialUploadImageSuccessState());
            imageUrl= value;
            print(value);
          }).catchError((error){
            emit(SocialUploadImageErrorState());
          });
       })
        .catchError((error){
      emit(SocialUploadImageErrorState());

    });

  }
///////////////
void updateUser(
  {
  @required String name,
    @required String phone,
    @required String bio,
    String image,

  }
    ){
    if(profileImage != null){
      uploadProfileImage();
    }
    else{
      UserModel model = UserModel(
        //لو هدجدد في حاجه تاخده برامتر وتجدد اوما البلقي سيه نفس القيم القديمه
         name:userModel.name, // name,
        email: userModel.email,
        phone: userModel.phone,
        image:image?? userModel.image,
        uId: userModel.uId,
        bio: 'Write Your Description bio .. ',
        isEmailVerified: false,
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.uId).update(model.toMap())
          .then((value) {
        getUserData();
      })
          .catchError((error){});
    }

}
  
  /////////////////////////
  File postImage;
  var postPicker = ImagePicker();
  Future <void> upPostImage() async {
    final pickedFile = await postPicker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialPostImageSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImageErrorState());
    }

  }
  void removePostImage(){
    postImage = null;
    emit(SocialRemoveImageSuccessState());
  }

  void upLoadPostImage({
    @required String dateTime,
    @required String text,
   // @required String name,
   // @required String image,
  //  @required String uId,

   }){
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) {
          value.ref.getDownloadURL()
              .then((value){
                CreatePost(
                    dateTime: dateTime,
                    text: text,
                  postImage: value,
                );

          })
              .catchError((error){
            emit(SocialCreatePostErrorState());
          });
    })
        .catchError((error){
          emit(SocialCreatePostErrorState());
    });


  }
  ///////////////////

  void CreatePost(
      {
        @required String dateTime,
        @required String text,
        String postImage,
      }
      ){
    emit(SocialCreatePostLoadingState());
      PostModel model = PostModel(
        name:userModel.name,
        image: userModel.image,
        uId: userModel.uId,
        dateTime: dateTime,
        text: text,
        postImage: profileImage??"",
      );
      FirebaseFirestore.instance
          .collection('posts')
          .add(model.toMap())
          .then((value) {
            emit(SocialCreatePostSuccessState());

      })
          .catchError((error){
            emit(SocialCreatePostErrorState());
      });
  }
///////////////////////////
List<PostModel> posts = [];
  List<String>postsId=[];
  List<int> likes=[];
  void getPosts(){
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            element.reference
                .collection('likes')
                .get()
                .then((value) {
                  likes.add(value.docs.length);
              //print(element.id);
              postsId.add(element.id);
              posts.add(PostModel.fromJson(element.data()));
            })
                .catchError((error){});

          });
          emit(SocialGetPostSuccessState());
    })
        .catchError((error){
          emit(SocialGetPostErrorState(error: error.toString()));
    });

  }

  //////////////
  void likePost(String postId){
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel.uId)
        .set({
      'like':true,
    })
        .then((value) {
          emit(SocialLikeSuccessState());
    })
        .catchError((error){
          emit(SocialLikeErrorState(error: error.toString()));
    });
  }
  ////////////////
  List <UserModel> users=[];
  void getUsers(){
    if (users.length ==0)
    FirebaseFirestore.instance.collection('users')
    .get().then((value) {
      value.docs.forEach((element) {
        if(element.data()['uId'] != userModel.uId)
        users.add(UserModel.fromJson(element.data()));
      });
      emit(SocialGetAllUserSuccessState());
    })
        .catchError((error){
          emit(SocialGetAllUserErrorState());
    });
  }
  /////////////////
  void sendMessage({
  @required String receiverId,
    @required String dateTime,
    @required String text,

  }){
    MessageModel model = MessageModel(
      senderId: userModel.uId,
      receiverId: receiverId,
      text: text,
      dateTime: dateTime,
    );
    // my
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
          emit(SocialSendMessageSuccessState());
    })
        .catchError((error){
          emit(SocialSendMessageErrorState());
    });
    //////////// to
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((error){
      emit(SocialSendMessageErrorState());
    });
}

/////////////
List<MessageModel> messages=[];
  void getMessages({
    @required String receiverId,

  }){
    FirebaseFirestore.instance
    .collection('users')
    .doc(userModel.uId)
    .collection('chats')
    .doc(receiverId)
    .collection('messages')
    .orderBy('dateTime')
    .snapshots()
    .listen((event) {
      messages=[];
      event.docs.forEach((element) {
         messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
}

}