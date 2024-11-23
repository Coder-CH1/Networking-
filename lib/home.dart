import 'package:flutter/material.dart';
import 'Network/model.dart';
import 'Network/network.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Welcome> _welcomeFuture;
  final String _errorMessage = "";
  @override
  void initState() {
    super.initState();
    _welcomeFuture = fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Networking"),
      ),
      body: Center(
        child: FutureBuilder<Welcome>(
          future: _welcomeFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("has error $_errorMessage");
            } else if (snapshot.hasData) {
              final welcome = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(welcome.message),
                  Text(welcome.status)
                ],
              );
            } else {
              return const Text("Data not available");
            }
          },
        ),
      ),
    );
  }
}


