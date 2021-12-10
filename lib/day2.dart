import 'dart:async';

import 'aoc2021.dart';

class Pos {
  final int x;
  final int y;
  final int aim;

  Pos(this.x, this.y, this.aim);

  @override
  String toString() => 'x: $x y: $y, aim: $aim';
}

final initialPos = Pos(0, 0, 0);

class Command {
  final String command;
  final int value;

  Command(this.command, this.value);
}

final re = RegExp(r'^(forward|up|down) (\d+)$');

Pos part1Folder(Pos acc, Command elem) {
  switch (elem.command) {
    case 'up':
      return Pos(acc.x, acc.y - elem.value, acc.aim);
    case 'down':
      return Pos(acc.x, acc.y + elem.value, acc.aim);
    case 'forward':
      return Pos(acc.x + elem.value, acc.y, acc.aim);
    default:
      throw Exception('unknown command "${elem.command}"');
  }
}

Pos part2Folder(Pos acc, Command elem) {
  switch (elem.command) {
    case 'down':
      return Pos(acc.x, acc.y, acc.aim + elem.value);
    case 'up':
      return Pos(acc.x, acc.y, acc.aim - elem.value);
    case 'forward':
      return Pos(acc.x + elem.value, acc.y + acc.aim * elem.value, acc.aim);
    default:
      throw Exception('unknown command "${elem.command}"');
  }
}

Stream<Command> fileCommands(String fn) {
  final commands = fileLinesStream(fn).map<Command>((line) {
    var match = re.firstMatch(line);
    if (match == null) throw Exception('omg');
    return Command(match.group(1)!, int.parse(match.group(2)!));
  });
  return commands;
}

Future<int> solve(Stream<Command> commands,
    Pos Function(Pos previous, Command element) folder) async {
  final res = await commands.fold<Pos>(initialPos, folder);
  return res.x * res.y;
}
