import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage();

  void _addPerson(XmlBuilder builder, {
    required String name,
    required String surname,
    required int age
  }) {
    builder.element('person', nest: () {
      builder.attribute('young', age <= 18);
      builder.element('name', nest: name);
      builder.element('surname', nest: surname);
      builder.element('age', nest: age);
    });
  }

  @override
  Widget build(BuildContext context) {

    var xmlString = '''
      <articles>
        <item>
          <name>Book</name>
          <quantity>5</quantity>
        </item>
        <item>
          <name>Tablet</name>
          <quantity>2</quantity>
        </item>
      </articles>
    ''';

    try {
      final xmlDoc = XmlDocument.parse(xmlString);
      // final output = xmlDoc.toXmlString(
      //   pretty: true,
      //   indent: '-'
      // );
      // print('output: \n$output');
      // xmlDoc.findAllElements('name')
      //     .map((item) => item.text)
      //     .forEach(print);

      // xmlDoc.findAllElements('item')
      //     .map((item) {
      //       final name = item.findElements('name').single.text;
      //       final qty = item.findElements('quantity').single.text;
      //
      //       return '$name {amount = $qty}';
      //     })
      //     .forEach(print);
      //
      // final tot = xmlDoc.findAllElements('item')
      //     .map((item) =>
      //         int.parse(item.findElements('quantity').single.text)
      //     )
      //     .reduce((a, b) => a + b);
      // print(tot);

      final builder = XmlBuilder();
      builder.processing('xml', 'version="1.0"');
      builder.element('people', nest: () {
        _addPerson(builder,
          name: 'RR',
          surname: 'Mendoza',
          age: 27
        );
        _addPerson(builder,
            name: 'Lala',
            surname: 'Quizora',
            age: 26
        );
      });
      final peopleXML = builder.buildDocument();
      final output = peopleXML.toXmlString(
        pretty: true,
        indent: '-'
      );
      print('output: \n$output');

    } on XmlParserException {

    }

    return Scaffold(
      appBar: AppBar(
        title: Text('XML Formatting'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hello')
          ],
        )
      ),
    );
  }
}

