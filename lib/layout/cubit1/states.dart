 abstract class SocialStates{}
 class SocialInitialState extends SocialStates{}
 class SocialGetUserLoadingState extends SocialStates{}
 class SocialGetUserSuccessState extends SocialStates{}
 class SocialGetUserErrorState extends SocialStates{
  final String error;
  SocialGetUserErrorState({this.error});
 }
 class SocialGetAllUserLoadingState extends SocialStates{}
 class SocialGetAllUserSuccessState extends SocialStates{}
 class SocialGetAllUserErrorState extends SocialStates{
  final String error;
  SocialGetAllUserErrorState({this.error});
 }
 class SocialGetPostLoadingState extends SocialStates{}
 class SocialGetPostSuccessState extends SocialStates{}
 class SocialGetPostErrorState extends SocialStates{
  final String error;
  SocialGetPostErrorState({this.error});
 }
 class SocialLikeSuccessState extends SocialStates{}
 class SocialLikeErrorState extends SocialStates{
  final String error;
  SocialLikeErrorState({this.error});
 }
 class SocialChangeBottomState extends SocialStates{}
 class SocialChangeScreenToNewPostState extends SocialStates{}
 class SocialGetImageSuccessState extends SocialStates{}
 class SocialGetImageErrorState extends SocialStates{}
 class SocialRemoveImageSuccessState extends SocialStates{}
 class SocialUploadImageSuccessState extends SocialStates{}
 class SocialUploadImageErrorState extends SocialStates{}
 class SocialCreatePostLoadingState extends SocialStates{}
 class SocialCreatePostSuccessState extends SocialStates{}
 class SocialCreatePostErrorState extends SocialStates{}
 class SocialPostImageSuccessState extends SocialStates{}
 class SocialPostImageErrorState extends SocialStates{}
 ///////
 class SocialSendMessageSuccessState extends SocialStates{}
 class SocialSendMessageErrorState extends SocialStates{}
 class SocialGetMessageSuccessState extends SocialStates{}

