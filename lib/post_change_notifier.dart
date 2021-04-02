import 'package:dartz/dartz.dart';
import 'package:demo_error_handling/post_service.dart';
import 'package:flutter/foundation.dart';

enum NotifierState { initial, loading, loaded }

class PostChangeNotifier extends ChangeNotifier {
  final _postService = PostService();

  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;
  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  Either<Failure, Post> _post;
  Either<Failure, Post> get post => _post;
  void _setPost(Either<Failure, Post> post) {
    _post = post;
    notifyListeners();
  }

  void getOnePost() async {
    _setState(NotifierState.loading);

    try {
      final post = await _postService.getOnePost();
      _setPost(Right(post));
      Future.delayed(Duration(milliseconds: 10000), () {
        post.body = "Helo World";
        _setPost(Right(post));
      });
    } on Failure catch (f) {
      _setPost(Left(f));
    }
    _setState(NotifierState.loaded);
  }
}
