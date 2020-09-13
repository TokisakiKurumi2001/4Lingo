import 'vocab.dart';

List<Vocab> words = [
  Vocab(word: 'apple', meaning: 'red fruit', sentence: 'This is an apple'),
  Vocab(word: 'mango', meaning: 'yellow fruit', sentence: 'Mango is yellow'),
  Vocab(word: 'orange', meaning: 'orange fruit', sentence: 'This is an orange'),
  Vocab(
    word: 'hello',
    meaning: 'Greeting',
    sentence: 'Hello World',
  ),
  Vocab(
    word: 'world',
    meaning: 'Surroundings',
    sentence: 'World Wide Web',
  ),
];
/*
void adding(Vocab w)
{
  for(int i =0 ; i < words.length;i++)
  {
    String tmp = words[i].word;
    if((w.word).compareTo(tmp) == -1)
    {
      words.insert(i,w);
      return;
    }
  }
  words.add(w);
  return;
}*/
void adding(Vocab w) {
  words.add(w);
}

void delete(Vocab w) {
  for (int i = 0; i < words.length; i++) {
    if (words[i].word == w.word) {
      words.removeAt(i);
      return;
    }
  }
  return;
}

int finding(Vocab w) {
  for (int i = 0; i < words.length; i++) {
    if (words[i].word == w.word) return i;
  }
  return -1;
}

void sorting() {
  words.sort((Vocab a, Vocab b) => ((a.word).compareTo(b.word)));
}

int length() {
  return words.length;
}
