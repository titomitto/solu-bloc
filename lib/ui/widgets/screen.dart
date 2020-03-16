import 'package:flutter/material.dart';
import 'package:solu_bloc/tools/bloc_provider.dart';

abstract class Screen<T extends Bloc> extends StatelessWidget {
  T bloc;
  Screen({Key key}) : super(key: key);
  @protected
  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<T>(context);
  }
}
