import 'package:flutter/material.dart';
import 'package:solu_bloc/bloc/counter_bloc.dart';
import 'package:solu_bloc/tools/bloc_provider.dart';

class CounterScreen extends StatelessWidget {
  CounterBloc bloc = CounterBloc();
  CounterScreen({this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    bloc.context = context;
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            return Scaffold(
              appBar: AppBar(
                // Here we take the value from the MyHomePage object that was created by
                // the App.build method, and use it to set our appbar title.
                title: Text(title),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'You have pushed the button this many times:',
                    ),
                    Text(
                      '${bloc.count}',
                      style: Theme.of(context).textTheme.display1,
                    ),
                    MaterialButton(
                      child: Text("VIEW OTHER PAGE"),
                      onPressed: bloc.viewOtherPage,
                    )
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: bloc.increment,
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ), // This trailing comma makes auto-formatting nicer for build methods.
            );
          }),
    );
  }
}
