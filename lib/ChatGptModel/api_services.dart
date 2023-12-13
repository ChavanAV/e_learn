import 'dart:convert';

import 'package:http/http.dart' as http;

String apiKey = "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";

class ApiServices {
  static String baseUrl = "https://api.openai.com/v1/completions";
  static Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };

  static sendMsg(String? msg) async {
    var res = await http.post(
      Uri.parse(baseUrl),
      headers: header,
      body: jsonEncode({
        "model": "text-davinci-003",
        "prompt": "$msg",
        "temperature": 0,
        "max_tokens": 1000,
        "top_p": 1,
        "frequency_penalty": 0.0,
        "presence_penalty": 0.0,
        "stop": ["Human:", "AI:"]
      }),
    );

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body.toString());
      var mesg = data['choices'][0]['text'];
      return mesg;
    } else {
      var mesg = 'Error: ${res.statusCode}';
      return mesg;
    }
  }
}
