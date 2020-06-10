import 'package:drwhatson/logic/models/quiz.dart';
import 'package:drwhatson/logic/models/topic.dart';
import 'package:drwhatson/services/service_locator.dart';
import 'package:drwhatson/services/topics/topic_service.dart';
import 'package:expressions/expressions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class TopicsViewModel extends ChangeNotifier {
  final TopicService _service = serviceLocator<TopicService>();
  List<Topic> _topics = [];
  Quiz _activeQuiz;

  void loadData(String locale) async {
    await _loadTopics(locale);
    notifyListeners();
  }

  Future<List<Topic>> getTopics(String locale) async {
    return await _service.getAllTopics(locale);
  }

  List<Topic> get topics {
    return _topics;
  }

  Future<void> _loadTopics(String locale) async {
    _topics = await _service.getAllTopics(locale);
  }

  Quiz get activeQuiz {
    return _activeQuiz;
  }

  set activeQuiz(Quiz quiz) {
    _activeQuiz = quiz;
    notifyListeners();
  }

  Future<Quiz> getQuiz(String id, String locale) async {
    Quiz q = await _service.getQuiz(id, locale);
    return q;
  }

  int getAnswerPoints(Answer e) {
    if (e.formula == null || e.formula.isEmpty) {
      return e.points;
    } else {
      Expression expression = Expression.parse(e.formula);
      var ctx;
      if (e.value.contains('.')) {
        ctx = {"x": int.parse(e.value.substring(0, e.value.indexOf(".")))};
      } else {
        ctx = {"x": int.parse(e.value)};
      }

      final evaluator = const ExpressionEvaluator();
      var r = evaluator.eval(expression, ctx);
      return r;
    }
  }

  String getResult(int totalPoints) {
    for (final result in activeQuiz.results) {
      Expression expression = Expression.parse(result.formula);
      var ctx = {"x": totalPoints};
      final evaluator = const ExpressionEvaluator();
      var r = evaluator.eval(expression, ctx);
      if (r) return result.result;
    }
    return "";
  }
}
