import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medai_app/layout/homeLayout.dart';
import 'package:medai_app/modules/register_screen/cubit2/register_cubit.dart';
import 'package:medai_app/modules/register_screen/cubit2/register_state.dart';
import 'package:medai_app/share/network/compontent/compontents.dart';
class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var formKey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state){
          if (state is SocialCreateSuccessState){
            navigateAndFinishPage(context, SocialHomeLayout());
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("REGISTER",style:Theme.of(context).textTheme.headline5,),
                        SizedBox(height: 10,),
                        Text("Login now to browse our hot offer",style: TextStyle(color: Colors.grey),),
                        SizedBox(height: 15,),
                        defaultTextFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: ( String value){
                            if(value.isEmpty )
                            {
                              return "please enter your Name ";
                            }
                            // else  {
                            //   nameController.text = value.toString();
                            //
                            // }
                          },
                          label: "Enter User Name",
                          prefix: Icons.person,
                        ),

                        SizedBox(height: 15,),
                        defaultTextFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: ( String value){
                            if(value.isEmpty )
                            {
                              return "please enter your Phone ";
                            }
                          },
                          label: "Enter Phone",
                          prefix: Icons.phone,
                        ),

                        SizedBox(height: 15,),
                        defaultTextFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: ( String value){
                            if(value.isEmpty )
                            {
                              return "please enter your mail first ";
                            }
                          },
                          label: "Enter email",
                          prefix: Icons.email,
                        ),

                        SizedBox(height: 15,),
                        defaultTextFormField(
                            controller: passController,
                            type: TextInputType.visiblePassword,
                            isPassword: SocialRegisterCubit.get(context).isPassword,
                            validate: (String value){
                              if (value.isEmpty){
                                return "enter your password";
                              }
                            },
                            label: "enter password",
                            prefix: Icons.lock,
                            suffix: SocialRegisterCubit.get(context).suffixIcon,
                            suffixPressed: (){
                              SocialRegisterCubit.get(context).isChangePasswordVisibility();
                            },
                            onSubmit: (value){

                            }
                        ),
                        SizedBox(height: 25,),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState,
                          builder: (context){
                            return defaultButton(
                              function: (){
                                if(formKey.currentState.validate()){
                                  SocialRegisterCubit.get(context).userRegister
                                    (
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                      password: passController.text
                                  );
                                }

                              },
                              text: "login",isUpperCase: true,
                            );
                          },
                          fallback: (context){
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },

                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),

    );
  }
}
