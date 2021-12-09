import 'dart:convert';
import 'dart:io';

Stream<String> fileLinesStream(String filename) {
  final file = File(filename);
  final lines = ascii.decoder.bind(file.openRead()).transform(LineSplitter());
  return lines;
}
