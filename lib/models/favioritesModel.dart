class ChangeFavoriets{
  bool ? status;
  String ? message;
  ChangeFavoriets.fromJson(Map<String ,dynamic>json){

    status=json['status'];
    message=json['message'];
  }
}