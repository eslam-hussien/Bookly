import 'dart:convert';

import 'package:bookly_app/models/bookly_model.dart';
import 'package:http/http.dart' as http;

class BooklyService {
  Future<BooklyModel> getApi() async {
    Uri url = Uri.parse(
        'https://run.mocky.io/v3/3a1ec9ff-6a95-43cf-8be7-f5daa2122a34');
    var response = await http.get(url);

    Map<String, dynamic> data = jsonDecode(response.body);

    BooklyModel bookly = BooklyModel(
      date: data['date'],
      interest: data['interest'],
      address: data['address'],
      title: data['title'],
      trainerInfo: data['trainerInfo'],
      occasionDetail: data['occasionDetail'],
      trainerName: data['trainerName'],
      img: List<String>.from(data['img']),
      trainerImg: data['trainerImg'],
      reservationTypes: data['reservTypes'],
      latitude: data['latitude'],
      longitude: data['longitude'],
    );

    return bookly;
  }
}
