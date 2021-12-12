
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medai_app/layout/cubit1/cubit.dart';
import 'package:medai_app/layout/cubit1/states.dart';
import 'package:medai_app/model/user_model.dart';
import 'package:medai_app/modules/Chat_screens/chat_details_screen.dart';
import 'package:medai_app/share/network/compontent/compontents.dart';
class ChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:ConditionalBuilder(
                  condition: SocialCubit.get(context).users.length > 0,
                  builder: (context)=>ListView.separated(
                    itemBuilder:(context,index)=>buildChatItem(context,SocialCubit.get(context).users[index]),
                    separatorBuilder: (context,index)=>Divider(thickness: 1.5,height: 2,),
                    itemCount: SocialCubit.get(context).users.length,
                  ),
                  fallback: (context)=>Center(child: CircularProgressIndicator(),),
                ),
              ),
            ),
          );
        },
        );
  }
  Widget buildChatItem(context,UserModel model)=>  InkWell(
    onTap: (){
      navigateToPage(context, ChatDetailsScreen(userModel: model,));
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          CircleAvatar(
            radius:25,
            backgroundImage: NetworkImage('${model.image}' ),
          ),
          SizedBox(width: 15,),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('${model.name}',style: TextStyle(height: 1.5,fontSize: 15),),
                  SizedBox(width: 5.0,),
                  Icon(Icons.check_circle,color: Colors.blue,size: 17,),
                ],
              ),

              Text('${DateTime.now()}',
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
    ),
  );
}
