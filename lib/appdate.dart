import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/posts_provider.dart';
import 'package:provider/provider.dart';
import 'package:ffi/ffi.dart';
import 'dart:ffi';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    GlobalKey<FormState> formstate = new GlobalKey<FormState>();
    var title;
    var body;
    var userId;

    save() async {
      var formdata = formstate.currentState;
      if (formdata!.validate()) {
        formdata.save();
        await Provider.of<PostsProvider>(context, listen: false)
            .addPost(title, body, userId);
      } else {
        print('Not valid');
      }
    }

    return Scaffold(
        appBar: AppBar(title: const Text('Appdate this post')),
        body: Builder(builder: (BuildContext context) {
          return Form(
              key: formstate,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        icon: Icon(Icons.title),
                        labelText: 'Title',
                        border: OutlineInputBorder()),
                    onSaved: (text) {
                      title = text;
                    },
                    validator: (t) {
                      if (t!.isEmpty) {
                        return "Title is required.";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        icon: Icon(Icons.text_fields),
                        labelText: 'Body',
                        border: OutlineInputBorder()),
                    maxLines: 5,
                    onSaved: (text) {
                      body = text;
                    },
                    validator: (t) {
                      if (t!.isEmpty) {
                        return "Body is required.";
                      } else {
                        null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    // ignore: avoid_types_as_parameter_names
                    decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'User Id',
                        border: OutlineInputBorder()),
                    onSaved: (text) {
                      userId = int.parse(text ?? '0');
                    },
                    keyboardType: TextInputType.number,
                    validator: (t) {
                      if (t!.isEmpty) {
                        return "User Id is rquired.";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                      ),
                      onPressed: () async {
                        await save();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ));
          // TextButton(child: const Text('BUTTON'), onPressed: () {});
        }));
  }
}
