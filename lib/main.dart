import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_flutter_mytest/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final HttpLink httpLink = HttpLink('https://graphqlzero.almansi.me/api');

  MyApp({Key? key}) : super(key: key);
  // final HttpLink httpLink = HttpLink('https://rickandmortyapi.com/graphql');

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<GraphQLClient> cliente = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      ),
    );

    return GraphQLProvider(
      client: cliente,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}


/*
The current Dart SDK version is 3.
Because pub global activate depends on devtools any which doesn't support null safety, version solving failed.

The lower bound of "sdk: '>=2.1.0-dev <3.0.0'" must be 2.12.0 or higher to enable null safety.
For details, see https://dart.dev/null-safety
*/