
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medai_app/layout/cubit1/cubit.dart';
import 'package:medai_app/layout/cubit1/states.dart';
import 'package:medai_app/model/post_model.dart';
class FeedScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state){} ,
        builder: (context,state){
          return Scaffold(
            body:ConditionalBuilder(
              condition: SocialCubit.get(context).posts.length > 0 &&SocialCubit.get(context).userModel != null,
              builder: (context)=>SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 3.0),
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 10.0,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Image(
                              image:NetworkImage('https://image.freepik.com/free-photo/young-man-woman-shirts-posing_273609-41278.jpg'),
                              //
                              fit: BoxFit.cover,
                              height: 230,
                              width: double.infinity,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Communicate  With Trainer",style: TextStyle(fontSize: 15),),
                            ),
                          ],

                        ),
                      ),
                    ),
                    ///////////////////
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: SocialCubit.get(context).posts.length ,
                      itemBuilder: (context,index)=> buildPostItem(SocialCubit.get(context).posts[index],context,index),
                      separatorBuilder: (context,index)=>Divider(),

                    ),
                    //////////////////////
                    Container(

                      padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 3.0),
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 10.0,
                        child: Image(
                          image:
                          NetworkImage('https://image.freepik.com/free-photo/happy-young-woman-sitting-floor-using-laptop-gray-wall_231208-11472.jpg'),
                          fit: BoxFit.cover,
                          height: 220,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Container(

                      padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 3.0),
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 10.0,
                        child: Image(
                          image:
                          NetworkImage('https://image.freepik.com/free-photo/indoor-shot-beautiful-happy-african-american-woman-smiling-cheerfully-keeping-her-arms-folded-relaxing-indoors-after-morning-lectures-university_273609-1270.jpg'),
                          fit: BoxFit.cover,
                          height: 220,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Container(

                      padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 3.0),
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 10.0,
                        child: Image(
                          image:
                          NetworkImage('https://image.freepik.com/free-photo/picture-young-pretty-woman-model-pointing-opened-palm_114579-67123.jpg'),
                          fit: BoxFit.cover,
                          height: 220,
                          width: double.infinity,
                        ),
                      ),
                    ),


                  ],
                ),
              ),
              fallback:(context)=> Center(child: CircularProgressIndicator(),),
            ),
          );
        },
        );
  }
  Widget buildPostItem(PostModel model,context,index) =>  Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 10.0,
    margin: EdgeInsets.symmetric(horizontal: 5.0,vertical: 3.0),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius:25,
                backgroundImage: NetworkImage('${SocialCubit.get(context).userModel.image}' ),
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

                  Text('${model.dateTime}',
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical:7.0),
            child: Divider(height: 1.5,thickness: 1.5,),
          ),
          Text(
            ' ${model.text}',style: TextStyle(height: 1.5,fontSize: 15),
          ),
          Text('#softThinking  #deepLearn ',
            style: TextStyle(color: Colors.blue,fontSize: 15),),
          if(model.image != null)
          Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: Container(
              height: 190,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                image:DecorationImage(
                    image:NetworkImage('${model.image}' ),
                    fit: BoxFit.cover
                ),
                //

              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Expanded(
                child:InkWell(
                  child:  Row(
                    children: [
                      Icon(Icons.favorite,size: 21,),
                      SizedBox(width: 7.0,),
                      Text('${SocialCubit.get(context).likes[index]}',style: TextStyle(color: Colors.blue,fontSize: 16),),
                    ],
                  ),
                  onTap: (){},
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.comment,size: 21,),
                      SizedBox(width: 7.0,),
                      Text('75 comment',style: TextStyle(color: Colors.blue,fontSize: 16),),
                    ],
                  ),
                  onTap: (){},
                ),
              ),


            ],),
          ),
          Divider(height:1.5,thickness: 1.5,),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
              child: Row(
                children: [
                  CircleAvatar(
                    radius:17,
                    backgroundImage: NetworkImage('${SocialCubit.get(context).userModel.image}' ),
                  ),
                  SizedBox(width: 15,),
                  Text('Write a comment ...',style: TextStyle(fontSize: 15,),),
                  Spacer(),
                  InkWell(
                    child:  Row(
                      children: [
                        Icon(Icons.favorite,size: 21,),
                        SizedBox(width: 7.0,),
                        Text('Like',style: TextStyle(color: Colors.blue,fontSize: 16),),
                      ],
                    ),
                    onTap: (){
                      SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                    },
                  ),
                ],
              ),
              onTap: (){},
            ),
          ),


        ],
      ),
    ),
  );
}
