import 'package:ForLingo/db/interact_with_db.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:ForLingo/models/vocab.dart';
import 'package:ForLingo/models/vocabs_interface.dart' as vs;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ForLingo/notification/time_manager.dart';
import 'package:ForLingo/db/statistic_database_helper.dart';

class FlashCardFuture extends StatefulWidget {
  static String routeName = '/bookmark';
  @override
  _FlashCardFutureState createState() => _FlashCardFutureState();
}

class _FlashCardFutureState extends State<FlashCardFuture> {
  bool firstTime = false;
  Future<List<Vocab>> wordsToLearn;

  Future<bool> checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime currentTime = DateTime.now();
    String lastString = prefs.getString('StatLast');
    bool firstTimeVisited = true;
    if (lastString != null) {
      DateTime lastTime = DateTime.parse(lastString);
      if (lastTime.day == currentTime.day &&
          lastTime.month == currentTime.month &&
          lastTime.year == currentTime.year) {
        firstTimeVisited = false;
      } else {
        firstTimeVisited = true;
      }
    } else {
      firstTimeVisited = true;
    }
    print(lastString);
    print(currentTime);
    await prefs.setString('StatLast', currentTime.toString());
    return firstTimeVisited;
  }

  @override
  void initState() {
    super.initState();
    checkFirstTime().then((firstTimeValue) {
      String today = TimeManager.getNowToString();
      print("This is bookmark day: $today, firstTime is now $firstTime");
      if (firstTimeValue == true) {
        // get the words with the `next` equal to today
        print("This is the first time user learned: $today");
        wordsToLearn = DBInteract.getVocabWithCondition(1, today);
      } else {
        // get the words with the field `update_notify_date` equal to today
        print("This is the second time user learned: $today");
        wordsToLearn = DBInteract.getVocabWithCondition(2, today);
      }
      print("first time is now $firstTimeValue");
      firstTime = firstTimeValue;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Vocab>>(
      future: wordsToLearn,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FlashCard(snapshot.data, firstTime);
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class FlashCard extends StatefulWidget {
  final List<Vocab> myWordlist;
  final bool firstVisited;
  FlashCard(this.myWordlist, this.firstVisited);
  @override
  _FlashCardState createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  int currWordIndex = 0;
  int totalWords = 0;
  int diffKey = 0;
  Widget flashcard;
  List<Vocab> wordlist = List();
  bool firstTime;
  // this will prevent the card whose first time is not remember, and the
  // second time is remembered.
  int wordsRevised = 0;

  @override
  void initState() {
    super.initState();
    wordlist = widget.myWordlist;
    print("Wordlist: $wordlist");
    totalWords = wordlist.length;
    resetIsRemember();
    firstTime = widget.firstVisited;
    if (totalWords != 0) {
      // this mean that user have some words to learn
      flashcard = FlashCardContent(
        currWords: wordlist[currWordIndex],
        key: ValueKey(diffKey),
      );
      if (firstTime) {
        updateDataBase(totalWords);
      }
    } else {
      flashcard = Text('Please add some words');
    }
  }

  // this method marks all the vocabs as 'non checked'
  void resetIsRemember() {
    for (int i = 0; i < wordlist.length; i++) {
      wordlist[i].isRemember = 0;
    }
  }

  // mark the word at current index as checked
  void setIsRemember() {
    setState(() {
      wordlist[currWordIndex].isRemember = 1;
    });
  }

  // this function update to the statistics database the number of words have to learn today
  Future<void> updateDataBase(int value) async {
    DateTime currentTime = DateTime.now();
    int week;
    int day = currentTime.day;
    if (day <= 7)
      week = 1;
    else if (day <= 14)
      week = 2;
    else if (day <= 21)
      week = 3;
    else if (day <= 28)
      week = 4;
    else
      week = 5;
    await StatDBInteract.upDateTotalVocab(0, currentTime.weekday, value);
    await StatDBInteract.upDateTotalVocab(1, week, value);
    await StatDBInteract.upDateTotalVocab(2, currentTime.month, value);
    await StatDBInteract.upDateTotalVocab(3, 1, value);
    return;
  }

  Future<void> updateDataBaseWordRem(int isRem) async {
    //if the word at current index has been marked as "checked", do nothing. Else update database
    if (isRem == 1) {
      print('Do nothing!');
    } else {
      DateTime currentTime = DateTime.now();
      int week;
      int day = currentTime.day;
      if (day <= 7)
        week = 1;
      else if (day <= 14)
        week = 2;
      else if (day <= 21)
        week = 3;
      else if (day <= 28)
        week = 4;
      else
        week = 5;
      await StatDBInteract.upDateVocabRem(0, currentTime.weekday);
      await StatDBInteract.upDateVocabRem(1, week);
      await StatDBInteract.upDateVocabRem(2, currentTime.month);
      await StatDBInteract.upDateVocabRem(3, 1);
    }
    return;
  }

  // this function is called to change the diffKey so that
  // AnimatedSwitcher can perform Transition
  void animationKey() {
    setState(() {
      if (diffKey == 0) {
        diffKey = 1;
      } else {
        diffKey = 0;
      }
    });
  }

  // this function is called when user hit "NO"
  void nextCard() {
    setState(() {
      if (currWordIndex < wordlist.length - 1) {
        currWordIndex += 1;
      } else {
        currWordIndex = 0;
      }
    });
    animationKey();
  }

  // this function is called when user hit "YES"
  void rmRememberCard() {
    if (wordlist.length != 0) {
      wordlist.removeAt(currWordIndex);
      if (currWordIndex == wordlist.length) {
        setState(() {
          currWordIndex = wordlist.length - 1;
        });
      }
    }
    animationKey();
  }

  void animationFlashCard() {
    setState(() {
      if (wordlist.length != 0) {
        flashcard = FlashCardContent(
          currWords: wordlist[currWordIndex],
          key: ValueKey(diffKey),
        );
      } else {
        flashcard = Text('Congratulation! You have learned all the words.');
      }
    });
  }

  void updateNotifyDateUserInput({bool answerCorrect, Vocab vocab}) async {
    if (firstTime == true && wordsRevised < totalWords) {
      wordsRevised += 1;
      if (answerCorrect) {
        int newGroup = vocab.group;
        int newLevel = vocab.level;
        bool maximum = false;
        if (vocab.group == 1) {
          if (vocab.level == 0) {
            newLevel += 1;
          } else if (vocab.level == 1) {
            newGroup = 2;
            newLevel = 0;
          } else if (vocab.level == -1) {
            newGroup = 14;
            maximum = true;
          }
        } else if (vocab.group == 2) {
          newGroup = 7;
        } else if (vocab.group == 7) {
          newLevel = 0;
          newGroup = 14;
        } else if (vocab.group == 14) {
          maximum = true;
        }
        String today = TimeManager.getNowToString();
        if (!maximum) {
          await vs.updateNotifyVocabModel(vocab, newGroup, newLevel, today);
        }
      } else {
        int newGroup = vocab.group;
        int newLevel = vocab.level;
        if (vocab.group == 1) {
          if (vocab.level == 0) {
            newGroup = 1;
            newLevel = 0;
          } else if (vocab.level == 1) {
            newLevel -= 1;
          } else if (vocab.level == -1) {
            newGroup = 7;
            newLevel = 0;
          }
        } else if (vocab.group == 2) {
          newLevel = 0;
          newGroup = 1;
        } else if (vocab.group == 7) {
          newLevel = 0;
          newGroup = 2;
        } else if (vocab.group == 14) {
          newGroup = 1;
          newLevel = -1;
        }
        String today = TimeManager.getNowToString();
        await vs.updateNotifyVocabModel(vocab, newGroup, newLevel, today);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: Text('Flashcard learning')),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Row(
                    children: <Widget>[
                      Spacer(),
                      NumberQuestion(
                        numQuesLeft: wordlist.length,
                        totalNumQuest: totalWords,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: AnimatedSwitcher(
                  transitionBuilder: (child, animation) => ScaleTransition(
                    child: child,
                    scale: animation,
                  ),
                  child: flashcard,
                  duration: const Duration(milliseconds: 500),
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: FlatButton(
                          padding: EdgeInsets.all(15.0),
                          child: Icon(Icons.close, size: 30.0),
                          textColor: Colors.white,
                          color: Colors.red,
                          onPressed: () {
                            if (wordlist.length != 0) {
                              setIsRemember();
                              updateNotifyDateUserInput(
                                  answerCorrect: false,
                                  vocab: wordlist[currWordIndex]);
                              nextCard();
                              animationFlashCard();
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: FlatButton(
                          padding: EdgeInsets.all(15.0),
                          child: Icon(Icons.check, size: 30.0),
                          textColor: Colors.white,
                          color: Colors.green,
                          onPressed: () async {
                            if (wordlist.length != 0) {
                              if (firstTime) {
                                await updateDataBaseWordRem(
                                    wordlist[currWordIndex].isRemember);
                                setIsRemember();
                              }
                              updateNotifyDateUserInput(
                                  answerCorrect: true,
                                  vocab: wordlist[currWordIndex]);
                              rmRememberCard();
                              animationFlashCard();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FlashCardContent extends StatefulWidget {
  final Vocab currWords;
  const FlashCardContent({Key key, this.currWords}) : super(key: key);
  @override
  _FlashCardContentState createState() => _FlashCardContentState();
}

class _FlashCardContentState extends State<FlashCardContent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      child: FlipCard(
        front: Card(
          child: Center(
            child: Text(
              '${widget.currWords.word}',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        back: Card(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${widget.currWords.meaning}',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${widget.currWords.sentence}',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NumberQuestion extends StatefulWidget {
  final int numQuesLeft;
  final int totalNumQuest;
  NumberQuestion({Key key, this.numQuesLeft, this.totalNumQuest})
      : super(key: key);
  @override
  _NumberQuestionState createState() => _NumberQuestionState();
}

class _NumberQuestionState extends State<NumberQuestion> {
  @override
  Widget build(BuildContext context) {
    if (widget.totalNumQuest != 0) {
      // if user have some words, display circular progress bar
      // else, return empty SizedBox(which display nothing)
      return Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          CircularProgressIndicator(
            value: widget.numQuesLeft / widget.totalNumQuest,
            backgroundColor: Colors.grey.shade700,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[200]),
          ),
          Text('${widget.numQuesLeft}'),
        ],
      );
    } else {
      return SizedBox();
    }
  }
}
