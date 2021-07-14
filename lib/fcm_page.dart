import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/material.dart';

class FcmPage extends StatefulWidget {
  const FcmPage({Key? key}) : super(key: key);

  @override
  _FcmPageState createState() => _FcmPageState();
}

class _FcmPageState extends State<FcmPage> {
  var token = 'ボタンをタップして、トークンを取得してください';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FcmPage'),
      ),
      body: FCMNotificationListener(
        onNotification: (RemoteMessage notification, _) async {
          await dialog();
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final fcmToken = await FCMConfig.messaging.getToken();
                  setState(() {
                    token = fcmToken!;
                  });
                },
                child: Text('トークンを取得'),
              ),
              SizedBox(height: 30),
              SelectableText(token),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> dialog() {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("通知"),
          content: Text("通知がきました"),
          actions: <Widget>[
            // ボタン領域
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("OK"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
