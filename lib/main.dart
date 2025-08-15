import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reptilog_flutter/pages/reptiles/detials.dart';
import 'package:reptilog_flutter/pages/reptiles/index.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(title: 'ReptiLog'),
    ),
    GoRoute(path: '/reptiles', builder: (context, state) => const ReptilesIndexPage()),
    GoRoute(
      path: '/reptiles/details/:id',
      builder: (context, state) {
        final String? reptileId = state.pathParameters['id'];
        return ReptileDetailsPage(reptileId: reptileId ?? '0');
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      routerConfig: _router,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FilledButton(
              onPressed: () {
                // Navigator.pushNamed(context, '/reptiles');
                context.go('/reptiles');
              },
              child: const Text('View Reptiles'),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
