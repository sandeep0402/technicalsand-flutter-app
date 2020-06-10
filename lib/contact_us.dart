import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:status_alert/status_alert.dart';

//https://medium.com/@anilcan/forms-in-flutter-6e1364eafdb5
//https://pub.dev/packages/angel_validate#-installing-tab-
class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  _ContactData _data = new _ContactData();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: buildTextFormFields(screenSize),
        ),
      ),
    );
  }

  List<Widget>  buildTextFormFields(Size screenSize) {
    List<Widget> fields =  [
      TextFormField(
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value.isEmpty || !isValidEmail(value)) {
            return 'Please Email Address';
          }
          return null;
        },
        // Use email input type for emails.
        decoration: new InputDecoration(
            hintText: 'you@example.com', labelText: 'E-mail Address'),
        onSaved: (String value) => (this._data.email = value),
      ),
      new TextFormField(
        validator: (value) {
          if (value.isEmpty ) {
            return 'Please enter your name';
          }
          return null;
        },
        decoration:
            new InputDecoration(hintText: 'Enter your Name', labelText: 'Name'),
        onSaved: (String value) => (this._data.name = value),
      ),
      new TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter comments';
          }
          return null;
        },
        decoration: new InputDecoration(
            hintText: 'Enter your Comment', labelText: 'Comment'),
        onSaved: (String value) => (this._data.comment = value),
      ),
      buildButtons(screenSize),
    ];
    return fields;
  }

  Widget buildButtons(Size screenSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: new Container(
        width: screenSize.width,
        child: new RaisedButton(
          child: new Text(
            'Submit',
            style: new TextStyle(color: Colors.white),
          ),
          onPressed: this.submit,
          color: Colors.blue,
        ),
        margin: new EdgeInsets.only(top: 20.0),
      ),
    );
  }

  Future<void> submit() async {
//    // First validate form.
//    if (this._formKey.currentState.validate()) {
//      _formKey.currentState.save(); // Save our form now.
//
//      print('Printing the login data.');
//      print('Name: ${_data.name}');
//      print('Email: ${_data.email}');
//      print('Comment: ${_data.comment}');
//    }
    if (_formKey.currentState.validate()) {
      // If the form is valid, display a Snackbar.
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));

      var client = http.Client();
      try {
        var response =
        await client.post('https://example.com/whatsit/create', body: {
          'g7-name': '${_data.name}',
          'g7-email': '${_data.email}',
          'g7-comment': '${_data.comment}',
        });
        print('Response status: ${response.statusCode}');
        if (response.statusCode == 200) {
          print('all well');
          StatusAlert.show(
            context,
            //backgroundColor: Colors.green.shade200,
            duration: Duration(seconds: 2),
            title: 'Thank You',
            subtitle: 'Successfully submitted',
            configuration: IconConfiguration(icon: Icons.done),
          );
        } else {
          print('error');
          StatusAlert.show(
            context,
            //backgroundColor: Colors.red.shade200,
            duration: Duration(seconds: 2),
            title: 'Retry',
            subtitle: 'Some error occurred',
            configuration: IconConfiguration(icon: Icons.clear),
          );
        }
      } finally {
        client.close();
      }
    }
  }
  bool isValidEmail(value) {
    return RegExp(
        r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$")
        .hasMatch(value);
  }
}

class _ContactData {
  String email = '';
  String name = '';
  String comment = '';
}
