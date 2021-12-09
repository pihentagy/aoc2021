import 'dart:async';
import 'dart:collection';

import 'package:async/async.dart';

import 'aoc2021.dart';

class Sliding<T> {
  final int size;
  final ListQueue<T> memory;

  Sliding(this.size) : memory = ListQueue<T>(size);

  void call(T data, Sink<List<T>> sink) {
    if (memory.length >= size) memory.removeFirst();
    memory.addLast(data);
    if (memory.length == size) sink.add(memory.toList());
  }
}

Stream<List<int>> filtered(Stream<int> numbers, int size) {
  var numbersWithPrevs = numbers.transform(
      StreamTransformer<int, List<int>>.fromHandlers(
          handleData: Sliding<int>(size).call));

  return numbersWithPrevs.where((List<int> nums) => nums[0] < nums[size - 1]);
}

Future<List<int>> day1(String filename) async {
  Stream<String> lines = streamFromFilename(filename);

  final numbers =
      StreamSplitter.splitFrom(lines.map((line) => int.parse(line)));

  final res1 = await filtered(numbers[0], 2).length;
  final res2 = await filtered(numbers[1], 4).length;
  return [res1, res2];
}
