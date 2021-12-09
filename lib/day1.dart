import 'dart:async';
import 'dart:collection';

import 'package:async/async.dart';

import 'aoc2021.dart';

Stream<List<T>> sliding<T>(Stream<T> stream, int size) async* {
  final memory = ListQueue<T>(size);
  await for (var elem in stream) {
    if (memory.length >= size) memory.removeFirst();
    memory.addLast(elem);
    if (memory.length == size) yield memory.toList();
  }
}

Stream<List<int>> filtered(Stream<int> numbers, int size) =>
    sliding(numbers, size).where((List<int> nums) => nums[0] < nums[size - 1]);

Future<List<int>> day1(String filename) async {
  Stream<String> lines = streamFromFilename(filename);

  final numbers =
      StreamSplitter.splitFrom(lines.map((line) => int.parse(line)));

  final res1 = await filtered(numbers[0], 2).length;
  final res2 = await filtered(numbers[1], 4).length;
  return [res1, res2];
}
