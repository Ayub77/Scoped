import 'package:bloc/model/post_model.dart';
import 'package:bloc/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UpdateAndAddScoped extends Model {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final userIdController = TextEditingController();
  final idController = TextEditingController();
  bool loading = false;

  choose(String title,Post post){ 
   if(title=="Update"){
    titleController.text = post.title;
    bodyController.text = post.body;
    userIdController.text = post.userId.toString();
    idController.text = post.id.toString();
    notifyListeners();
   }
  }
  
  Future<bool> apiPostAdd(String title, String id) async {
    loading = true;
    notifyListeners();
    if (title == "Add") {
      Post post = Post(
          id: int.parse(idController.text.trim()),
          title: titleController.text.trim(),
          body: bodyController.text.trim(),
          userId: int.parse(userIdController.text.trim()));
      var respons =await Network.POST(Network.API_CREATE, Network.paramsCreate(post));
      if (respons != null) {
        loading = false;
        notifyListeners();
        return true;
      }
    } else {
     Post post = Post(
          id: int.parse(idController.text.trim()),
          title: titleController.text.trim(),
          body: bodyController.text.trim(),
          userId: int.parse(userIdController.text.trim()));
      var respons = await Network.PUT(Network.API_UPDATE + id, Network.paramsUpdate(post));
      if (respons != null) {
        loading = false;
        notifyListeners();
        return true;
      }
    }
    return false;
  }
}
