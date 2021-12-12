import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medai_app/layout/cubit1/cubit.dart';
import 'package:medai_app/layout/cubit1/states.dart';
import 'package:medai_app/model/message_model.dart';
import 'package:medai_app/model/user_model.dart';
class ChatDetailsScreen extends StatelessWidget {
  UserModel userModel;
  ChatDetailsScreen({this.userModel});
  var TextController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context){
        SocialCubit.get(context).getMessages(receiverId: userModel.uId);
        return BlocConsumer<SocialCubit,SocialStates>(
          listener:(context,state){},
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 10.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 23.0,
                      backgroundImage: NetworkImage('${userModel.image}'),
                    ),
                    SizedBox(width: 15.0,),
                    Text('${userModel.name}',style: TextStyle(fontSize: 21),),

                  ],
                ),
              ),
              body:ConditionalBuilder(
                condition:  true ,//SocialCubit.get(context).messages.length > 0,
                builder: (context)=>  Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(children: [
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context,index){
                            var message = SocialCubit.get(context).messages[index];
                            if(SocialCubit.get(context).userModel.uId == message.senderId)
                              return buildMyMessage(message);
                            return buildMessage (message);
                          },
                          separatorBuilder: (context,index)=>SizedBox(height: 15.0,),
                          itemCount: SocialCubit.get(context).messages.length,
                      ),
                    ),
                    //Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey,
                              width: 1.3
                          ),
                          borderRadius: BorderRadius.circular(13.0)
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(children: [
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:10.0),
                              child: TextField(
                                controller: TextController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your message here ... ',

                                ),
                              ),
                            )),
                        Container(
                          color: Colors.blueAccent,
                          height: 47,
                          width: 75,
                          child: MaterialButton(
                            onPressed: (){
                              SocialCubit.get(context).sendMessage(
                                receiverId: userModel.uId,
                                  dateTime: DateTime.now().toString(),
                                  text: TextController.text,
                              );
                            },
                            child: Icon(Icons.send,size: 25.0,color: Colors.white,),
                          ),
                        ),
                      ],),
                    ),

                  ],),
                ),
                fallback: (context)=>Center(child: CircularProgressIndicator(),),
              ),
            );
          }, );
      },
    );
  }
  Widget buildMessage (MessageModel model)=> Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10.0),
          topStart: Radius.circular(10.0),
          topEnd: Radius.circular(10.0),

        ),
      ),
      child: Text('${model.text}'),
    ),
  );
  Widget buildMyMessage(MessageModel model)=> Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.blue[300],
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10.0),
          topStart: Radius.circular(10.0),
          topEnd: Radius.circular(10.0),

        ),
      ),
      child: Text('${model.text}'),
    ),
  );
}
