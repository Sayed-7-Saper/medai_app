import 'dart:io';
import 'package:medai_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medai_app/layout/cubit1/cubit.dart';
import 'package:medai_app/layout/cubit1/states.dart';
import 'package:medai_app/share/network/compontent/compontents.dart';
class SettingScreen extends StatefulWidget {

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = SocialCubit.get(context);
          var userModel = SocialCubit.get(context).userModel;
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 260,
                  width: double.infinity,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 3.0),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 7.0,
                            child: Image(
                              image:
                              NetworkImage('https://image.freepik.com/free-photo/picture-young-pretty-woman-model-pointing-opened-palm_114579-67123.jpg'),
                              fit: BoxFit.cover,
                              height: 210,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 95,
                        height: 95,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: CircleAvatar(
                          radius:45 ,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 43,
                            //  backgroundImage:NetworkImage('${userModel.image}'),
                            backgroundImage:cubit.profileImage == null? NetworkImage('${userModel.image}'):FileImage(cubit.profileImage),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Align(
                          alignment: AlignmentDirectional.topStart,
                          child: IconButton(icon: Icon(Icons.camera,size: 40,),
                            onPressed: (){

                              cubit.getImage();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5,),
                Text('${userModel.name}',
                  style: TextStyle(fontSize: 17,),),
                SizedBox(height: 3,),
                Text('bio : trainer of social appearance',
                  style: TextStyle(fontSize: 13,),),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('100',
                              style: TextStyle(fontSize: 15,),),
                            SizedBox(height: 3,),
                            Text('post',
                              style: TextStyle(fontSize: 13,),),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('2300',
                              style: TextStyle(fontSize: 15,),),
                            SizedBox(height: 3,),
                            Text('Student',
                              style: TextStyle(fontSize: 13,),),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('5',
                              style: TextStyle(fontSize: 15,),),
                            SizedBox(height: 3,),
                            Text('Course',
                              style: TextStyle(fontSize: 13,),),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('3',
                              style: TextStyle(fontSize: 15,),),
                            SizedBox(height: 3,),
                            Text('Level',
                              style: TextStyle(fontSize: 13,),),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                  ],),
                ),
                SizedBox(height: 25,),
                Row(children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: (){},
                      child: Text('Add Photo'),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: (){},
                    child: Icon(Icons.edit),
                  ),

                ],),
                SizedBox(height: 25,),
                Row(
                  children: [
                    Expanded(
                        child:
                        defaultButton(
                            function: (){
                             cubit.uploadProfileImage();
                            //  cubit.updateUser(name: 'kera', phone: '88888855', bio: 'top mangere',image:'${cubit.profileImage}' );
                            },
                            text: 'Edit Profile '))
                  ],
                ),

              ],
            ),
          );
        },
      ),
    );


  }
}


