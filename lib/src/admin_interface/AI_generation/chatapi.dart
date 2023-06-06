
import 'chatgpt.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatApi {
  static const String baseUrl = 'https://openai80.p.rapidapi.com/models';

  Future<String> completeChat(String message) async {
    
  var url = Uri.https('openai80.p.rapidapi.com', '/chat/completions');
  var headers = {
    'content-type': 'application/json',
    'X-RapidAPI-Key': '45744347d9mshcb381355744a683p19c693jsnd183bf590215',
    'X-RapidAPI-Host': 'openai80.p.rapidapi.com',
  };
  var body = jsonEncode({
    'model': 'gpt-3.5-turbo',
    'messages': [
      {
        'role': 'user',
        'content': 'comment tu t\'applle',
      }
    ]
  });

  var response = await http.post(url, headers: headers, body: body);
  var responseData = response.body;

  print(responseData);
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final choices = data['choices'];
    if (choices.isNotEmpty) {
      print("reponce is ${choices[0]['message']['content']}");
      return choices[0]['message']['content'];
    }
  }

    throw Exception('Failed to send chat request: ${response.statusCode}');
  }
}
