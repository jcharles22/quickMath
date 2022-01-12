import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'dart:math';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final countdowncontroller = CountDownController();
  bool startTimer = false;
  void _startTimer() {
    countdowncontroller.start();
  }

  int correctAnsers = 0;
  int totalQuestionsAsked = 0;
  String mathSymbol = '+';
  String question = '0 + 0';
  List<int> answers = [0, 0, 0, 0];
  int rightAnswer = 0;
  bool gameActive = false;

  void generateAnswers(ans) {
    var random = Random();
    List<int> result = answers.map((i) => random.nextInt(49) + 1).toList();
    result[random.nextInt(4)] = ans;
    setState(() {
      answers = result;
    });
  }

  void generateQuestion() {
    var random = Random();

    int x = random.nextInt(49) + 1;
    int y = random.nextInt(49) + 1;
    int tempAns = 0;
    if (random.nextBool()) {
      tempAns = x + y;
      mathSymbol = '+';
    } else {
      tempAns = x - y;
      mathSymbol = '-';
    }

    generateAnswers(tempAns);
    setState(() {
      rightAnswer = tempAns;
      question = "$x $mathSymbol $y";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () =>
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              ProfileHeader(
                countdowncontroller: countdowncontroller,
                coverImage: const NetworkImage(
                    'https://images.unsplash.com/photo-1509869175650-a1d97972541a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80'),
              ),
              const SizedBox(height: 10.0),
              Center(
                child: Text(
                  question,
                  style: TextStyle(fontSize: 32),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _buildWikiCategory(
                        "A.", Color(0xFFF102542), answers[0]),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _buildWikiCategory(
                        "B.", Color(0xFFFb3a394), answers[1]),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _buildWikiCategory(
                      "C.",
                      const Color(0xFFF00A878),
                      answers[2],
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child:
                        _buildWikiCategory("D.", Color(0xFFF87060), answers[3]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.play_arrow),
          label: const Text('Start'),
          onPressed: () {
            setState(() {
              gameActive = true;
            });
            generateQuestion();
            _startTimer;
          }),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  InkWell _buildWikiCategory(String label, Color color, int answers) {
    return InkWell(
      onTap: gameActive
          ? () {
              if (rightAnswer == answers) {
                print('right');
              } else {
                print('wrong');
              }
              generateQuestion();
            }
          : () {},
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(26.0),
            alignment: Alignment.center,
            child: Text(
              '$answers',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0, left: 8),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final ImageProvider<dynamic> coverImage;
  final CountDownController countdowncontroller;
  const ProfileHeader({
    Key? key,
    required this.coverImage,
    required this.countdowncontroller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Ink(
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: coverImage as ImageProvider<Object>, fit: BoxFit.cover),
          ),
        ),
        Ink(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.black38,
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 110),
          child: Avatar(
            radius: 80,
            countdowncontroller: countdowncontroller,
            backgroundColor: Colors.white,
            borderColor: Colors.grey.shade300,
            borderWidth: 4.0,
          ),
        )
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final Color borderColor;
  final Color? backgroundColor;
  final double radius;
  final double borderWidth;
  final CountDownController countdowncontroller;

  const Avatar(
      {Key? key,
      this.borderColor = Colors.grey,
      this.backgroundColor,
      required this.countdowncontroller,
      this.radius = 30,
      this.borderWidth = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      duration: 20,
      initialDuration: 0,
      controller: countdowncontroller,
      width: radius,
      height: radius,
      ringColor: Colors.grey,
      ringGradient: null,
      fillColor: Colors.purpleAccent,
      fillGradient: null,
      backgroundColor: Colors.purple[500],
      backgroundGradient: null,
      strokeWidth: borderWidth,
      strokeCap: StrokeCap.round,
      textStyle: TextStyle(
          fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),
      textFormat: CountdownTextFormat.S,
      isReverse: true,
      isReverseAnimation: true,
      isTimerTextShown: true,
      autoStart: false,
      onStart: () {
        print('Countdown Started');
      },
      onComplete: () {
        print('countdown finished');
      },
    );
  }
}
