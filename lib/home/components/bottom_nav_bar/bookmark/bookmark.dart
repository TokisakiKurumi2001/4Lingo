import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:ForLingo/models/vocab.dart';
import 'package:ForLingo/models/vocabs_interface.dart' as vs;
import 'package:shared_preferences/shared_preferences.dart';

class FlashCardFuture extends StatefulWidget {
  @override
  _FlashCardFutureState createState() => _FlashCardFutureState();
}

class _FlashCardFutureState extends State<FlashCardFuture> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Vocab>>(
      future: vs.future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FlashCard(snapshot.data);
        } else {
          return Center(
            child: Text(
              "Loading....",
              style: TextStyle(fontSize: 40),
            ),
          );
        }
      },
    );
  }
}

class FlashCard extends StatefulWidget {
  final List<Vocab> myWordlist;
  FlashCard(this.myWordlist);
  @override
  _FlashCardState createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  int currWordIndex = 0;
  int totalWords = 0;
  int diffKey = 0;
  Widget flashcard;
  List<Vocab> wordlist = List();
  bool firstTime = true;

  @override
  void initState() {
    super.initState();
    wordlist = widget.myWordlist;
    print("Wordlist: $wordlist");
    totalWords = wordlist.length;
    if (totalWords != 0) {
      // this mean that user have some words to learn
      flashcard = FlashCardContent(
        currWords: wordlist[currWordIndex],
        key: ValueKey(diffKey),
      );
      checkFirstTime();
    } else {
      flashcard = Text('Please add some words');
    }
  }

  Future<void> checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime currentTime = DateTime.now();
    String lastString = prefs.getString('StatLast');
    if (lastString != null) {
      DateTime lastTime = DateTime.parse(lastString);
      if (lastTime.day == currentTime.day &&
          lastTime.month == currentTime.month &&
          lastTime.year == currentTime.year) {
        firstTime = false;
      } else {
        firstTime = true;
      }
    } else {
      firstTime = true;
    }
    print(lastString);
    print(currentTime);
    await prefs.setString('StatLast', currentTime.toString());
    setState(() {});
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
                            nextCard();
                            animationFlashCard();
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
                          onPressed: () {
                            rmRememberCard();
                            animationFlashCard();
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
