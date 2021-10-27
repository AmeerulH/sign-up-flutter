import 'package:exercise/exercise.dart' as exercise;
import 'dart:math';
import 'dart:io'; 

void main() {
  List<int> numbers = [];
  Random random = Random();

  int max = 0;
  int min = 0;
  double total = 0;
  double average = 0;
  int temp = 0;

  for (var i = 0; i < 100; i++) {
    numbers.add(random.nextInt(1000));
  }

  for (var i = 0; i < numbers.length; i++) {
    temp = numbers[i];
    if(max < temp) {
      max = temp;
    }

    if(i == 0) {
      min = temp;
    }

    if(i > 0) {
      if(min > temp) {
        min = temp;
      }
    }
    
    total += temp;
  }

  average = total / 100;

  print('The max is: $max');
  print('The min is: $min');
  print('The average is: $average');

  print("Enter input: ");

  String? input = stdin.readLineSync();

  List<String> words = input!.split(' ');
  var newWords = new Map();


  words.sort();

  words.forEach((word) {
    if(newWords.containsKey(word)) {
      newWords[word] += 1;
    } else {
      newWords[word] =1;
    }
  });

  print(words);
  print(newWords);
}

