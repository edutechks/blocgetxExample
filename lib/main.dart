/** 
 * Provider Main Code 
 * 
*/

import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:helloworld/provider/common/theme.dart';
import 'package:helloworld/provider/models/cart.dart';
import 'package:helloworld/provider/models/catalog.dart';
import 'package:helloworld/provider/screens/cart.dart';
import 'package:helloworld/provider/screens/catalog.dart';
import 'package:helloworld/provider/screens/login.dart';
import 'package:window_size/window_size.dart';

void main() {
  setupWindow();
  runApp(const MyApp());
}

const double windowWidth = 400;
const double windowHeight = 800;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Provider Demo');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }
}

GoRouter router() {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const MyLogin(),
      ),
      GoRoute(
        path: '/catalog',
        builder: (context, state) => const MyCatalog(),
        routes: [
          GoRoute(
            path: 'cart',
            builder: (context, state) => const MyCart(),
          ),
        ],
      ),
    ],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        Provider(create: (context) => CatalogModel()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],
      child: MaterialApp.router(
        title: 'Provider Demo',
        theme: appTheme,
        routerConfig: router(),
      ),
    );
  }
}

/**
 * 
 * GetX Example Code Of Main
 */

// import 'package:flutter/material.dart';
// import 'package:helloworld/getx/users_page.dart';
// import 'package:get/get.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'User App',
//       //debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: UsersPage(),
//     );
//   }
// }

/**
 * 
 * BLoc Example Main Code
 */

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'counter_bloc.dart';
// import 'counter_event.dart';
// import 'counter_state.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<CounterBloc>(
//       create: (context) => CounterBloc(),
//       child: MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: const MyHomePage(),
//       ),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("Bloc Demo APP"),
//       ),
//       body: BlocBuilder<CounterBloc, CounterStates>(
//         builder: (context, state) {
//           if (state is InitialState) {
//             return _counter(context, 0);
//           }
//           if (state is UpdateState) {
//             return _counter(context, state.counter);
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }

// Widget _counter(BuildContext context, int counter) {
//   return Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           counter.toString(),
//           style: Theme.of(context).textTheme.headlineLarge,
//         ),
//         const SizedBox(
//           height: 50,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             MaterialButton(
//               color: Colors.red,
//               elevation: 0.0,
//               height: 50,
//               shape: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(8))),
//               child: const Text(
//                 "-",
//                 style: TextStyle(fontSize: 22, color: Colors.white),
//               ),
//               onPressed: () {
//                 context.read<CounterBloc>().add(NumberDecreaseEvent());
//               },
//             ),
//             const SizedBox(
//               width: 50,
//             ),
//             MaterialButton(
//               color: Colors.green,
//               elevation: 0.0,
//               height: 50,
//               shape: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(8))),
//               child: const Text(
//                 "+",
//                 style: TextStyle(fontSize: 22, color: Colors.white),
//               ),
//               onPressed: () {
//                 context.read<CounterBloc>().add(NumberIncreaseEvent());
//               },
//             ),
//           ],
//         )
//       ],
//     ),
//   );
// }
