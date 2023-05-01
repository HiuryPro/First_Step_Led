import 'package:http/http.dart' as http;
import 'dart:convert';

class CRUD {
  final String ip = "192.168.3.9";

  select(String query) async {
    dynamic body;
    var url = Uri.parse("http://$ip/ConexaoTEAGAMES/Select.php");
    http.Response response = await http.post(url, body: {'query': query});
    body = jsonDecode(response.body);

    return body;
  }

  insert(String query, List<String> lista) async {
    var url = Uri.parse("http://$ip/ConexaoTEAGAMES/Insert.php");
    await http.post(url, body: {'query': query, 'lista': jsonEncode(lista)});
  }

  update(String query, List<dynamic> lista) async {
    var url = Uri.parse("http://$ip/ConexaoTEAGAMES/Update.php");
    await http.post(url, body: {'query': query, 'lista': jsonEncode(lista)});
  }

  delete(String query) async {
    var url = Uri.parse("http://$ip/ConexaoTEAGAMES/Select.php");
    await http.post(url, body: {'query': query});
  }
}
