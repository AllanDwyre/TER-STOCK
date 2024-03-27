import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_stock/login/screens/onbording.dart';
import 'constants/colors.dart';

void main() {
	runApp(const MyApp());
}

class MyApp extends StatelessWidget {
	const MyApp({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'HiveStock',
			debugShowCheckedModeBanner: false,
			theme: ThemeData(colorScheme: lightColorScheme, textTheme: GoogleFonts.urbanistTextTheme(Theme.of(context).textTheme),).copyWith(extensions: [lightCustomColors]),
			darkTheme: ThemeData(colorScheme: darkColorScheme, textTheme: GoogleFonts.urbanistTextTheme(Theme.of(context).textTheme)).copyWith(extensions: [darkCustomColors]),
			themeMode: ThemeMode.system,
			home: const SafeArea(child: OnBoardingWidget()), //todo : detect the user status (connected or disconnected)
		);
		/*
		POUR TESTER PAGE PRODUIT
		return MaterialApp(
			debugShowCheckedModeBanner: false,
			home: ProductScreen(products.first),
		);
		*/
	}
}
