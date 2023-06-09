import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

late String stringResponse;
late Map mapResponse;
late Map dataResponse;
late List listResponse;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if (response.statusCode == 200) {
      setState(() {
        //stringResponse =response.body;
        mapResponse = json.decode(response.body);
        listResponse = mapResponse['data'];
      });
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView_demo"),
        backgroundColor: Color.fromARGB(255, 144, 190, 180),
      ),
      body: ListView.builder(itemBuilder: (context,index){
        return Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(listResponse[index]['avatar']),
               ), 
               Text(listResponse[index]['id'].toString()),
                Text(listResponse[index]['email'].toString()),
                 Text(listResponse[index]['first_name'].toString()),
                  Text(listResponse[index]['last_name'].toString()),
                  
            ],
          ),
        );
      },
      itemCount:listResponse == null? 0 : listResponse.length ,)
    );
  }
}
