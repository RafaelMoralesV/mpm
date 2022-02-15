import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Testing extends StatefulWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  @override
  void initState() {
    super.initState();
    getThere();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

void getThere() async {
  var dio = Dio();
  const storage = FlutterSecureStorage();

  try {
    final Response res = await dio.post(
      "http://10.0.2.2:3000/auth/login",
      data: {'username': 'rafael', 'password': 'coitooo'}, // Lole
    );

    await storage.write(
      key: 'jwt',
      value: "${res.data['token_type']} ${res.data['access_token']}",
    );

    final Response res2 = await dio.get(
      "http://10.0.2.2:3000/hello",
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: await storage.read(key: 'jwt'),
        },
      ),
    );
  } on DioError catch (e) {
    if (e.response != null) {
      // print(e.response!.data);
    } else {
      // print(e.message);
    }
  }
}
