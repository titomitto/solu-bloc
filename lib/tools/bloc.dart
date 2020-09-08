part of 'bloc_provider.dart';

class Bloc {
  BuildContext context;
  StreamController<dynamic> _controller = StreamController<dynamic>.broadcast();
  Stream<dynamic> get stream => _controller.stream;
  ProgressDialog progressDialog;

  void dispose() {
    _controller.close();
  }

  void onResume() {}

  void onPause() {}

  void onInactive() {}

  void initState() {
    progressDialog = ProgressDialog(context);
  }

  void notifyChanges([callback]) {
    if (callback != null) {
      callback();
    }
    if (!_controller.isClosed) {
      _controller.sink.add(0);
    }
  }

  Future<dynamic> navigate<T extends Bloc>({@required Widget screen}) async {
    return await Navigator.of(context)
        ?.push(MaterialPageRoute(builder: (context) {
      return screen;
    }));
  }

  showToast(String message, [Color backgroundColor = null]) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        textColor: Colors.white,
        fontSize: 16.0,
        backgroundColor: backgroundColor);
  }

  pop([results]) {
    if (results == null) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pop(results);
    }
  }

  Future<Null> alert(title, body, {onOk = null, okButtonText = "OK"}) async {
    return showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Container(
              child: Text(body),
            ),
            contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
            actions: <Widget>[
              FlatButton(
                child: Text("${okButtonText ?? "OK"}"),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onOk != null) {
                    onOk();
                  }
                },
              ),
            ],
          );
        });
  }

  Future<bool> confirm(title, body,
      {cancelButtonText = "CANCEL", okButtonText = "OK"}) async {
    return (await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: SingleChildScrollView(
                  child: Text(body),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(cancelButtonText ?? "CANCEL"),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  FlatButton(
                    child: Text(okButtonText ?? "OK"),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            })) ??
        false;
  }

  void popAndNavigate<T extends Bloc>({@required Widget screen}) async {
    // Delayed here assists push the navigator to after state build
    // Otherwise an error will occur if a rebuild is underway
    if (context != null) {
      Navigator.of(context)
          ?.pushReplacement(MaterialPageRoute(builder: (context) {
        return screen;
      }));
    }
  }

  void popStackAndNavigate<T extends Bloc>({@required Widget screen}) async {
    // Delayed here assists push the navigator to after state build
    // Otherwise an error will occur if a rebuild is underway
    if (context != null) {
      Navigator.of(context)?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
          return screen;
        }),
        ModalRoute.withName('/'),
      );
    }
  }
}
