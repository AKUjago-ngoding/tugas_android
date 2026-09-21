import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_application_2/routes/app_routes.dart';

void main() {
  testWidgets('Dashboard renders module catalog and stats correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify Dashboard title is shown
    expect(find.text('Katalog Tugas & Latihan'), findsOneWidget);

    // Verify stats exist
    expect(find.text('Total Modul'), findsOneWidget);
    expect(find.text('${AppRoutes.modules.length}'), findsOneWidget);

    // Verify category chips exist
    expect(find.text('Semua Modul'), findsOneWidget);
    expect(find.text('📚 Tugas Kuliah'), findsOneWidget);
    expect(find.text('🧪 Latihan Praktikum'), findsOneWidget);
  });
}
