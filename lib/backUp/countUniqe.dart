void main() {
  List<String> letters = [
    'a',
    'b',
    'c',
    'd',
    'a',
    'a',
    'a',
    'b',
    'a',
    'a',
    'b',
    'b'
  ];

  print('1. Count occurrences using loop:');
  print('Letter \'a\' appears ${countOccurrencesUsingLoop(letters, 'a')} times');
  print('Letter \'b\' appears ${countOccurrencesUsingLoop(letters, 'b')} times');
  print('Letter \'f\' appears ${countOccurrencesUsingLoop(letters, 'f')} times');

  print('\n***********\n');

  print('2. Count occurrences using where method:');
  print('Letter \'a\' appears ${countOccurrencesUsingWhereMethod(letters, 'a')} times');
  print('Letter \'b\' appears ${countOccurrencesUsingWhereMethod(letters, 'b')} times');
  print('Letter \'f\' appears ${countOccurrencesUsingWhereMethod(letters, 'f')} times');

  print('\n***********\n');

  print('2. Count occurrences using extensions:');
  print('Letter \'a\' appears ${countOccurrencesUsingExtension(letters, 'a')} times');
  print('Letter \'b\' appears ${countOccurrencesUsingExtension(letters, 'b')} times');
  print('Letter \'f\' appears ${countOccurrencesUsingExtension(letters, 'f')} times');
}

int countOccurrencesUsingLoop(List<String> list, String element) {
  if (list == null || list.isEmpty) {
    return 0;
  }

  int count = 0;
  for (int i = 0; i < list.length; i++) {
    if (list[i] == element) {
      count++;
    }
  }

  return count;
}

int countOccurrencesUsingWhereMethod(List<String> list, String element) {
  if (list == null || list.isEmpty) {
    return 0;
  }

  var foundElements = list.where((e) => e == element);
  return foundElements.length;
}

int countOccurrencesUsingExtension(List<String> list, String element) {
  return list.findOccurrences(element);
  // OR
  // return ListExt(list).findOccurrences(element);
}

extension ListExt on List {
  int findOccurrences(String element) {
    var foundLetters = this.where((letter) => letter == element);
    return foundLetters.length;
  }
}

