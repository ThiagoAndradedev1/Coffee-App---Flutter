import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Scaffold(
              backgroundColor: Colors.brown[100],
              appBar: AppBar(
                title: Text(
                  'Settings',
                  style: GoogleFonts.comfortaa(
                    textStyle: TextStyle(
                      letterSpacing: .5,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                backgroundColor: Colors.brown[800],
                elevation: 0.0,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Text('Update your coffee choice',
                            style: GoogleFonts.comfortaa(
                              textStyle: TextStyle(
                                letterSpacing: .5,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        const SizedBox(height: 20.0),
                        Center(
                          child: CircleAvatar(
                            radius: 40.0,
                            backgroundImage: AssetImage('assets/user_img.png'),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          'NAME',
                          style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 2.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          initialValue: userData.name,
                          decoration: textInputDecoration,
                          validator: (val) =>
                              val.isEmpty ? 'Please enter a name' : null,
                          onChanged: (val) =>
                              setState(() => _currentName = val),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          'SUGAR',
                          style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 2.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        DropdownButtonFormField(
                          decoration: textInputDecoration,
                          value: _currentSugars ?? userData.sugars,
                          items: sugars.map((sugar) {
                            return DropdownMenuItem(
                              value: sugar,
                              child: Text('$sugar sugars'),
                            );
                          }).toList(),
                          onChanged: (val) =>
                              setState(() => _currentSugars = val),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          'STRENGTH',
                          style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 2.0,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Slider(
                          value: (_currentStrength ?? userData.strength)
                              .toDouble(),
                          activeColor: Colors
                              .brown[_currentStrength ?? userData.strength],
                          inactiveColor: Colors
                              .brown[_currentStrength ?? userData.strength],
                          min: 100,
                          max: 900,
                          divisions: 8,
                          onChanged: (val) =>
                              setState(() => _currentStrength = val.round()),
                        ),
                        const SizedBox(height: 20),
                        Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        Text(
                          userData.email,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        RaisedButton(
                            color: Colors.grey[800],
                            child: Text(
                              'Update',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                await DatabaseService(uid: user.uid)
                                    .updateUserData(
                                        _currentSugars ?? userData.sugars,
                                        _currentName ?? userData.name,
                                        _currentStrength ?? userData.strength,
                                        userData.email);
                                Navigator.pop(context);
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
