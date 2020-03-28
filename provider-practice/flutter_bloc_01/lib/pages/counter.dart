import 'package:flutter/material.dart';
import 'package:flutter_bloc_01/blocs/counter_bloc.dart';
import 'package:flutter_bloc_01/widgets/decrement.dart';
import 'package:flutter_bloc_01/widgets/increment.dart';
import 'package:provider/provider.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBloc counterBloc = Provider.of<CounterBloc>(context);

    return Scaffold(
      body: new Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,24),
                child: Text(
                  counterBloc.counter.toString(),
                  style: TextStyle(fontSize: 77.0),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 24, 0),
                child: IncrementButton(),
              ),
              DecrementButton(),
            ],
          ),
        ),
      ),
    );
  }
}
