import 'package:flutter/material.dart';
import 'package:flutter_application_1/add.dart';
import 'package:flutter_application_1/appdate.dart';
import 'package:flutter_application_1/models/post.dart';
import 'package:flutter_application_1/providers/posts_provider.dart';
import 'package:http/http.dart';
import 'dart:ffi';
import 'package:ffi/ffi.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<PostsProvider>(
      create: (_) => PostsProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post>? posts;
  @override
  void initState() {
    super.initState();
    Provider.of<PostsProvider>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    posts = context.watch<PostsProvider>().posts;
    return Scaffold(
        appBar: AppBar(
          actions: [Icon(Icons.refresh)],
          leading: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const Add();
                }));
              },
              icon: const Icon(Icons.add)),
          title: const Text("Posts"),
        ),
        body: Builder(builder: (context) {
          if (posts != null) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: posts!.length,
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemBuilder: (context, index) {
                return buildCard(posts![index]);
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }));
  }

  buildCard(Post post) {
    return Card(
      elevation: 7,
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: ListTile(
          onLongPress: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const App();
            }));
          },
          title: Text(
            post.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
              onPressed: () {
                Provider.of<PostsProvider>(context, listen: false)
                    .deletePost(post.id);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              )),
          leading: CircleAvatar(
              child: Image.network(
            "https://miro.medium.com/v2/1*ilC2Aqp5sZd1wi0CopD1Hw.png",
            fit: BoxFit.cover,
          )),
          subtitle: Text(
            post.body,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
