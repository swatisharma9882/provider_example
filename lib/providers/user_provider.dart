import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:provider_example/models/user.dart';
import 'package:provider_example/services/api_service.dart';

class PostProvider extends ChangeNotifier {
  ApiService apiService = ApiService();

  List<Posts> _posts = [];
  String? _errorMessage;
  bool _isLoading = false;
  late int
      _lastId; // Assuming you initialize this correctly based on existing users

  List<Posts> get posts => _posts;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> fetchPosts() async {
    log("fetchUsers");
    _isLoading = true;

    try {
      log("try");
      _posts = await apiService.fetchUsers();
      log('_users $_posts');
      _errorMessage = null;

      // if (_posts.isNotEmpty) {
      //   _lastId = _posts.map((user) => user.id).reduce((a, b) => a > b ? a : b);
      //   log('_lastId $_lastId');
      // }
    } catch (e) {
      _errorMessage = e.toString();
      log("error $_errorMessage");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addUser(String firstName, String lastName) async {
    log("addUser");
    _isLoading = true;
    notifyListeners(); // Notify loading state

    try {
      Posts newUser = Posts( title: firstName, body: lastName, userId: 1);
      Posts createdUser = await apiService.addPost(newUser);

      log("New user added: ${createdUser.id}, ${createdUser.title}");
      _posts.add(createdUser); // Update the user list
      log('Updated user list: ${_posts.map((user) => user.id).toList()}');
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      log("Error: $_errorMessage");
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify changes
    }
  }


  Future<void> updatePost(int id,String title, String body) async {
    log("updatePost");
    _isLoading = true;
    notifyListeners(); // Notify loading state

    try {
      print('idtitle: $id,$title,$body');
      // Creating a post object to update
      Posts postToUpdate = Posts(id: id, title: 'Updated Title', body: 'Updated Body', userId: 1);
      print('postToUpdate: ${postToUpdate.id},${postToUpdate.title},${postToUpdate.body}');
      // Calling the updatePost method
      Posts updatedPost = await apiService.updatePost(postToUpdate);

      // Logging the updated post
      print('Updated Post: ${updatedPost.title}, ${updatedPost.body}');
    } catch (e) {
      print('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify changes
    }
  }
}
