import 'package:solu_bloc/helpers/sample_manager.dart';
import 'package:solu_bloc/tools/bloc_provider.dart';

class OtherBloc extends Bloc {
  @override
  void initState() {
    super.initState();
    sampleManager.loadTodos();
  }
}
