import 'package:flutter/material.dart';

const String payloadRoute = '/payload';

class PayloadView extends StatelessWidget {
  final String? payload;

  const PayloadView({
    super.key,
    required this.payload,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Payload View',
            ),
            const SizedBox(height: 20),
            Text(
              'Payload: $payload',
            ),
          ],
        ),
      ),
    );
  }
}
