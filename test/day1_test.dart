import 'package:aoc2021/day1.dart' as day1;
import 'package:test/test.dart';

void main() {
  test('calculate', () async {
    var res = (await day1.day1('input/day1_test'));
    expect(res, [7, 5]);
  });
}
