import 'dart:convert';
import 'dart:ffi';
import 'package:flutter_application_1/models/post.dart';
import 'package:http/http.dart' as http;

class HttpHandler {
  late String baseUrl;
  late String postListUrl;
  late String postAddUrl;
  late String postDeleteUrl;
  late String postAppDate;

  static final HttpHandler _singleton = HttpHandler._internal();

  factory HttpHandler() {
    return _singleton;
  }

  HttpHandler._internal() {
    baseUrl = "https://jsonplaceholder.typicode.com";
    postListUrl = baseUrl + "/posts";
    postAddUrl = baseUrl + "/posts";
    postDeleteUrl = baseUrl + "/posts/";
    postAppDate = baseUrl + "/posts";
  }

  Future<List<Post>> fetchPostsList() async {
    List<Post> posts = [];
    final respond = await http.get(Uri.parse(postListUrl));
    if (respond.statusCode == 200) {
      var data = jsonDecode(respond.body);
      for (Map<String, dynamic> d in data) {
        posts.add(Post.fromJson(d));
      }
      return posts;
    } else {
      throw Exception('${respond.statusCode}');
    }
  }

  Future<Post> addPost(Post post) async {
    print(post.toJson());
    final respond =
        await http.post(Uri.parse(postAddUrl), body: jsonEncode(post));
    if (respond.statusCode == 201) {
      print(respond.body);
      return Post(
          userId: post.userId, id: 101, title: post.title, body: post.body);
    } else {
      throw Exception('${respond.statusCode}');
    }
  }

  Future<bool> delete(int id) async {
    final responsd = await http.delete(
      Uri.parse(postDeleteUrl + id.toString()),
    );
    if (responsd.statusCode == 200) {
      return true;
    } else {
      throw Exception('${responsd.statusCode}');
    }
  }

  // Future<Post> appdate(Post post ,int id) async {
  //   print(post.toJson());
  //   final respond =
  //       await http.put(Uri.parse(postAppDate + id.toString() + post.toString()), body: jsonEncode(post));
  //   if (respond.statusCode == 200) {
  //     print(respond.body);
  //     return Post(
  //         userId: post.userId, id: 101, title: post.title, body: post.body);
  //   } else {
  //     throw Exception('${respond.statusCode}');
  //   }
  // }


}
