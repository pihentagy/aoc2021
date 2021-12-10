import 'package:aoc2021/day2.dart' as day2;
import 'package:async/async.dart';
import 'package:test/test.dart';

Future<void> main() async {
  Stream<day2.Command> commands = day2.fileCommands('input/day2_test');
  var splitter = StreamSplitter(commands);

  test('part1', () async {
    var res1 = (await day2.solve(splitter.split(), day2.part1Folder));
    expect(res1, 150);
  });
  test('part2', () async {
    var res2 = (await day2.solve(splitter.split(), day2.part2Folder));
    expect(res2, 900);
  });
}
