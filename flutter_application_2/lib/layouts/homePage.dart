import 'package:flutter/material.dart';
import '../model/custom_widgets/input.dart';
import '../model/custom_widgets/button.dart';
import '../controller/get_lyrics.dart';

class homePage extends StatefulWidget {
  homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final artistController = TextEditingController();
  final songController = TextEditingController();

  final api = new FetchLyrics();

  String lyric = '';

  bool isFound = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Center(
            child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            CustomInputField(hint: "Artist Name", controller: artistController),
            SizedBox(
              height: 10,
            ),
            CustomInputField(hint: "Song Name", controller: songController),
            SizedBox(
              height: 10,
            ),
            CustomButton(
                text: "Find",
                onPressed: () {
                  setState(() {
                    isFound = false;
                  });
                  api
                      .getLyrics(artistController.value.text,
                          songController.value.text)
                      .then((value) {
                    setState(() {
                      lyric = value;
                      isFound = true;
                    });
                  });
                }),
            SizedBox(
              height: 30,
            ),
          ],
        )),
        Flexible(
            child: Container(
          width: MediaQuery.of(context).size.width * 80 / 100,
          height: MediaQuery.of(context).size.height * 55 / 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color.fromARGB(255, 56, 56, 56),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 44, 44, 44).withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: isFound
              ? Scrollbar(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(lyric),
                  ),
                )
              : Center(
                  child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator()),
                ),
        ))
      ]),
    );
  }
}
