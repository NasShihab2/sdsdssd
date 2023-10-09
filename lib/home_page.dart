import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model.dart';

class TokenForm extends StatefulWidget {
  const TokenForm({super.key});

  @override
  TokenFormState createState() => TokenFormState();
}

class TokenFormState extends State<TokenForm> {
  TextEditingController tokenController = TextEditingController();
  TextEditingController fromUserIdController = TextEditingController();
  TextEditingController toUserIdController = TextEditingController();
  TextEditingController bookAppointmentIdController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  BookAppointMentErrorModel? bookAppointMentErrorModel;

  Future<void> login() async {
    var client = http.Client();
    var url = Uri.parse('https://lawsys.app/api/wallet-credit-transfer');

    var body = {
      'token': tokenController.text,
      'from_user_id': fromUserIdController.text,
      'to_user_id': toUserIdController.text,
      'bookAppointmentId': bookAppointmentIdController.text,
      'amount': amountController.text,
    };
    try {
      var response = await client.post(url, body: body);

      if (response.statusCode == 200) {
        String responseBody = response.body;
        debugPrint('Response body: $responseBody');

        final Map<String, dynamic> responseBodyMap = json.decode(response.body);

        // newUserDataModel = newUserDataModelFromJson(responseBody);
        bookAppointMentErrorModel = bookAppointMentErrorModelFromJson(responseBody);

        debugPrint(bookAppointMentErrorModel!.status.toString());
      } else if (response.statusCode == 401) {
        debugPrint('Response body: ${response.body}');
      } else {
        // Failed login
        debugPrint('Login failed');
        String responseBody = response.body;
        debugPrint('Response body: $responseBody');
      }
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: tokenController,
            decoration: const InputDecoration(labelText: 'Token'),
          ),
          TextField(
            controller: fromUserIdController,
            decoration: const InputDecoration(labelText: 'From User ID'),
          ),
          TextField(
            controller: toUserIdController,
            decoration: const InputDecoration(labelText: 'To User ID'),
          ),
          TextField(
            controller: bookAppointmentIdController,
            decoration: const InputDecoration(labelText: 'Book Appointment ID'),
          ),
          TextField(
            controller: amountController,
            decoration: const InputDecoration(labelText: 'Amount'),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Access the values entered by the user
              final token = tokenController.text;
              final fromUserId = fromUserIdController.text;
              final toUserId = toUserIdController.text;
              final bookAppointmentId = bookAppointmentIdController.text;
              final amount = amountController.text;

              // You can do something with these values here
              print('Token: $token');
              print('From User ID: $fromUserId');
              print('To User ID: $toUserId');
              print('Book Appointment ID: $bookAppointmentId');
              print('Amount: $amount');
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    tokenController.dispose();
    fromUserIdController.dispose();
    toUserIdController.dispose();
    bookAppointmentIdController.dispose();
    amountController.dispose();
    super.dispose();
  }
}
