// ignore_for_file: avoid_print

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Delta Translate",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage()
    );
  }
}



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late stt.SpeechToText _speech;
  bool _isListening = false;
  final _text = TextEditingController();

  String dropdown1Value = "Select Language";
  String dropdown2Value = "Select Language";

  void _listen() async{
    if(!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if(available){
        print("clicked");
        setState(() {
          _isListening = true;
        });
        _speech.listen(
          onResult: (val) => setState(() {
            _text.text = val.recognizedWords;
            print(val.recognizedWords);
          }),
        );
      }
    }
    else
      {
        setState(() {
          _isListening = false;
          _speech.stop();
        });
      }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _text.text = "";
    _speech = stt.SpeechToText();
  }

  var items = [
    "Select Language",
    "Afrikaans",
    "Albanian",
    "Amharic",
    "Arabic",
    "Armenian",
    "Azerbaijani",
    "Basque",
    "Belarusian",
    "Bengali",
    "Bosnian",
    "Bulgarian",
    "Catalan",
    "Cebuano",
    "Chinese (Simplified)",
    "Chinese (Traditional)",
    "Corsican",
    "Croatian",
    "Czech",
    "Danish",
    "Dutch",
    "English",
    "Esperanto",
    "Estonian",
    "Finnish",
    "French",
    "Frisian",
    "Galicia",
    "Georgian",
    "German",
    "Greek"
  ];

@override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                  flex: 1,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        // TODO: Title
                        const Text("Translator",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                          ),
                        ),
                        //TODO: Text field
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                                child : TextFormField(
                                  maxLength: 5000,
                                  minLines: 10,
                                  controller: _text,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter to translate or Press the button and start speaking",
                                  ), // any number you need (It works as the rows for the textarea)
                                  textInputAction: TextInputAction.done,
                                  style: const TextStyle(fontSize: 15),
                                  maxLines: 10,
                                  onFieldSubmitted: (isVisible){
                                    print("clicked");
                                  },
                                )
                            ),
                          ),
                        ),
                        //TODO: language picker section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            DecoratedBox(
                              decoration: const ShapeDecoration(
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    borderRadius: BorderRadius.circular(5),
                                    // Initial Value
                                    value: dropdown1Value,
                                    dropdownColor: Colors.blue,
                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white,),
                                    // Array list of items
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items, style: const TextStyle(color: Colors.white, fontSize: 10)),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdown1Value = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),),
                            IconButton(onPressed: (){
                              String temp;
                              temp = dropdown1Value;
                              setState(() {
                                dropdown1Value = dropdown2Value;
                                dropdown2Value = temp;
                              });
                            }, color: Colors.blue, icon: const Icon(Icons.sync_alt_outlined)),
                            DecoratedBox(
                              decoration: const ShapeDecoration(
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    // Initial Value
                                    value: dropdown2Value,
                                    dropdownColor: Colors.blue,
                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white,),
                                    // Array list of items
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items, style: const TextStyle(color: Colors.white, fontSize: 10)),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdown2Value = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),),
                          ],
                        ),
                      ],
                    ),
                  )),
              Flexible(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                                child : TextFormField(
                                  minLines: 6,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Type to translate',
                                  ),
                                  maxLines: 6,
                                )
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              IconButton(onPressed: null, icon: Icon(Icons.copy, color: Colors.blue,)),
                              IconButton(onPressed: null, icon: Icon(Icons.close, color: Colors.blue,)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Material(
                                borderRadius: BorderRadius.circular(50),
                                child: IconButton(onPressed: () { _listen(); }, icon: const Icon(Icons.mic), color: Colors.white,),
                              ),
                              AvatarGlow(
                                animate: _isListening,
                                glowColor: Theme.of(context).primaryColor,
                                duration: const Duration(milliseconds: 2000),
                                repeatPauseDuration: const Duration(milliseconds: 100),
                                repeat: true,
                                endRadius: 50.0,
                                child: Material(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(50),
                                  child: FloatingActionButton(onPressed: () { _listen(); }, child: Icon(_isListening ? Icons.mic : Icons.mic_none, color: Colors.white,)),
                                ),
                              ),
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: Material(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(50),
                                  child: IconButton(onPressed: () {  }, icon: const Icon(Icons.history, size: 20,), color: Colors.white,),
                                ),
                              )
                            ],
                          )

                        ],
                      ),
                    )),
            ],
          ),
        )
    ));
  }
}
