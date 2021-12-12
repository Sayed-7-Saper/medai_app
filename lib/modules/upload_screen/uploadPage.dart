import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medai_app/layout/cubit1/cubit.dart';
import 'package:medai_app/layout/cubit1/states.dart';
import 'package:medai_app/share/network/compontent/compontents.dart';
class UploadPage extends StatelessWidget {
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit =SocialCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("Create Post"),
              actionsIconTheme: IconThemeData(
                color: Colors.white
              ),
              actions: [
                InkWell(
                    child:
                    Center(
                      child: Text('post',
                        style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
                      ),
                    ),
                  onTap: (){
                      var now = DateTime.now();
                      if(cubit.postImage == null){
                        cubit.CreatePost(dateTime: now.toString(),
                            text: textController.text,
                        );
                      }else{
                        cubit.upLoadPostImage(
                          text: textController.text,
                          dateTime:now.toString() ,

                        );
                      }
                  },
                ),
                SizedBox(width: 10.0,),

              ],
            ),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (state is SocialCreatePostLoadingState)
                    LinearProgressIndicator(),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        CircleAvatar(
                          radius:25,
                          backgroundImage: NetworkImage('https://image.freepik.com/free-photo/portrait-happy-young-woman-holding-empty-speech-bubble-standing-isolated-yellow-wall_231208-10128.jpg'),
                        ),
                        SizedBox(width: 15,),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("Merai Fragen",style: TextStyle(height: 1.5,fontSize: 15),),
                                SizedBox(width: 5.0,),
                                Icon(Icons.check_circle,color: Colors.blue,size: 17,),
                              ],
                            ),

                            Text("Jun 30, 2021 at 11:00 pm",
                              style: Theme.of(context).textTheme.caption.copyWith(height: 1.5),),

                          ],
                        ),
                        ),
                        SizedBox(width: 15,),
                        IconButton(icon: Icon(Icons.more_horiz,size: 20,),
                          onPressed: (){

                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Expanded(
                      child: TextField(
                        controller: textController,
                          decoration: InputDecoration(
                            hintText: 'whats is on your mind ...',
                            border: InputBorder.none,
                          ),
                        ),
                    ),
                    SizedBox(height: 35,),
                    if(cubit.postImage != null)
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            height: 140,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              image: DecorationImage(
                                image: FileImage(cubit.postImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          IconButton(
                              icon: Icon(Icons.close),
                              onPressed: (){
                                cubit.removePostImage();
                           // Navigator.pop(context);
                          }),
                        ],
                      ),
                    SizedBox(height: 40,),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextButton(onPressed: (){
                              cubit.upPostImage();
                            },
                                child:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_photo_alternate_outlined),
                                    SizedBox(width: 5.0,),
                                    Text('add photo',),
                                  ],
                                ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(onPressed: (){},
                              child: Text('# tags',),

                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 7,),




                  ],
                ),
              ),
            ),
          );
        },
        );
  }
}
