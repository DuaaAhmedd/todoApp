# Home Screen Usage Guide

## Overview
The `HomeScreen` widget (in `lib/home_screen1.dart`) implements the new UI design with the following features:

## Features

### 1. Header Section
- **Circular Avatar**: Displays a profile picture using the flag.png asset
- **Greeting**: Shows "Hello!" text
- **User Name**: Displays "Ahmed Saber" by default (configurable via constructor parameter)

### 2. Empty State
- Shown when there are no tasks
- Displays an SVG illustration (object3.svg)
- Shows the message: "There are no tasks yet, Press the button To add New Task"
- Centered layout with proper spacing

### 3. Floating Action Button (FAB)
- Green/teal circular button positioned at bottom-right
- Uses Material Icons add (+) icon
- Triggers the `_addTask()` method when pressed

## Usage

### Basic Usage
```dart
import 'package:flutter/material.dart';
import 'home_screen1.dart';

// In your navigation or main app
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const HomeScreen(),
  ),
);
```

### Custom User Name
```dart
// Specify a custom user name
const HomeScreen(userName: 'John Doe')
```

### Integration Example
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

## Design Details

### Colors
- **Background**: `AppColors.backgroundColor` (Light gray - #F3F5F4)
- **Primary/Accent**: `AppColors.primary` (Green - #149954)
- **Text**: `AppColors.fontColor` (Gray - #6E6A7C)

### Typography
- **Greeting**: Lexend Deca, 16px, Light (300)
- **User Name**: Lexend Deca, 20px, Semi-bold (600)
- **Empty State Message**: Lexend Deca, 16px, Regular (400)

### Spacing
- Header padding: 20px all around
- Avatar radius: 28px
- Empty state horizontal padding: 40px
- Spacing between avatar and text: 16px
- Spacing between illustration and message: 32px

### Assets Required
- `assets/flag.png` - Profile picture/avatar image
- `assets/object3.svg` - Empty state illustration

## Future Enhancements

The current implementation includes a placeholder for task management:
- `tasks` list to store task data
- `_buildTaskList()` method for displaying tasks when they exist
- `_addTask()` method that can be extended to add new tasks

To extend functionality:
1. Implement a task model
2. Add task creation dialog/screen
3. Implement task storage (local or remote)
4. Add task editing and deletion features
5. Implement task completion tracking
