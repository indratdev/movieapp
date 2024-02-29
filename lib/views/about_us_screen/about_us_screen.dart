import 'package:flutter/material.dart';
import 'package:movie_app/services/language_translation.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    void onLocaleChange(String languageCode) async {
      setState(() {
        LanguageTranslation.load(Locale(languageCode));
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LanguageTranslation.of(context)!.value('about_us')),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                onLocaleChange(value);
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'en',
                child: Text('English'),
              ),
              const PopupMenuItem(
                value: 'id',
                child: Text('Bahasa Indonesia'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              LanguageTranslation.of(context)!.value('title'),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              LanguageTranslation.of(context)!.value('title-des'),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              LanguageTranslation.of(context)!.value('contact-us'),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '${LanguageTranslation.of(context)!.value('email')}: Indrat.saputra@yahoo.com\n'
              '${LanguageTranslation.of(context)!.value('phone')}: 6285778379787',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
