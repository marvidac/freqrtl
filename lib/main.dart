import 'package:flutter/material.dart';
import 'package:rtlfreq/screen/frequency_register.dart';

import 'business/user_business.dart';
import 'component/button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Frequência'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  UserBusiness userBusiness = UserBusiness();
  bool alertVisibility = false;
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  _doLogin() {
    _setAlertVisibility(false);
    userBusiness.getByLoginAndPassword(loginController.text, passwordController.text)
    .then( (user) {
      if (null != user) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => FrequencyRegister(user)));
      } else {
        _setAlertVisibility(true);
      }
    });
  }

  _setAlertVisibility(bool status) {
    setState(() {
      alertVisibility = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    const AssetImage logo = AssetImage("assets/images/rtl-logo.png");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Image(
                image: logo,
                width: 250,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: loginController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'CPF'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Senha'),
                ),
              ),

              alertVisibility ?
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Login e senha incorretos.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: 16.0),
                  ),
                )
              : Container(),

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Button("Enviar", _doLogin),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
