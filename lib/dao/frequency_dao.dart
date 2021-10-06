import 'package:rtlfreq/dao/provide_db.dart';
import 'package:rtlfreq/model/frequency.dart';

class FrequencyDao {

  static Future<List<Frequency>> getAllByLogin(String login) async {
    List<Frequency> frequencies = [];
    final db = await ProvideDB.instance.database;
    List<Map> list = await db.rawQuery("SELECT * FROM 'frequency' WHERE user='$login'");
    var freqs = list.iterator;
    while(freqs.moveNext()) {
      var freq = Frequency.fromMap(freqs.current as Map<String, Object?>);
      frequencies.add(freq);
      freq.toString();
    }

    return frequencies;
  }

  static Future<Frequency>
  save(Frequency frequency)  async {
    final db = await ProvideDB.instance.database;
    Frequency freq = frequency;

    if (frequency.id == null) {
      freq = await db.insert(tableFrequency, frequency.toJson()).then((id) => frequency.copy(id: id));
    } else {
      db.update(
        tableFrequency,
        frequency.toJson(),
        where: '${FrequencyFields.id} = ?',
        whereArgs: [frequency.id],
      );
    }

    return freq;
  }

  static Future<int> delete(int? id) async {
    final db = await ProvideDB.instance.database;

    return await db.delete(
      tableFrequency,
      where: '${FrequencyFields.id} = ?',
      whereArgs: [id],
    );
  }
}
