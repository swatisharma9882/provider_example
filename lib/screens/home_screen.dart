import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/providers/counter_provider.dart';
import 'package:provider_example/providers/user_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Consumer<PostProvider>(
            builder: (context, postProvider, child) {
              // Assuming postProvider has a property 'posts' which is a List of Post objects
              final postList = postProvider.posts;
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: ListView.builder(
                  itemCount: postList.length,
                  itemBuilder: (context, index) {
                    // Assuming each post is an instance of a Post class with a 'title' property
                    final post = postList[index];
                    final title = post.title ?? 'No Title';
                    final body = post.body ?? 'No Body';
                    final id = post.id ?? 0;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(border: Border.all()),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap:(){
                                Provider.of<PostProvider>(context, listen: false).updatePost(id,title, body);
                              },
                              child: Text(
                                title,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Divider(thickness: 2),
                            Text(
                              body,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Provider.of<PostProvider>(context, listen: false)
                      .fetchPosts();
                },
                child: const Text("Fetch Posts"),
              ),
              ElevatedButton(
                onPressed: () {
                  showInputDialog(context);
                },
                child: const Text("Add Post"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showInputDialog(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController bodyController = TextEditingController();


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Platform.isIOS
            ? CupertinoAlertDialog(
                title: const Text('Enter post details'),
                content: Column(
                  children: [
                    CupertinoTextField(
                      controller: titleController,
                      placeholder: 'Title',
                    ),
                    const SizedBox(height: 10),
                    CupertinoTextField(
                      controller: bodyController,
                      placeholder: 'Body',
                    ),
                  ],
                ),
                actions: [
                  CupertinoDialogAction(
                    child: const Text('Submit'),
                    onPressed: () {
                      String firstName = titleController.text;
                      String lastName = bodyController.text;


                      // Handle the input here
                      print('First Name: $firstName');
                      print('Last Name: $lastName');

                      // Provider.of<UserProvider>(context, listen: false).addUser(firstName, lastName, int.parse(age));
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                  CupertinoDialogAction(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ],
              )
            : AlertDialog(
                title: const Text('Enter post details'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(hintText: 'Title'),
                      ),
                      TextField(
                        controller: bodyController,
                        decoration: const InputDecoration(hintText: 'Body'),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Submit'),
                    onPressed: () {
                      String title = titleController.text;
                      String body = bodyController.text;
                      // Handle the input here
                      print('First Name: $title');
                      print('Last Name: $body');

                      Provider.of<PostProvider>(context, listen: false).addUser(title, body);

                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ],
              );
      },
    );
  }
}
