import 'package:fire/Features/Posts/Presentation/Pages/post_page.dart';
import 'package:fire/Features/Posts/Presentation/bloc/AddDelete/add_del_bloc.dart';
import 'package:fire/Features/Posts/Presentation/bloc/post/post_bloc.dart';
import 'package:fire/Features/Posts/Presentation/bloc/post/post_event.dart';
import 'package:fire/global/app_them.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fire/injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.sl<PostBloc>()..add(GetAllPostEvent())),
          BlocProvider(create: (_) => di.sl<AddDelBloc>())
        ],
        child: MaterialApp(
          title: 'Social App',
          theme: appTheme,
          home:  const PostPage(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
