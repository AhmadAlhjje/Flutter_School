import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_app/core/theme/app_colors.dart';
import 'package:student_app/shared/widgets/feedback.dart';

import '../support/test_app.dart';

void main() {
  Future<SnackBar> show(WidgetTester tester, String message, FeedbackTone tone) async {
    await tester.pumpWidget(
      localizedApp(
        Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () => showFeedback(ScaffoldMessenger.of(context), message, tone: tone),
              child: const Text('go'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('go'));
    await tester.pump();
    expect(find.text(message), findsOneWidget);
    return tester.widget<SnackBar>(find.byType(SnackBar));
  }

  testWidgets('a success message is green, with a check mark', (tester) async {
    final bar = await show(tester, 'تم تغيير كلمة المرور بنجاح', FeedbackTone.success);
    expect(bar.backgroundColor, AppColors.success);
    expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
  });

  testWidgets('a failure message is red', (tester) async {
    final bar = await show(tester, 'فشل التحميل', FeedbackTone.error);
    expect(bar.backgroundColor, AppColors.danger);
    expect(find.byIcon(Icons.error_rounded), findsOneWidget);
  });
}
