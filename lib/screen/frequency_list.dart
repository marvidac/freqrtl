import 'package:flutter/material.dart';
import 'package:rtlfreq/dao/frequency_dao.dart';
import 'package:rtlfreq/model/frequency.dart';
import 'package:rtlfreq/model/user.dart';

class FrequencyList extends StatefulWidget {
  late Future<List<Frequency>> frequencyList;
  User user;

  FrequencyList(this.user, {Key? key}) : super(key: key) {
    frequencyList = _getAllFrequenciesByUser();
  }

  Future<List<Frequency>> _getAllFrequenciesByUser() async {
    return await FrequencyDao.getAllByLogin(user.login);
  }

  @override
  State<FrequencyList> createState() => _FrequencyListState();
}

class _FrequencyListState extends State<FrequencyList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Frequências"),
      ),
      body: FutureBuilder<List<Frequency>>(
          future: widget.frequencyList,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text(
                'There was an error :(',
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var item = snapshot.data![index];
                  return ListTile(
                    title: Text(item.dateTime),
                    subtitle: Text(item.synchronized == 1 ? "Sincronizado" : "Não sincronizado"),
                  );
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          }
      ),
    );
  }
}
