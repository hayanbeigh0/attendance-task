import 'package:attendance/logic/cubit/send_image_cubit.dart';
import 'package:attendance/screens/face_capture.dart';
import 'package:attendance/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SendImageCubit>(
          create: (context) {
            return SendImageCubit();
          },
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
          ),
          textTheme: GoogleFonts.encodeSansExpandedTextTheme(
            Theme.of(context).textTheme,
          ),
          useMaterial3: true,
        ),
        home: const FaceCapture(),
      ),
    );
  }
}
