import 'dart:convert';
import 'dart:io';

class FakeHttpClient {
  Future<String> getResponseBody() async {
    await Future.delayed(Duration(milliseconds: 500));
    //throw SocketException('No Internet');
    // throw HttpException('404');
    //
    //throw FormatException();
    return '{"userId":1,"id":1,"title":"nice title","body":"nice body"}';
  }
}

class PostService {
  final httpClient = FakeHttpClient();
  Future<Post> getOnePost() async {
    try {
      final responsebody = await httpClient.getResponseBody();
      return Post.fromJson(json.decode(responsebody));
    } on SocketException {
      throw Failure('No Internet connection');
    } on HttpException {
      throw Failure('Post Not Found');
    } on FormatException {
      throw Failure('FormatException');
    } on Exception {
      throw Failure("Something was wrong");
    }
  }
}

class Failure {
  final String message;
  Failure(this.message);
  @override
  String toString() => message;
}

class Post {
  int userId;
  int id;
  String title;
  String body;
  Post({this.userId, this.id, this.title, this.body});

  Post.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
