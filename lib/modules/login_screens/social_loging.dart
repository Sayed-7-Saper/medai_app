
import 'package:medai_app/layout/homeLayout.dart';
import 'package:medai_app/share/network/compontent/compontents.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medai_app/modules/login_screens/cubit1/login_cubit.dart';
import 'package:medai_app/modules/login_screens/cubit1/login_state.dart';
import 'package:medai_app/modules/register_screen/social_register.dart';
import 'package:medai_app/share/network/local/cach_helper.dart';
class SocialLogin extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var formKey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state){
          if (state is SocialLoginErrorState){
           showToast(text: state.error, state: ToastStates.ERROR);
          }
          if(state is SocialLoginSuccessState){
            CacheHelper.saveData(
                key: "uid",
                value: state.uid
            ).
            then((value) {

              navigateAndFinishPage(context, SocialHomeLayout());
            });
          }
        },
        builder: (context,state){
          var cubit =SocialLoginCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(backgroundColor: Colors.white,elevation: 0.0,),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("LOGIN",style:Theme.of(context).textTheme.headline5,),
                        SizedBox(height: 10,),
                        Text("Login now to connect with ....",style: TextStyle(color: Colors.grey),),
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
                          isPassword: SocialLoginCubit.get(context).isPassword,
                          validate: (String value){
                            if (value.isEmpty){
                              return "enter your password";
                            }
                          },
                          label: "enter password",
                          prefix: Icons.lock,
                          suffix: SocialLoginCubit.get(context).suffixIcon,
                            suffixPressed: (){
                              SocialLoginCubit.get(context).isChangePasswordVisibility();
                            },

                        ),
                        SizedBox(height: 25,),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                            builder: (context){
                            return defaultButton(
                              function: (){
                                if(formKey.currentState.validate()){
                                  SocialLoginCubit.get(context).userLogin
                                    (
                                      email: emailController.text,
                                      password: passController.text
                                  ); }

                              },
                              text: "login",isUpperCase: true,);
                            },
                            fallback: (context){
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                            },

                        ),
                        SizedBox(height: 20,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don\'t have an account ?"),
                            TextButton(onPressed: (){
                              navigateToPage(context, RegisterScreen());
                            },
                              child: Text("REGISTER"),),
                          ],
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
