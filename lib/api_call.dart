import "dart:convert";

import "package:http/http.dart" as http;

Future getCatFact() async {
  var url = Uri.parse('https://catfact.ninja/fact');

  var response = await http.get(url);
  if(response.statusCode == 200) {
    return jsonDecode(response.body)["fact"];
  }

  return null;
}

