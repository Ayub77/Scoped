// ignore_for_file: prefer_const_constructors
import 'package:bloc/model/post_model.dart';
import 'package:bloc/pages/update_and_newAdd_post.dart';
import 'package:bloc/viewmodel/home_view_model.dart';
import 'package:bloc/widgets/home+page_widget.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HemeScoped scoped = HemeScoped();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scoped.apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("setState"),
        centerTitle: true,
      ),
      body: ScopedModel<HemeScoped>(
       model: scoped,
       child: ScopedModelDescendant<HemeScoped>(
         builder: (context,child,model){
           return Stack(
              children: [
                ListView.builder(
                    itemCount: scoped.items.length,
                    itemBuilder: (context, index) {
                      return HomeWidget(
                        scoped: scoped,
                        post: scoped.items[index],
                      );
                    }),
                scoped.loading? Center(child: CircularProgressIndicator(),): SizedBox.shrink()
                    ],
            );
         },
       ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdateAndAdd(title: "Add",id: "0"))).then((value) {
            if (value) {
              scoped.apiPostList();
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
