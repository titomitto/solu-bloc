import 'package:solu_bloc/tools/bloc_provider.dart';
import 'package:solu_bloc/ui/screens/other_screen.dart';

class CounterBloc extends Bloc {
  int _count = 0;
  int get count => _count;

  set count(int value) {
    _count = value;
    notifyChanges();
  }

  void decrement() {
    count -= 1;
  }

  void increment() {
    count += 1;
  }

  void viewOtherPage() {
    navigate(screen: OtherScreen());
  }

  @override
  void initState() {
    super.initState();
    // Code that gets called when the bloc is initialized
  }

  @override
  void dispose() {
    super.dispose();
    // Code that gets called when the bloc is disposed
  }

  @override
  void onPause() {
    super.onPause();
    // Code that gets called when the app is paused
  }

  @override
  void onResume() {
    super.onPause();
    // Code that gets called when the app is resumed from the background
  }

  @override
  void onInactive() {
    super.onPause();
    // Code that gets called when the app has been inactive for some time
  }
}
