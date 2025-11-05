# Quick Start Guide - HomeScreen

## Immediate Integration

To use the new HomeScreen in your app right away, follow these steps:

### Step 1: Import the HomeScreen
```dart
import 'package:todo/home_screen1.dart';
```

### Step 2: Navigate to HomeScreen
Replace your existing home or add to your routes:

**Option A: Direct Navigation**
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const HomeScreen(),
  ),
);
```

**Option B: Set as Home in MaterialApp**
```dart
MaterialApp(
  home: const HomeScreen(userName: 'Ahmed Saber'),
  // ... other properties
)
```

**Option C: Named Routes**
```dart
MaterialApp(
  routes: {
    '/home': (context) => const HomeScreen(),
    // ... other routes
  },
  initialRoute: '/home',
)
```

### Step 3: Customize (Optional)
```dart
// With custom user name
const HomeScreen(userName: 'John Doe')

// Or dynamically
HomeScreen(userName: currentUser.name)
```

## What You'll See

When you run the app, the HomeScreen displays:

```
┌─────────────────────────────────┐
│  🏳️  Hello!                     │
│     Ahmed Saber                 │
├─────────────────────────────────┤
│                                 │
│         📁👤                    │
│    (Empty State Image)          │
│                                 │
│  There are no tasks yet,        │
│  press the button to add        │
│  a new task                     │
│                                 │
│                          ○[+]   │
└─────────────────────────────────┘
```

## Example: Complete Integration

Here's a complete example showing how to integrate HomeScreen:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen1.dart';
import 'core/app_resources.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.backgroundColor,
            textTheme: GoogleFonts.lexendDecaTextTheme(),
            fontFamily: GoogleFonts.lexendDeca().fontFamily,
          ),
          home: const HomeScreen(userName: 'Ahmed Saber'),
        );
      },
    );
  }
}
```

## Next Steps

1. **Add Task Creation**: Extend the `_addTask()` method to show a dialog or navigate to a task creation screen
2. **Task Storage**: Implement local storage (SharedPreferences, Hive, SQLite) or backend integration
3. **Task List**: When tasks exist, they'll automatically display in the task list view
4. **State Management**: Consider using Provider, Riverpod, or BLoC for more complex state management

## Example: Adding a Task Dialog

Here's how you might extend the `_addTask()` method:

```dart
void _addTask() async {
  final taskTitle = await showDialog<String>(
    context: context,
    builder: (context) {
      String title = '';
      return AlertDialog(
        title: const Text('New Task'),
        content: TextField(
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Task title'),
          onChanged: (value) => title = value,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, title),
            child: const Text('Add'),
          ),
        ],
      );
    },
  );

  if (taskTitle != null && taskTitle.isNotEmpty) {
    setState(() {
      tasks.add({'title': taskTitle, 'completed': false});
    });
  }
}
```

## Verification Checklist

After integration, verify:
- [ ] Header displays with avatar and user name
- [ ] Empty state shows when no tasks
- [ ] FAB is visible and positioned correctly
- [ ] Tapping FAB triggers the `_addTask()` method
- [ ] Layout is responsive on different screen sizes
- [ ] Colors and fonts match the design
- [ ] SVG illustration loads correctly

## Troubleshooting

### Issue: Assets not loading
**Solution**: Ensure `pubspec.yaml` includes:
```yaml
flutter:
  assets:
    - assets/
```

### Issue: Font not working
**Solution**: Check that `google_fonts` is in dependencies:
```yaml
dependencies:
  google_fonts: ^6.1.0
```

### Issue: SVG not displaying
**Solution**: Verify `flutter_svg` dependency:
```yaml
dependencies:
  flutter_svg: ^2.0.10+1
```

## Support

For detailed information, see:
- [HOME_SCREEN_USAGE.md](HOME_SCREEN_USAGE.md) - Complete usage guide
- [HOME_SCREEN_VISUAL.md](HOME_SCREEN_VISUAL.md) - Visual specifications
- [IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md) - Technical details

## Live Testing

To see the HomeScreen in action:
```bash
flutter run
```

Navigate to the HomeScreen and interact with:
1. The header section
2. The empty state view
3. The floating action button

---

**Ready to go!** 🚀 The HomeScreen is fully implemented and ready for task management features.
