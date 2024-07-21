import 'package:dio/dio.dart';
import 'package:networking/model.dart';

Future<Welcome> fetchData() async {
  final dio = Dio();
  try {
    final response = await dio.get("https://dog.ceo/api/breeds/image/random");
    if (response.statusCode == 200) {
      return Welcome.fromJson(response.data);
    } else {
      throw Exception("failed to load data");
    }
  } catch (e) {
    throw Exception("Request error: $e");
  }
}