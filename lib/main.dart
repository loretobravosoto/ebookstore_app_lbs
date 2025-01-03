import 'package:ebookstore_app/bloc/ebookstore_bloc.dart';
import 'package:ebookstore_app/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => EbookstoreBloc(),
      child: const MaterialApp(
        home: MainPage(),
      ),
    ),
  );
}
