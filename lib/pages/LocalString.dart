import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class LocalString extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'hello': 'HELLO WROLD',
      'message': 'WELCOME TO SAHAJ APP',
      'title': 'Flutter Language - Localization',
      'sub': 'Subscribe now',
      'changelang': 'Change Language'
    },

    'hi_IN': {
      'hello': 'नमस्ते दुनिया',
      'message': 'सहज ऐप में आपका स्वागत है',
      'title': 'स्पंदन भाषा - स्थानीयकरण',
      'sub': 'अभी ग्राहक बनें',
      'changelang': 'भाषा बदलें'
    },

    'gn_IN': {
      'hello': 'હેલો વિશ્વ',
      'message': 'સહજ એપમાં આપનું સ્વાગત છે',
      'title': 'ફ્લટર ભાષા - સ્થાનિકીકરણ',
      'sub': 'અત્યારે જ નામ નોંધાવો',
      'changelang': 'ભાષા બદલો'
    }
  };
}