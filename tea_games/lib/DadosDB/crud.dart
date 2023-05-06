import 'package:http/http.dart' as http;
import 'dart:convert';

class CRUD {
  final String ip = "192.168.1.9";

  select({required String query}) async {
    dynamic body;
    var url = Uri.parse("http://$ip/ConexaoDBTEAGAMES/Select.php");
    http.Response response = await http.post(url, body: {'query': query});
    body = jsonDecode(response.body);

    return body;
  }

  insert({required String query, required List lista}) async {
    var url = Uri.parse("http://$ip/ConexaoDBTEAGAMES/Insert.php");
    await http.post(url, body: {'query': query, 'lista': jsonEncode(lista)});
  }

  update({required String query, required List lista}) async {
    var url = Uri.parse("http://$ip/ConexaoDBTEAGAMES/Update.php");
    await http.post(url, body: {'query': query, 'lista': jsonEncode(lista)});
  }

  delete({required String query}) async {
    var url = Uri.parse("http://$ip/ConexaoDBTEAGAMES/Select.php");
    await http.post(url, body: {'query': query});
  }
}
