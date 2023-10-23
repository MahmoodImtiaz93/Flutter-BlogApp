import 'package:blogapp/model/post_model.dart';
import 'package:blogapp/services/comment_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/comment_model.dart';

class CommentProvider with ChangeNotifier {
  List<Comments> commentModel = [];
  List<Commentss> commentssModel = [];
  Commentss commentss = Commentss();
  String _message = '';
  String get message => _message;
  int? id;

  void createComment(int id, Commentss comment, BuildContext context) {
    CommentServices.createComment(
      id,
      comment,
      context,
    );
    commentssModel.add(comment);
    notifyListeners();
  }

  void updateComment(int id, Commentss comment, BuildContext context) {
    print("Comment provider+ $id");
    commentssModel.add(comment);
    CommentServices.updateComment(
      id,
      comment,
      context,
    );
    notifyListeners();
  }

  void deleteComment(int id, BuildContext context) {
    int indexOfNote = commentModel.indexWhere((element) => element.id == id);
    if (indexOfNote != -1) {
      commentModel.removeAt(indexOfNote);
      notifyListeners();
    }
    CommentServices.deleteComment(
      id,
      context,
    );
    notifyListeners();
  }

  getAllComments(id, BuildContext context) async {
    commentModel = await CommentServices.getAllComments(id, context);
    notifyListeners();
    print("getAllComments/provider");
  }

  Future<String> savedUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('id');
    return id.toString();
  }
}
