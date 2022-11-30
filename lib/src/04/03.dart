void main() {
  print(sum(10));
}

// 1. required positional
// 2. optional positional
// 3. optional named
// 4. optional required named

String sum(int a, {int? b, int c = 1}) {
  return '$a $b $c';
}
