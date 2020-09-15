import 'package:flutter/material.dart';
import 'words.dart';
import 'package:flip_card/flip_card.dart';

class FlashCard extends StatefulWidget {
  @override
  _FlashCardState createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  List<Words> words = [
    Words(
      word: 'Hello',
      meaning: 'Greeting',
      sentence: 'Hello World',
    ),
    Words(
      word: 'World',
      meaning: 'Surroundings',
      sentence: 'World Wide Web',
    ),
    Words(
      word: 'Flutter',
      meaning: 'Dart Framework',
      sentence: 'Flutter is great',
    ),
  ];
  int currWordIndex = 0;
  int totalWords = 0;
  int diffKey = 0;
  Widget flashcard;

  @override
  void initState() {
    super.initState();
    totalWords = words.length;
    flashcard = FlashCardContent(
      currWords: words[currWordIndex],
      key: ValueKey(diffKey),
    );
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
      if (currWordIndex < words.length - 1) {
        currWordIndex += 1;
      } else {
        currWordIndex = 0;
      }
    });
    animationKey();
  }

  // this function is called when user hit "YES"
  void rmRememberCard() {
    words.removeAt(currWordIndex);
    if (currWordIndex == words.length) {
      setState(() {
        currWordIndex = words.length - 1;
      });
    }
    animationKey();
  }

  void animationFlashCard() {
    setState(() {
      if (words.length != 0) {
        flashcard = FlashCardContent(
          currWords: words[currWordIndex],
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
      appBar: AppBar(  backgroundColor: Colors.blue[300],
        title: Text(
          'Flashcards learning',
          style: TextStyle(
            fontFamily: 'QuickSand',
            letterSpacing: 1.0,
            fontSize: 25.0
          ),
        ),
        centerTitle: true,),
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
                        numQuesLeft: words.length,
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
  final Words currWords;
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
  }
}
