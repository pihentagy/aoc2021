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

Future<List<int>> day1(String filename) async {
  Stream<int> numbers = fileLinesStream(filename).map(int.parse);

  final numSplit = StreamSplitter.splitFrom(numbers);

  return await Future.wait([
    sliding(numSplit[0], 2).where((List<int> nums) => nums[0] < nums[1]).length,
    sliding(numSplit[1], 4).where((List<int> nums) => nums[0] < nums[3]).length
  ]);
}
