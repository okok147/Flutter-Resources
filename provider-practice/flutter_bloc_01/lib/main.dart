import 'package:flutter/material.dart';
import 'package:flutter_bloc_01/blocs/counter_bloc.dart';
import 'package:flutter_bloc_01/pages/counter.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CounterBloc>.value(
          value: CounterBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        home: CounterPage(),
      ),
    );
  }
}
