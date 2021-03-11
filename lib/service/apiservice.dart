import 'package:http/http.dart' as http;

class ApiService {
  static ApiService _apiService;

  factory ApiService() {
    if (_apiService == null) {
      _apiService = ApiService._();
    }
    return _apiService;
  }

  ApiService._();

  Future<http.Response> fetchPhotos() async {
    final url = Uri.https('jsonplaceholder.typicode.com', '/photos');
    return await http.get(url);
  }

  Future<http.Response> fetchPhotosPost() async {
    final url =
        Uri.https('jsonplaceholder.typicode.com', '/photos', {'p': '123'});
    return await http.post(url,
        headers: {'token': '123456'}, body: {'no': 2, 'comment': 'test'});
  }

  Future<http.Response> fetchPhoto(int id) async {
    final url = Uri.https('jsonplaceholder.typicode.com', '/photos/$id');
    return await http.get(url);
  }
}
