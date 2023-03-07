import 'package:Prismaa/lang/en_us.dart';
import 'package:Prismaa/lang/fa_fa.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalizationService extends Translations{
  static const local = Locale('fa', 'FA');
  static const fallBackLocale = Locale('fa', 'FA');

  static final langs = ['English', 'Persian', 'Arabic'];
  static final locals = [
    const Locale('en', 'US'),
    const Locale('fa', 'FA'),
    const Locale('ar', 'AR'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US' : en_us,
    'fa_FA' : fa_fa,
  };

  Locale changeLocale(String lang){
    final locale = getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
    return locale;
  }

  Locale getLocaleFromLanguage(String lang){
    for(int i = 0; i < langs.length; i++){
      if(lang == langs[i]) return locals[i];
    }
    return Get.locale!;
  }


  Locale getLocale(){
    return Get.locale!;
  }

}