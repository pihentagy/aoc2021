import 'package:aoc2021/day2.dart' as day2;
import 'package:async/async.dart';

Future<void> main(List<String> arguments) async {
  Stream<day2.Command> commands = day2.fileCommands('input/input2');
  var splitter = StreamSplitter(commands);

  print(await day2.solve(splitter.split(), day2.part1Folder));
  print(await day2.solve(splitter.split(), day2.part2Folder));
}
