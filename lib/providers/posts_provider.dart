import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/http_handler.dart';
import 'package:flutter_application_1/models/post.dart';
import 'dart:ffi';
import 'package:ffi/ffi.dart';

class PostsProvider with ChangeNotifier {
  List<Post>? posts;

  void fetchData() async {
    posts = await HttpHandler().fetchPostsList();
    notifyListeners();
  }

  Future<void> addPost(String title, String body, int userId) async {
    Post post = Post(userId: userId, id: 0, title: title, body: body);
    posts!.insert(0, await HttpHandler().addPost(post));
    notifyListeners();
  }

  Future<void> deletePost(int id) async {
    bool result = await HttpHandler().delete(id);
    if (result) {
      posts?.removeWhere((element) => element.id == id);
    }
    notifyListeners();
  }

  // Future<void> appdate(String title, String body, int userId) async {
  //   Post post = Post(userId: userId, id: 0, title: title, body: body);
  //   posts!.insert(0, await HttpHandler().appdate( post, id));
  //   notifyListeners();
  // }
}

//  void removeFromList(Movie movie) {
//     _myList.remove(movie);
//     notifyListeners();
//   }
// 

// Future<void> delete(String id) async {
//   final po = await HttpHandler().delete(postDeleteUr);
//   // notifyListeners();
// }