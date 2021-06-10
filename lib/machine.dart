class Machine {
  final String id;
  final num injectTime;
  final num metalPrepTime;
  final num tapTemp;
  final String colorVal;
  Machine(this.id, this.injectTime, this.metalPrepTime, this.tapTemp,
      this.colorVal);

  Machine.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['inject-time'] != null),
        assert(map['metal-prep-time'] != null),
        assert(map['tap-temp'] != null),
        assert(map['colorVal'] != null),
        id = map['id'],
        injectTime = map['inject-time'],
        metalPrepTime = map['metal-prep-time'],
        tapTemp = map['tap-temp'],
        colorVal = map['colorVal'];

  @override
  String toString() =>
      "Record<$id:$injectTime:$metalPrepTime:$tapTemp:$colorVal>";
}
