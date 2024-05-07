import 'package:attendance/logic/cubit/send_image_cubit.dart';
import 'package:attendance/logic/progress_cubit/progress_cubit.dart';
import 'package:attendance/screens/face_capture.dart';
import 'package:attendance/utils/colors.dart';
import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FaceCamera.initialize();
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
        BlocProvider<ProgressCubit>(
          create: (context) {
            return ProgressCubit();
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
