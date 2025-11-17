// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text from widgets, and verify that the values of widget properties
// are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:n3_flutter_gcs/main.dart'; // Ajuste 'n3_flutter_gcs' se o nome do seu pacote for outro

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    
    // LINHA INTENCIONALMENTE ERRADA PARA QUEBRAR O BUILD
    expect(find.text('1'), findsNothing); // Esta linha está correta...

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    
    // ESTA É A LINHA QUE VAI FALHAR O PIPELINE
    // O correto seria 'findsOneWidget', mas simulamos um erro.
    expect(find.text('1'), findsNothing); // <<-- ERRO SIMULADO
  });
}