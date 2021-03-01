import 'package:bible_app/model/resources/langauge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget(this.language,this.ontap);
  final Function ontap;
  final Language language;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 30,
        height: 30,
        decoration:  BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey,
          ),
          color: language.isDefault?Colors.orange:null,
        ),
      ),

      title: Text(language.name),
      subtitle: Text('Language- ${language.language??''}, Country-${language.country??'undefine'}'),
      onTap: ontap,
    );
  }
}
