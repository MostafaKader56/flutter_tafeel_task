// support.dart
class Support {
  final String url;
  final String text;

  Support({required this.url, required this.text});

  factory Support.fromJson(Map<String, dynamic> json) =>
      Support(url: json['url'] as String, text: json['text'] as String);

  Map<String, dynamic> toJson() => {'url': url, 'text': text};
}
