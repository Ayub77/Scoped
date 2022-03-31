import 'package:bloc/model/post_model.dart';
import 'package:bloc/pages/update_and_newAdd_post.dart';
import 'package:bloc/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class HomeWidget extends StatelessWidget {
  const HomeWidget({ Key? key, required this.post, required this.scoped}) : super(key: key);
  final Post post;
  final HemeScoped scoped;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      direction: Axis.horizontal,
      startActionPane: ActionPane(
      extentRatio: 0.25,
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (value){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdateAndAdd(title: "Update",id: post.id.toString(),post:post))).then((value){
             if(value){
               scoped.apiPostList();
             }
           });
          },
         backgroundColor: Colors.indigo,
         icon: Icons.edit,
         label: "Update", 
          )
      ],),
      endActionPane: ActionPane(
      extentRatio: 0.25,
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (value){
          scoped.apiPostdelete(post);
          },
         backgroundColor: Colors.red,
         icon: Icons.delete,
         label: "delete", 
          )
      ],),
      child:Container(
      padding: EdgeInsets.only(top: 20,left: 20,right: 20),
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Text(post.title.toUpperCase(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          const SizedBox(height: 5,),
          Text(post.body)
        ],
      ),
    ) );
  }
}