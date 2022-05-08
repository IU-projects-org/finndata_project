import 'package:finndata_project/constants/app_constants.dart';
import 'package:finndata_project/main.dart';
import 'package:finndata_project/utils/local_storage_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:integration_test/integration_test.dart';

Future<void> addDelay(int ms) async {
  await Future<void>.delayed(Duration(milliseconds: ms));
}

Future<void> logout(WidgetTester tester) async {
  await addDelay(600);
  await tester.tap(find.byKey(
    openSettingsKey,
  ));

  await addDelay(600);

  await tester.tap(find.byKey(
    logoutButtonKey,
  ));
  await addDelay(600);

  await tester.tap(find.byKey(
    yesButtonKey,
  ));

  await addDelay(4000);
  tester.printToConsole('Login screen opens');
  await tester.pumpAndSettle();
}

/// an integration test that first tests sign up, then logout, then login again
/// and test the logic of adding a stock to favourites(i.e subscribe), and check it in saved stocks screen
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // ignore: unnecessary_type_check
  if (binding is LiveTestWidgetsFlutterBinding) {
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
  }

  group('end-to-end test', () {
    final timeBasedEmail = '${DateTime.now().microsecondsSinceEpoch}@test.com';
    testWidgets('Authentication Testing', (WidgetTester tester) async {
      await Firebase.initializeApp();
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

/*Sign Up*/
      await tester.tap(find.byKey(openRegistrationScreenButtonKey));
      tester.printToConsole('SignUp screen opens');
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(emailKey), timeBasedEmail);
      await tester.enterText(find.byKey(passwordKey), 'test123');
      await SystemChannels.textInput.invokeMethod('TextInput.hide');
      await addDelay(5000);

      await tester.tap(find.byKey(registerButtonKey));
      await addDelay(10000);
      await tester.pumpAndSettle();

      expect(find.text('Market News'), findsOneWidget);

      await logout(tester);
    });

    testWidgets('Adding Stock to Favourites', (WidgetTester tester) async {
      await Firebase.initializeApp();
      await Hive.initFlutter();
      await StockSubscriptionsStorage().init();

      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      await addDelay(5000);
      await tester.enterText(find.byKey(emailKey), timeBasedEmail);
      await tester.enterText(find.byKey(passwordKey), 'test123');
      await SystemChannels.textInput.invokeMethod('TextInput.hide');
      await addDelay(1000);
      await tester.tap(find.byKey(loginButtonKey));

      await tester.tap(find.byKey(loginButtonKey));
      await addDelay(10000);
      await tester.pumpAndSettle();
      tester.printToConsole('Market News screen opens');

      await tester.tap(find.byKey(searchButtonKey));
      tester.printToConsole('Search Screen opens');

      await addDelay(10000);
      expect(find.text('Search on Symbol Stock'), findsOneWidget);

      /// adding first stock in the list to favourites
      await tester.tap(find.byKey(addFavouriteButtonKey).first);
      await addDelay(10000);

      final stockTitle =
          tester.firstWidget(find.byKey(favouriteDescriptionKey)) as Text;
      tester.printToConsole(stockTitle.data!);
      await addDelay(10000);

      await tester.tap(find.byKey(favouritesButtonKey));
      tester.printToConsole('My Stocks Screen opens');
      await addDelay(10000);
      expect(find.text('Saved Stocks'), findsOneWidget);

      /// expecting to see title of same stock we added
      expect(find.text(stockTitle.data!), findsOneWidget);

      await logout(tester);

      // await tester.ensureVisible(find.byType(ElevatedButton));
      // await tester.pumpAndSettle();
      // await tester.tap(find.byType(ElevatedButton));
      // await addDelay(4000);
      //
      // tester.printToConsole('New Idea added!');
      // await tester.pumpAndSettle();
      // await addDelay(1000);
      //
      // final state = tester.state(find.byType(Scaffold));
      // final title = Provider.of<IdeasModel>(state.context, listen: false)
      //     .getAllIdeas[0]
      //     .title;
      // await addDelay(1000);
      // final temp = title!;
      // await tester.drag(
      //   find.byKey(ValueKey(
      //     title.toString(),
      //   )),
      //   const Offset(-600, 0),
      // );
      // await addDelay(5000);
      //
      // expect(find.text(temp), findsNothing);
      // tester.printToConsole('Idea Deleted Successfully!!');
      // await logout(tester);
    });
  });
}
