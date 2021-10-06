import 'package:flutter/material.dart';
import 'package:rtlfreq/business/frequency_business.dart';
import 'package:rtlfreq/component/button.dart';
import 'package:rtlfreq/component/utils.dart';
import 'package:rtlfreq/model/frequency.dart';
import 'package:rtlfreq/model/user.dart';
import 'package:rtlfreq/screen/frequency_list.dart';

class FrequencyRegister extends StatefulWidget {
  User user;

  FrequencyRegister(this.user, {Key? key}) : super(key: key);

  @override
  State<FrequencyRegister> createState() => _FrequencyRegisterState();
}

class _FrequencyRegisterState extends State<FrequencyRegister> {
  FrequencyBusiness frequencyBusiness = FrequencyBusiness();
  bool alertVisibility = false;
  String alertMessage = '';

  Frequency _buildFrequency() {
    return Frequency.fromMap({
      "user": widget.user.login,
      "dateTime": Utils.getDateTime(),
      "synchronized": 0,
      "synchronizedDateTime": ""
    });
  }

  _setAlertVisibility(bool status) {
    setState(() {
      alertVisibility = status;
    });
  }

  _setAlertMessage(String message) {
    setState(() {
      alertMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    _insertFrequencyOnDB() async {
      frequencyBusiness.save(_buildFrequency()).then((frequency) {
        if (null != frequency) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FrequencyList(widget.user)));
        } else {
          _setAlertMessage(
              "Erro ao inserir frequência. Feche o app e tente novamente.");
          _setAlertVisibility(true);
        }
      });
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Registrar frequência"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Usuário logado: ",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.user.login,
                      style: TextStyle(fontSize: 24.0),
                    )
                  ],
                ),
              ),
              Button("Registrar", _insertFrequencyOnDB),
              alertVisibility
                  ? Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        alertMessage,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red, fontSize: 16.0),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
