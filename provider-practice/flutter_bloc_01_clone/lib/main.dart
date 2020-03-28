import 'package:flutter/material.dart';
import 'package:flutter_bloc_01_clone/blocs/counter_bloc.dart';
import 'package:flutter_bloc_01_clone/pages/counter.dart';
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
        debugShowMaterialGrid: false,
        home: CounterPage(),
      ),
    );
  }
}
