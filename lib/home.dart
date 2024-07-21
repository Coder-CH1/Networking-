import 'package:flutter/material.dart';
import 'model.dart';
import 'network.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Welcome> _welcomeFuture;
  String _errorMessage = "";
  @override
  void initState() {
    super.initState();
    _welcomeFuture = fetchData();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Networking"),
      ),
      body: Center(
        child: FutureBuilder<Welcome>(
          future: _welcomeFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("has error ${_errorMessage}");
            } else if (snapshot.hasData) {
              final welcome = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(welcome.message),
                  Text("${welcome.status}")
                ],
              );
            } else {
              return Text("Data not available");
            }
          },
        ),
      ),
    );
  }
}


