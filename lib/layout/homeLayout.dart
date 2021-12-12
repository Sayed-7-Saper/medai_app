
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medai_app/layout/cubit1/cubit.dart';
import 'package:medai_app/layout/cubit1/states.dart';
import 'package:medai_app/modules/upload_screen/uploadPage.dart';
import 'package:medai_app/share/network/compontent/compontents.dart';
class SocialHomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){
          if (state is SocialChangeScreenToNewPostState ){
            navigateToPage(context, UploadPage());
          }
        },
        builder: (context,state){
          var cubit = SocialCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,elevation: 0.0,
              title: Text(" Feed App",
                style: TextStyle(color: Colors.blue,fontSize:22,fontWeight: FontWeight.bold ),),
              actions: [
                IconButton(icon: Icon(Icons.notifications,color: Colors.black,),
                    onPressed: (){
                }),
                IconButton(icon: Icon(Icons.search,color: Colors.black,),
                    onPressed: (){
                    }),
              ],
            ),
            //
            body:  cubit.widgetScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,

              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.ChangeBottomNav(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.five_k),label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.chat),label: 'Chat'),
                BottomNavigationBarItem(icon: Icon(Icons.cloud),label: 'Post'),
                BottomNavigationBarItem(icon: Icon(Icons.add_location_alt_outlined),label: 'User'),
                BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined),label: 'Setting'),

              ],
            ),

          );
        },);
  }
}
 /*ConditionalBuilder(
              condition: SocialCubit.get(context).model != null,
              builder: (context){
                var model = SocialCubit.get(context).model;
                print('this UId:  ${model.uId} ');
                print('this SMs :  ${model.isEmailVerified} ');
                return Column(
                  children: [
                  //  if(!model.isEmailVerified )
                    if(!FirebaseAuth.instance.currentUser.emailVerified)
                    Container(
                      width: double.infinity,
                      height: 60,
                      color: Colors.amber.withOpacity(.6),
                      child:Row(
                        children: [
                          Icon(Icons.add_circle_sharp),
                          SizedBox(width: 10,),
                          Text('Please Verify your email'),
                          Spacer(),
                          defaultTextButton(function: (){
                            FirebaseAuth.instance.currentUser
                                .sendEmailVerification().then((value){
                                  showToast(text: "check your mail",state: ToastStates.SUCCESS,);

                            })
                                .catchError((error){
                              showToast(text: error.toString(),state: ToastStates.ERROR,);
                            });
                          }, text: "send"),

                        ],),
                    ),

                  ],
                );
              },
              fallback:(context)=> Center(child: CircularProgressIndicator(),),
            ),*/