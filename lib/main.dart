import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:medai_app/layout/cubit1/cubit.dart';
import 'package:medai_app/layout/homeLayout.dart';
import 'package:medai_app/modules/login_screens/social_loging.dart';
import 'package:medai_app/share/blocOfserver.dart';
import 'package:medai_app/share/network/compontent/compontents.dart';
import 'package:medai_app/share/network/compontent/conestanc.dart';
import 'package:medai_app/share/network/local/cach_helper.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print(token);
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(text: event.data.toString(), state: ToastStates.SUCCESS);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(text: event.data.toString(), state: ToastStates.SUCCESS);

  });

  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
   uId = CacheHelper.getData(key: 'uid');
  Widget widget;
  print(uId);
  if(uId != null){
    widget = SocialHomeLayout()  ;
  }else{
    widget = SocialLogin();
  }

  runApp(MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp({this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context)=>
      SocialCubit()..getUserData()..getPosts()),
    ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: startWidget,
    ),);
  }
}


