class PostModel{
  String name;
  String image;
  String dateTime;
  String uId;
  String text;
  String postImage;
  PostModel({
    this.name,
    this.image,
    this.dateTime,
    this.uId,
    this.text,
    this.postImage,

  });
  PostModel.fromJson(Map<String,dynamic>json){
    name =json['name'];
    image= json['image'];
    dateTime =json['dateTime'];
    uId =json['uId'];
    text = json['text'];
    postImage =json['postImage'];
  }
  Map<String,dynamic> toMap (){
    return {
      'name': name,
      'image':image,
      'dateTime':dateTime,
      'uId':uId,
      'text':text,
      'postImage':postImage,
    };
  }
}