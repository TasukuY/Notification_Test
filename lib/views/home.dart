import 'package:flutter/material.dart';
import 'package:notification_test/services/notification_service.dart';
import 'package:notification_test/views/payload_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Local Notifications Test',
            ),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: () => NotificationService.showSimpleNotification(
                title: 'Simple Notification',
                body: 'This is a simple notification!!!!',
                payload: payloadRoute,
              ),
              icon: const Icon(Icons.notifications),
              label: const Text('Simple Notification'),
            ),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: () {
                NotificationService.showScheduledNotification(
                  title: 'Scheduled Notification',
                  body: 'This is a scheduled notification!!!!',
                  payload: payloadRoute,
                  scheduledDate:
                      DateTime.now().add(const Duration(seconds: 10)),
                );
                const snackBar = SnackBar(
                  content: Text('Simple Notification Sent '),
                  backgroundColor: Colors.blue,
                );
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(snackBar);
              },
              icon: const Icon(Icons.notifications_active),
              label: const Text('Scheduled Notification'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Remove Notifications',
        child: const Icon(Icons.delete),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    NotificationService.init();
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationService.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) {
    if (payload == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PayloadView(
          payload: payload,
        ),
      ),
    );
  }
}
