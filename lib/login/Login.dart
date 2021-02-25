import 'package:flutter/material.dart';
import 'package:parker_mobile_framework/Utility/MyConstants.dart';
import 'package:parker_mobile_framework/HeaterApi/HeaterMainView.dart';

class Login extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Login> {
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _emailAddress = new TextEditingController();
  bool validate = false;
  String email;
  String password;
  bool _rememberMeFlag = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(HOME.login),
        backgroundColor: Colors.yellow,
      ),
      body: Center(
        
          child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(LoginString.huggigheater,
                      style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: Colors.blueAccent),
                      textAlign: TextAlign.center),
                  SizedBox(height: 60),
                  formSetup(context)
                ],
              ))),
    );
  }

  Widget formSetup(BuildContext context) {
    return new Form(
      key: _formKey,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new TextFormField(
            controller: _emailAddress,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
              hintText: LoginString.emailAddress,
              labelText: LoginString.emailAddress,
              suffixIcon: IconButton(
                iconSize: 18.0,
                onPressed: () => _emailAddress.clear(),
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            maxLength: 36,
            validator: (val) {
              if (val.length == 0)
                return LoginString.emailerrormsg;
              //  else if (!val.contains(""))
              //    return "Please enter valid UserId";
              else
                return null;
            },
            onSaved: (val) => email = val,
          ),
          SizedBox(height: 20),
          new TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  }),
              border: OutlineInputBorder(),
              hintText: LoginString.password,
              labelText: LoginString.password,
            ),
            obscureText: _isObscure,
            validator: (val) {
              if (val.length == 0)
                return LoginString.passerrormsg;
              else if (val.length <= 8)
                return LoginString.passlength;
              else
                return null;
            },
            onSaved: (val) => password = val,
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 20.0),
          ),
          Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: RaisedButton(
                child: new Text(
                  "Submit",
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HeaterMainView()),
                    );

                    //  _scaffoldKey.currentState.showSnackBar(new SnackBar(
                    //    content: new Text("Your email: $email and Password: $password"),
                    //  ));
                  }
                },
                color: Colors.yellow,
              )),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new GestureDetector(
                  child: new Row(
                    children: <Widget>[
                      new Checkbox(
                        value: _rememberMeFlag,
                        onChanged: (value) => setState(() {
                          _rememberMeFlag = !_rememberMeFlag;
                        }),
                      ),
                      new Text(
                        "Remember me",
                        style: new TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      //          new Container(
                      //   margin: new EdgeInsets.only(left: 25.0),
                      //   child: new  RaisedButton(
                      //   child: Text('forgot Password ?'),
                      //   color: Colors.yellow,
                      //   onPressed: (){},
                      // ),
                      // )
                    ],
                  ),
                  onTap: () => setState(() {
                    _rememberMeFlag = !_rememberMeFlag;
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
