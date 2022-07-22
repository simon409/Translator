import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:translator/translator.dart';

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
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _speech = stt.SpeechToText();
  bool islistening = false;
  final _text = TextEditingController();
  final _translated = TextEditingController();

  var translator = GoogleTranslator();

  String dropdown1Value = "Select Language";
  String dropdown2Value = "Select Language";
  String translatedfrom = "";
  String translatedto = "";
  int from_trans = 0;
  int to_trans = 0;

  void translate() async {
    await translator.translate(_text.text, from: translatedfrom.toString(), to: translatedto.toString()).then((t) {
        setState(() {
          _translated.text = t.text;
        });
      });
  }

  void listen() async {
    if (!islistening) {
      bool available = await _speech.initialize(
        onStatus: (status) => print(status),
        onError: (error) => print(error),
      );

      if (available) {
        setState(() {
          islistening = true;
        });
        _speech.listen(
            onResult: (result) => setState(() {
                  _text.text = result.recognizedWords;
                  islistening = false;
                  //TODO: Translate
                  translate();
                }));
      }
    } else {
      setState(() {
        islistening = false;
        _speech.stop();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _speech = stt.SpeechToText();
    super.initState();

    _text.text = "";
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
    "Chinese (Simplifier)",
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
    "Greek",
    "Gujarati",
    "Haitian Creole",
    "Hausa",
    "Hawaiian",
    "Hebrew",
    "Hindi",
    "Hmong",
    "Hungarian",
    "Icelandic",
    "Igbo",
    "Indonesian",
    "Irish",
    "Italian",
    "Japanese",
    "Javanese",
    "Kannada",
    "Kazakh",
    "Khmer",
    "Kinyarwanda",
    "Korean",
    "Kurdish",
    "Kyrgyz",
    "Lao",
    "Latin",
    "Latvian",
    "Lithuanian",
    "Luxembourgish",
    "Macedonian",
    "Malagasy",
    "Malay",
    "Malayalam",
    "Maltese",
    "Maori",
    "Marathi",
    "Mongolian",
    "Myanmar",
    "Nepali",
    "Norwegian",
    "Nyanja",
    "Odia",
    "Pashto",
    "Persian",
    "Polish",
    "Portuguese",
    "Punjabi",
    "Romanian",
    "Russian",
    "Samoan",
    "Scots Gaelic",
    "Serbian",
    "Sesotho",
    "Shona",
    "Sindhi",
    "Sinhala",
    "Slovak",
    "Slovenian",
    "Somali",
    "Spanish",
    "Sundanese",
    "Swahili",
    "Swedish",
    "Tagalog",
    "Tajik",
    "Tamil",
    "Tatar",
    "Telugu",
    "Thai",
    "Turkish",
    "Turkmen",
    "Ukrainian",
    "Urdu",
    "Uyghur",
    "Uzbek",
    "Vietnamese",
    "Welsh",
    "Xhosa",
    "Yiddish",
    "Yoruba",
    "Zulu",
  ];
  var itemsshort = [
    "af",
    "sq",
    "am",
    "ar",
    "hy",
    "az",
    "eu",
    "be",
    "bn",
    "bs",
    "bg",
    "ca",
    "ceb",
    "zh",
    "zh-TW",
    "co",
    "hr",
    "cs",
    "da",
    "nl",
    "en",
    "eo",
    "et",
    "fi",
    "fr",
    "fy",
    "gl",
    "ka",
    "de",
    "el",
    "gu",
    "ht",
    "ha",
    "haw",
    "he",
    "hi",
    "hmn",
    "hu",
    "is",
    "ig",
    "id",
    "ga",
    "it",
    "ja",
    "jv",
    "kn",
    "kk",
    "km",
    "rw",
    "ko",
    "ku",
    "ky",
    "lo",
    "la",
    "lv",
    "lt",
    "lb",
    "mk",
    "mg",
    "ms",
    "ml",
    "mt",
    "mi",
    "mr",
    "mn",
    "my",
    "ne",
    "no",
    "ny",
    "or",
    "ps",
    "fa",
    "pl",
    "pt",
    "pa",
    "ro",
    "ru",
    "sm",
    "gd",
    "sr",
    "st",
    "sn",
    "sd",
    "si",
    "sk",
    "sl",
    "so",
    "es",
    "su",
    "sw",
    "sv",
    "tl",
    "tg",
    "ta",
    "tt",
    "te",
    "th",
    "tr",
    "tk",
    "uk",
    "ur",
    "ug",
    "uz",
    "vi",
    "cy",
    "xh",
    "yi",
    "yo",
    "zu",
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
                            const Text(
                              "Translator1",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 30,
                              ),
                            ),
                            //TODO: Text field
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(10),
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 0.0),
                                    child: TextFormField(
                                      maxLength: 5000,
                                      minLines: 10,
                                      onChanged: (text) {
                                        translate();
                                      },
                                      controller: _text,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText:
                                            "Enter to translate or Press the button and start speaking",
                                      ), // any number you need (It works as the rows for the textarea)
                                      textInputAction: TextInputAction.done,
                                      style: const TextStyle(fontSize: 15),
                                      maxLines: 10,
                                      onFieldSubmitted: (isVisible) {
                                        print("clicked");
                                      },
                                    )),
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 0.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        borderRadius: BorderRadius.circular(5),
                                        // Initial Value
                                        value: dropdown1Value,
                                        dropdownColor: Colors.blue,
                                        // Down Arrow Icon
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.white,
                                        ),
                                        // Array list of items
                                        items: items.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10)),
                                          );
                                        }).toList(),
                                        // After selecting the desired option,it will
                                        // change button value to selected value
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdown1Value = newValue!;
                                            from_trans = items.indexOf(newValue)-1;
                                            translatedfrom = itemsshort[from_trans].toString();
                                            translate();
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      String temp;
                                      temp = dropdown1Value;
                                      setState(() {
                                        dropdown1Value = dropdown2Value;
                                        dropdown2Value = temp;
                                      });
                                    },
                                    color: Colors.blue,
                                    icon: const Icon(Icons.sync_alt_outlined)),
                                DecoratedBox(
                                  decoration: const ShapeDecoration(
                                    color: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 0.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        // Initial Value
                                        value: dropdown2Value,
                                        dropdownColor: Colors.blue,
                                        // Down Arrow Icon
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.white,
                                        ),
                                        // Array list of items
                                        items: items.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10)),
                                          );
                                        }).toList(),
                                        // After selecting the desired option,it will
                                        // change button value to selected value
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdown2Value = newValue!;
                                            to_trans = items.indexOf(newValue)-1;
                                            translatedto = itemsshort[to_trans].toString();
                                            translate();
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 0.0),
                                  child: TextFormField(
                                    minLines: 6,
                                    controller: _translated,
                                    enabled: false,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Type to translate',
                                    ),
                                    maxLines: 6,
                                  )),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        Clipboard.setData(ClipboardData(
                                            text: _translated.text));
                                      });
                                      Fluttertoast.showToast(
                                          msg: "Copied to clipboard",
                                          gravity: ToastGravity.BOTTOM,
                                          fontSize: 16.0
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.copy,
                                      color: Colors.blue,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _text.text = "";
                                        _translated.text = "";
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.blue,
                                    )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Material(
                                  borderRadius: BorderRadius.circular(50),
                                  child: IconButton(
                                    onPressed: () {
                                      listen();
                                    },
                                    icon: const Icon(Icons.mic),
                                    color: Colors.white,
                                  ),
                                ),
                                AvatarGlow(
                                  animate: islistening,
                                  glowColor: Theme.of(context).primaryColor,
                                  duration: const Duration(milliseconds: 2000),
                                  repeatPauseDuration:
                                      const Duration(milliseconds: 100),
                                  repeat: true,
                                  endRadius: 50.0,
                                  child: Material(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(50),
                                    child: FloatingActionButton(
                                        onPressed: () {
                                          listen();
                                        },
                                        child: Icon(
                                          islistening
                                              ? Icons.mic
                                              : Icons.mic_none,
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Material(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(50),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.history,
                                        size: 20,
                                      ),
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )),
                ],
              ),
            )));
  }
}
