import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:status_alert/status_alert.dart';

const String _formPath = 'https://technicalsand.com/contact-us/#contact-form-7';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  _ContactData _data = new _ContactData();

  @override
  Widget build(BuildContext context) {
    if(_formKey.currentState != null) {
      _formKey.currentState.reset();
    }
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      //appBar: buildAppBar(),
      body: Builder(
        builder: (BuildContext context) {
          return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Padding(padding: EdgeInsets.only(top: 10.0)),
                  new Text(
                    'Contact us',
                    style: new TextStyle(
                        color: hexToColor("#F2A03D"), fontSize: 25.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: buildTextFormFields(context, screenSize),
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(color: Colors.grey.shade100));
        },
      ),
    );
  }

  List<Widget> buildTextFormFields(BuildContext context1, Size screenSize) {
    List<Widget> fields = [
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
          hintText: 'you@example.com',
          labelText: 'E-mail Address',
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(50.0),
            borderSide: new BorderSide(),
          ),
        ),

        onChanged: (String value) => (this._data.email = value),
      ),
      SizedBox(height: 24,),
      new TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter your name';
          }
          return null;
        },
        decoration: new InputDecoration(
          hintText: 'Enter your Name',
          labelText: 'Name',
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(50.0),
            borderSide: new BorderSide(),
          ),
        ),
        onChanged: (String value) => (this._data.name = value),
      ),
      SizedBox(height: 24,),
      new TextFormField(
        maxLines: null,
        keyboardType: TextInputType.multiline,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter comments';
          }
          return null;
        },
        decoration: new InputDecoration(
          hintText: 'Enter your Comment',
          labelText: 'Comment',
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(50.0),
            borderSide: new BorderSide(),
          ),
        ),
        onChanged: (String value) => (this._data.comment = value),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: new Container(
          width: screenSize.width,
          child: new RaisedButton(
            child: new Text(
              'Submit',
              style: new TextStyle(color: Colors.white),
            ),
            onPressed: () => submit(context1),
            color: Colors.blue,
          ),
          margin: new EdgeInsets.only(top: 20.0),
        ),
      )
    ];
    return fields;
  }

  Future<void> submit(BuildContext context1) async {
    print(
        'Name: ${this._data.name}, Email: ${this._data.email}, Comment: ${this._data.comment}');

    if (_formKey.currentState.validate()) {
      // If the form is valid, display a Snackbar.
      Scaffold.of(context1)
          .showSnackBar(SnackBar(content: Text('Processing Data')));

      var client = http.Client();
      try {
        var response = await client.post(_formPath, body: {
          'g7-name': '${_data.name}',
          'g7-email': '${_data.email}',
          'g7-comment': '${_data.comment}',
//          '_wp_http_referer': '/contact-us/',
          'contact-form-id': '7',
          'action': 'grunion-contact-form',
          'contact-form-hash': '3dec796194dbd8a17bf78b7372750e4a7d845e8d'
        });
        print('Response status: ${response.body}');
        //if (response.statusCode == 200) {
        if (true) {
          print('all well');
          StatusAlert.show(
            context,
            //backgroundColor: Colors.green.shade200,
            duration: Duration(seconds: 2),
            title: 'Thank You',
            subtitle: 'Successfully submitted',
            configuration: IconConfiguration(icon: Icons.done),
          );
          _formKey.currentState.reset();
        } else {
          print('error');
          StatusAlert.show(
            context,
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
