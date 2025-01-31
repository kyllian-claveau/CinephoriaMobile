import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReservationAPI {
  static const String baseUrl = 'https://cinephoria.ovh/api/user';

  static Future<List<dynamic>> fetchReservations() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token == null) {
      print('Token is null, user not authenticated.');
      return [];
    }

    var userData = getUserDataFromToken(token);
    print('JWT Token: $token');
    print('Fetching reservations for user ID: ${userData['id']} and email: ${userData['email']}');

    var fullUrl = '$baseUrl/${userData['id']}/reservations';
    print('Full URL: $fullUrl');

    try {
      final response = await http.post(
        Uri.parse(fullUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'token': token,
        }),
      );

      print('HTTP response code: ${response.statusCode}');
      print('HTTP response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print('Parsed JSON data: $data');
        return data;
      } else {
        print('Failed to fetch reservations: ${response.reasonPhrase}');
        throw Exception('Failed to fetch reservations: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception caught: $e');
      throw Exception('Failed to fetch reservations');
    }
  }

  static Map<String, dynamic> getUserDataFromToken(String token) {
    try {
      var parts = token.split('.');
      if (parts.length != 3) {
        throw Exception('Invalid token format');
      }
      var payload = json.decode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
      print('Decoded token payload: $payload');
      return {
        'id': payload['id'],
        'username': payload['email'],
      };
    } catch (e) {
      print('Error decoding token: $e');
      throw Exception('Failed to decode token');
    }
  }
}

class UserReservation {
  final int id;
  final int userId;
  final String userFirstname;
  final String userLastname;
  final int totalPrice;
  final String film;
  final int room;
  final String cinema;
  final String url;
  final DateTime startDate;
  final DateTime endDate;

  UserReservation({
    required this.id,
    required this.userId,
    required this.userFirstname,
    required this.userLastname,
    required this.totalPrice,
    required this.film,
    required this.room,
    required this.cinema,
    required this.url,
    required this.startDate,
    required this.endDate,
  });

  factory UserReservation.fromJson(Map<String, dynamic> json) {
    return UserReservation(
      id: json['id'],
      userId: json['user_id'],
      userFirstname: json['user_firstname'],
      userLastname: json['user_lastname'],
      totalPrice: json['total_price'],
      film: json['film'],
      room: json['room'],
      cinema: json['cinema'],
      url: json['url'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date'])
    );
  }
}