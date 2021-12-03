import 'dart:convert';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:chatbot/model.dart';
import 'package:chatbot/sample.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controller;
  Welcome? response;

//Initializing the container
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  //testing dio
  Welcome getHttp() {
    try {
      var response = jsonSample;
      // await Dio().get('https://demosarda.herokuapp.com/test/api/$query');

      return Welcome.fromJson(jsonDecode(response));
    } catch (e) {
      throw Exception('Something went wrong😓');
    }
  }

//Disposing the controller after use.
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤖-Bot'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          response != null
              ? Padding(
                  padding: const EdgeInsets.only(
                      right: 32.0, left: 8.0, bottom: 8.0),
                  child: ListTile(
                    tileColor: Colors.indigo[100],
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    title: Text(
                      response!.reply,
                      style: theme.bodyText1!.copyWith(fontSize: 18),
                    ),
                    subtitle: GestureDetector(
                      onTap: () async {
                        await launch(
                          response!.link,
                        );
                      },
                      child: Text(
                        response!.link,
                        style: theme.bodyText2!.copyWith(
                            fontSize: 18,
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      fillColor: Color(0xffB6C0E7),
                      filled: true,
                      hintStyle: TextStyle(fontSize: 18.0),
                      hintText: 'Say something..',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40.0),
                        ),
                        borderSide: BorderSide(
                          color: Color(0xff2B4DC3),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      response = getHttp();
                    });
                  },
                  child: const Icon(Icons.send_rounded),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
