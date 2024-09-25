import 'dart:convert';
import 'dart:developer';

import 'package:provider_example/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:provider_example/utils/api_constants.dart';

class ApiService {
  Future<Posts> addPost(Posts post) async {
    final response = await http.post(
      Uri.parse(ApiConstant.baseUrl + ApiConstant.getPosts),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(post.toJson()),
    );

    log('statusCode: ${response.statusCode}, response: ${response.body}');

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      log('UserData: $data');
      return Posts.fromJson(data);
    } else {
      throw Exception('Failed to add user: ${response.reasonPhrase}');
    }
  }

  Future<Posts> updatePost(Posts post) async {
    final response = await http.put(
      Uri.parse(ApiConstant.baseUrl + ApiConstant.getPosts+post.id.toString()),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(post.toJson()),
    );

    log('statusCode: ${response.statusCode}, response: ${response.body}');

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      log('UserData: $data');
      return Posts.fromJson(data);
    } else {
      throw Exception('Failed to add user: ${response.reasonPhrase}');
    }
  }

  Future<List<Posts>> fetchUsers() async {
    final response = await http.get(
      Uri.parse(ApiConstant.baseUrl + ApiConstant.getPosts),
      headers: {'Content-Type': 'application/json'},
    );

    log('statusCode ${response.statusCode}, ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Fetched Users: $data');
      return List.from(data).map((e) => Posts.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch users');
    }
  }
}
