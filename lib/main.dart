import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'screens/production_page.dart';
import 'screens/scenes_page.dart';
import 'screens/writing_page.dart';
import 'services/app_state.dart';
import 'services/story_store.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait<void>(<Future<void>>[
    AppState.instance.init(),
    StoryStore.instance.init(),
  ]);
  runApp(const TwilightApp());
}

class TwilightApp extends StatelessWidget {
  const TwilightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'استوديو الغسق',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      locale: const Locale('ar'),
      supportedLocales: const <Locale>[Locale('ar'), Locale('en')],
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const HomeShell(),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> with WidgetsBindingObserver {
  int _index = 0;

  static const List<String> _titles = <String>[
    'التأليف الروائي',
    'المشاهد والإخراج',
    'خطة الإنتاج',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // حفظ فوري عند خروج التطبيق للخلفية لتفادي فقدان الكتابة.
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      StoryStore.instance.saveNow();
    }
  }

  Future<void> _confirmClearStory() async {
    final bool? ok = await showDialog<bool>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: const Text('مسح مشروع التأليف'),
        content: const Text('سيتم حذف الفكرة والشخصيات والفصول نهائياً. هل أنت متأكد؟'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('مسح'),
          ),
        ],
      ),
    );
    if (ok == true) {
      await StoryStore.instance.clearAll();
      if (mounted) {
        // إعادة بناء الصفحة لتفريغ حقول الإدخال.
        setState(() => _index = 0);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(builder: (BuildContext _) => const HomeShell()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const List<Widget> pages = <Widget>[
      WritingPage(),
      ScenesPage(),
      ProductionPage(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_index]),
        actions: <Widget>[
          if (_index == 0)
            IconButton(
              tooltip: 'مسح مشروع التأليف',
              icon: const Icon(Icons.delete_sweep_outlined),
              onPressed: _confirmClearStory,
            ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: IndexedStack(index: _index, children: pages),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (int i) => setState(() => _index = i),
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.edit_note_outlined),
            selectedIcon: Icon(Icons.edit_note),
            label: 'التأليف',
          ),
          NavigationDestination(
            icon: Icon(Icons.movie_creation_outlined),
            selectedIcon: Icon(Icons.movie_creation),
            label: 'المشاهد',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_tree_outlined),
            selectedIcon: Icon(Icons.account_tree),
            label: 'الإنتاج',
          ),
        ],
      ),
    );
  }
}
