void main() {
  final List<int> list = <int>[1, 2, 3, 3];
  print(list.length);
  list[1] = 5;

  final Iterable<String> map = list.map((item) => 'Razvan $item');
  print(map);

  final Iterable<int> expand = list.expand((item) => [item + 1, item]);
  print(expand);

  print(map.toList());
  print(expand.toSet());

  final Map<String, int> data = <String, int>{
    'Razvan': 30,
  };
  data['Stefan'] = 21;

  print(data.keys);
  print(data.values);
}
