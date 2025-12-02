
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spotify/core/configs/theme/app_theme.dart';
import 'package:spotify/injection_container.dart';
import 'package:spotify/src/presentation/chose_mode/cubits/theme_cubit.dart';
import 'package:spotify/src/presentation/home/cubits/favorite_songs_cubit.dart';
import 'package:spotify/src/presentation/home/cubits/songs_cubit.dart';
import 'package:spotify/src/presentation/splash/screens/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// 1️⃣ Create the RouteObserver here (top-level)
final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 🧑‍💻 Choose environment:
  const String env = Environment.dev; // or Environment.dev

  configureDependencies(env);

  runApp(
    DevicePreview(
      enabled: false,
      // enabled: true,
      builder: (context) {
        return ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          splitScreenMode: true,
          useInheritedMediaQuery: true,
          builder: (context, child) {
            // CRITICAL: Configure ScreenUtil with DevicePreview's MediaQuery
            ScreenUtil.configure(
              data: MediaQuery.of(context),
            );
            return const MyApp();
          },
        );
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => SongsCubit()),
        BlocProvider(create: (_) => SongsThumbnailsCubit()),
        BlocProvider(create: (_) => FavoriteSongsCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) {
          return MaterialApp(
            builder: (context, child) {
              return DevicePreview.appBuilder(context, child!);
            },
            locale: DevicePreview.locale(context),
            title: 'Spotify Clone',
            theme: AppTheme.lighTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: mode,
            debugShowCheckedModeBanner: false,
            navigatorObservers: [
              routeObserver, // 2️⃣ Register it here
            ],
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
