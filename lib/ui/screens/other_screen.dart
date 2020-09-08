import 'package:flutter/material.dart';
import 'package:solu_bloc/bloc/counter_bloc.dart';
import 'package:solu_bloc/bloc/other_bloc.dart';
import 'package:solu_bloc/data/models/todo.dart';
import 'package:solu_bloc/helpers/sample_manager.dart';
import 'package:solu_bloc/tools/bloc_provider.dart';
import 'package:solu_bloc/ui/widgets/circular_material_spinner.dart';

class OtherScreen extends StatelessWidget {
  OtherBloc bloc = OtherBloc();
  OtherScreen();
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
                title: Text("Other Screen"),
              ),
              body: StreamBuilder(
                  stream: sampleManager.stream,
                  builder: (context, snapshot) {
                    print("Rebuilt ${sampleManager.todos}");
                    return CircularMaterialSpinner(
                      loading: sampleManager.loadingTodos,
                      child: ListView.builder(
                          itemCount: sampleManager.todos.length,
                          itemBuilder: (context, index) {
                            Todo todo = sampleManager.todos[index];
                            return Container(
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    child: Text("${todo.title}"),
                                  )),
                                  Container(
                                    child: Icon(Icons.done_all),
                                  )
                                ],
                              ),
                            );
                          }),
                    );
                  }), // This trailing comma makes auto-formatting nicer for build methods.
            );
          }),
    );
  }
}
