import 'package:flutter/material.dart';
import 'package:flutter_bloc_01/blocs/counter_bloc.dart';
import 'package:provider/provider.dart';

class DecrementButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final CounterBloc counterBloc = Provider.of<CounterBloc>(context);

    return new FlatButton.icon(
      onPressed: () => counterBloc.decrement(),
      icon: Icon(Icons.remove),
      label: Text("Remove"),
    );
  }
}
