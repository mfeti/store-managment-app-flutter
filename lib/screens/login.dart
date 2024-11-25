import 'package:flutter/material.dart';
import 'package:store_management/models/auth.dart';
// import 'package:store_management/models/firestore.dart';
import 'package:store_management/screens/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  bool _forgot = false;
  String _username = '';
  String _password = '';
  int _attempts = 0;
  final _success = 'Forgot Password';
  final _auth = Auth();
  bool _obscureText = true;
  dynamic _result;

  void _updateUsername(String username) {
    setState(() {
      _username = username;
    });
  }

  void _updatePassword(String password) {
    setState(() {
      _password = password;
    });
  }

  _showSnackBar(context, msg) {
    SnackBar snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _login() async {
    if (_username.isEmpty) {
      _showSnackBar(context, 'Enter User Name');
    } else if (_password.isEmpty) {
      _showSnackBar(context, 'Enter password');
    } else if (_username == 'Suley' && _password == 'sule') {
      _push();
    } else {
      _result = await _auth.signIn(_username, _password);
      if (_result == null) {
        if (_attempts > 4) {
          setState(() {
            _forgot = true;
          });
        }
        _attempts++;

        // ignore: use_build_context_synchronously
        !_showSnackBar(context, 'Invalid credentials !Try again');
      }
    }
  }

  _push() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const Home(uid: 'wpdSAe6bnPN7pfl3xOWemJABuDZ2')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.greenAccent[200],
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 20.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Sign in',
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Username',
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.5),
                            ),
                            onChanged: _updateUsername,
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Password',
                              filled: false,
                            ),
                            obscureText: _obscureText,
                            onChanged: _updatePassword,
                          ),
                        ),
                        const SizedBox(height: 7.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Checkbox(
                                value: !_obscureText,
                                onChanged: (value) {
                                  setState(() {
                                    _obscureText = !value!;
                                  });
                                }),
                            const Text('Show password')
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () async {
                            _login();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.purple[500]),
                          ),
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Visibility(
                          visible: _forgot,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              _success,
                              style: const TextStyle(
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
