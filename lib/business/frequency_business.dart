import 'package:rtlfreq/dao/frequency_dao.dart';
import 'package:rtlfreq/model/frequency.dart';

class FrequencyBusiness {
  getAllByLogin(String login) async {
    return await FrequencyDao.getAllByLogin(login);
  }

  save(Frequency frequency) async {
    return await FrequencyDao.save(frequency);
  }
}
