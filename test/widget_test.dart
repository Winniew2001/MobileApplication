import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_application/app/pages/all_collections_page.dart';

void main() {
  testWidgets('collections has the right title', (WidgetTester tester) async {
    await tester.pumpWidget(AllCollectionsPage());
    final titleFinder = find.text("Collections");
  });
}
