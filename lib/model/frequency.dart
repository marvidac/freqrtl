final String tableFrequency = 'frequency';

class FrequencyFields {
  static final String id = '_id';
  static final String userId = 'userId';
  static final String dateTime = 'dateTime';
  static final String synchronized = 'synchronized';
  static final String synchronizedDateTime = 'synchronizedDateTime';

  static final List<String> values = [
    id, userId, dateTime, synchronized, synchronizedDateTime
  ];
}
class Frequency {
  final int? id;
  final String user;
  final String dateTime;
  final int? synchronized;
  final String? synchronizedDateTime;

  const Frequency ({
    this.id,
    required this.user,
    required this.dateTime,
    this.synchronized,
    this.synchronizedDateTime
  });

  factory Frequency.fromMap(Map<String, Object?> json) => Frequency (
    id: json['id'] != null ? (json['id'] as int) : null,
    user: json['user'] as String,
    dateTime: json['dateTime'] as String,
    synchronized: json['synchronized'] as int,
    synchronizedDateTime: json['synchronizedDateTime'] as String
  );

  Map<String, Object?> toJson() {
    return {
      "id": id,
      "user": user,
      "dateTime": dateTime,
      "synchronized": synchronized,
      "synchronizedDateTime": synchronizedDateTime
    };
  }

  Frequency copy({
    int? id,
    String? user,
    String? dateTime,
    int? synchronized,
    String? synchronizedDateTime
}) => Frequency (
      id: id ?? this.id,
      user: user ?? this.user,
      dateTime: dateTime ?? this.dateTime,
      synchronized: synchronized ?? this.synchronized,
      synchronizedDateTime: synchronizedDateTime ?? this.synchronizedDateTime
  );
}
