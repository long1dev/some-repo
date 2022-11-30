void main() {
  final Person serban1 = Person('Serban', 21);
  final Person serban2 = Person('Serban', 21);
  serban1.eat();
}

class Being {}

class Soul {}

mixin Eat {
  int get count;

  void eat() {
    print('Very good! $count');
  }
}

class Animal with Eat implements Being, Soul {
  Animal(this.legCount);

  final int legCount;

  @override
  int get count => legCount;
}

class Person with Eat {
  const Person(this.name, this.age);

  const Person.name(this.name) : age = 0;

  const Person.empty()
      : age = 0,
        name = 'No Name';

  final String name;
  final int age;

  @override
  int get count => age;

  @override
  String toString() {
    return '($name - $age)';
  }

  @override
  bool operator ==(Object other) {
    return other is Person && name == other.name && age == other.age;
  }

  @override
  int get hashCode => name.hashCode ^ age.hashCode;
}
