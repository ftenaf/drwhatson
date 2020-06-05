class Quiz {
  String id;
  String title;
  String description;
  String video;
  String topic;
  int retry;
  final String version;
  List<Result> results;
  List<Question> questions;

  Quiz(
      {this.id,
      this.title,
      this.questions,
      this.results,
      this.video,
      this.description,
      this.version,
      this.topic,
      this.retry});

  factory Quiz.fromMap(Map data) {
    return Quiz(
        id: data['id'] ?? '',
        title: data['title'] ?? '',
        topic: data['topic'] ?? '',
        retry: data['retry'] ?? 0,
        description: data['description'] ?? '',
        video: data['video'] ?? '',
        results: (data['results'] as List ?? []).map((e) => Result.fromMap(e)).toList(),
        questions: (data['questions'] as List ?? []).map((v) => Question.fromMap(v)).toList());
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'questions': questions,
      'results': results,
      'video': video,
      'description': description,
      'version': version,
      'topic': topic,
      'retry': retry
    };
  }
}

class Result {
  final String formula;
  final String result;

  Result({this.formula, this.result});

  factory Result.fromMap(Map data) {
    return Result(formula: data['formula'] ?? '', result: data['result'] ?? '');
  }
}

class Question {
  String id;
  String question;
  String img;
  String video;
  String topic;
  List<Answer> answers;

  Question({this.id, this.answers, this.question, this.img, this.video, this.topic});

  Question.fromMap(Map data) {
    id = data['id'] ?? '';
    question = data['question'] ?? '';
    topic = data['topic'] ?? '';
    img = data['img'] ?? '';
    video = data['video'] ?? '';
    answers = (data['answers'] as List ?? []).map((v) => Answer.fromMap(v)).toList();
  }
}

class Answer {
  String id;
  String value;
  String detail;
  String formula;
  bool correct;
  String type;
  int min;
  int max;
  int points;

  Answer({this.id, this.correct, this.value, this.detail, this.points});

  Answer.fromMap(Map data) {
    id = data['id'];
    value = data['value'];
    detail = data['detail'] ?? '';
    correct = data['correct'];
    points = data['points'];
    formula = data['formula'];
    type = data['type'];
    min = data['min'];
    max = data['max'];
  }
}
