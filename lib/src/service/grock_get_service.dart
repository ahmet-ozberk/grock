// import 'dart:developer';
// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// import '../grock_extension.dart';

// class GrockGetService<T>{
//     static Options getToken() {
//     //final token = GetStorage().read("token");
//     return Options(
//       // headers: {"Authorization": "Bearer $token"},
//       contentType: "text/xml",
//     );
//   }
//     Future<T?> getMethod({
//     required String url,
//     bool token = true,
//     Function(Map<String, dynamic> type)? fromJson,
//   }) async {
//     loading();
//     Response? response;
//     final dio = Dio();
//     try {
//       response =
//           await dio.get("${baseUrl}${url}", options: token ? getToken() : null);
//       log("${response.data}", name: "$T");
//       if (response.statusCode == HttpStatus.ok) {
//         Grock.back();
//         return fromJson == null ? response.data : fromJson(response.data);
//       } else {
//         Grock.back();
//         log(response.statusCode.toString(), name: "GET ERROR");
//         return null;
//       }
//     } catch (error) {
//       Grock.back();
//       log(error.toString(), name: "GET ERROR");
//       Grock.toast(
//           text: "Servis isteğinde sorun oluştu, tekrar deneyin.",
//           backgroundColor: Colors.black.withOpacity(0.6),
//           textColor: Colors.white,
//           duration: const Duration(seconds: 2));
//     }
//   }
// }