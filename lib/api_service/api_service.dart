// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';

// import 'package:chatwith/api_model/user.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import 'exception.dart';

// class ApiServices {
//   Future<List<User>?> getData(BuildContext context) async {
//     const url = "https://reqres.in/api/users?page=1";
//     final response = await http.get(Uri.parse(url));

//     var responseJson;

//     try {
//       responseJson = _returnResponse(response);
//       if (response.statusCode == 200) {
//         final results = await jsonDecode(response.body);
//         Iterable list = results["data"];
//         log(list.toString());
//         return list.map((e) => User.fromJson(e)).toList();
//       } else {
//         return responseJson;
//       }
//     } on SocketException catch (e) {
//       const snackBar = SnackBar(content: Text("No Internet Connection"));
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     } on HttpException catch (e) {
//       const snackBar = SnackBar(content: Text("No Service Found"));
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     } on FormatException catch (e) {
//       const snackBar = SnackBar(content: Text("Invalid Format Data"));
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }
//   }
// }

// dynamic _returnResponse(http.Response response) {
//   switch (response.statusCode) {
//     case 200:
//       var responseJson = json.decode(response.body.toString());
//       return responseJson;
//     case 400:
//       throw BadRequestException(response.body.toString());
//     case 401:
//     case 404:
//       throw FetchDataException("404 Not Found");
//     case 403:
//       throw UnauthorisedException(response.body.toString());
//     case 500:
//     default:
//       throw FetchDataException(
//           'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:chatwith/api_model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<List<User>> getData(BuildContext context) async {
    var client = http.Client();
    try {
      var uri = 'https://reqres.in/api/users?page=1';
      var url = Uri.parse(uri);
      var response = await client.get(url);
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        Iterable list = result["data"];
        return list.map((emp) => User.fromJson(emp)).toList();
      }
    } on SocketException catch (e) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text('Please Try Again'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return [];
    } on HttpException catch (e) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('No Service Found'),
          content: const Text('Please Try Again'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return [];
    } on FormatException catch (e) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('No Format Data'),
          content: const Text('Please Try Again'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return [];
    } catch (e) {
      return [];
    }
    return [];
  }
}
