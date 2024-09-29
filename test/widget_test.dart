import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zivalezapp/main.dart'; // Ganti dengan jalur impor yang sesuai proyekmu

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Membangun aplikasi
    await tester.pumpWidget(ZivalezAPP());

    // Memverifikasi bahwa counter dimulai dari 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Ketuk tombol '+' dan jalankan kembali frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verifikasi bahwa counter telah bertambah.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
