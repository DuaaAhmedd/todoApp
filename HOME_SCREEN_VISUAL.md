# Home Screen Visual Layout

```
┌─────────────────────────────────────────┐
│  ╔═══════════════════════════════════╗  │
│  ║         HEADER SECTION            ║  │
│  ╠═══════════════════════════════════╣  │
│  ║  ┌────┐  Hello!                   ║  │
│  ║  │🏳️  │  Ahmed Saber              ║  │
│  ║  └────┘                            ║  │
│  ╚═══════════════════════════════════╝  │
│                                          │
│  ╔═══════════════════════════════════╗  │
│  ║      EMPTY STATE SECTION          ║  │
│  ║                                    ║  │
│  ║           ┌──────────┐             ║  │
│  ║           │          │             ║  │
│  ║           │  📁👤   │             ║  │
│  ║           │          │             ║  │
│  ║           └──────────┘             ║  │
│  ║    (Empty State Illustration)      ║  │
│  ║                                    ║  │
│  ║   There are no tasks yet,          ║  │
│  ║   Press the button To add          ║  │
│  ║   New Task                         ║  │
│  ║                                    ║  │
│  ╚═══════════════════════════════════╝  │
│                                          │
│                                          │
│                              ┌────────┐  │
│                              │   +    │  │
│                              └────────┘  │
│                               FAB        │
└─────────────────────────────────────────┘
```

## Component Breakdown

### 1. Header Section (Top)
```
┌─────────────────────────────────────────┐
│  Avatar  │  Hello!          │  Spacing  │
│  (56x56) │  Ahmed Saber     │           │
└─────────────────────────────────────────┘
   28px      16px gap          Flexible
   radius    
```

- **Avatar**: CircleAvatar with 28px radius, displaying flag.png
- **Text Column**: 
  - "Hello!" - 16px, light weight (300), gray color
  - "Ahmed Saber" - 20px, semi-bold (600), dark color
- **Spacing**: 20px padding all around

### 2. Empty State Section (Center)
```
┌─────────────────────────────────────────┐
│                                          │
│            Vertically Centered           │
│                                          │
│        ┌──────────────────┐              │
│        │   Illustration   │              │
│        │    200x200       │              │
│        └──────────────────┘              │
│                                          │
│           32px spacing                   │
│                                          │
│    "There are no tasks yet,              │
│     Press the button To add              │
│     New Task"                            │
│                                          │
└─────────────────────────────────────────┘
```

- **Illustration**: SVG (object3.svg), 200x200px
- **Message**: 
  - Text: Center-aligned
  - Font: Lexend Deca, 16px, regular (400)
  - Color: Gray (#6E6A7C)
  - Line height: 1.5
- **Padding**: 40px horizontal

### 3. Floating Action Button (Bottom-Right)
```
                          ┌──────────┐
                          │    +     │
                          └──────────┘
```

- **Position**: Bottom-right corner (default Flutter FAB position)
- **Color**: Green (#149954)
- **Icon**: Add/Plus icon, white color, 32px
- **Shape**: Circular
- **Elevation**: Material default elevation with shadow

## Color Scheme

| Element              | Color Code | Color Name    |
|---------------------|------------|---------------|
| Background          | #F3F5F4    | Light Gray    |
| Primary (FAB)       | #149954    | Teal/Green    |
| Text (Greeting)     | #6E6A7C    | Medium Gray   |
| Text (Name)         | Black87    | Dark Gray     |
| FAB Icon            | #FFFFFF    | White         |

## Typography

| Element            | Font         | Size | Weight | Color       |
|-------------------|--------------|------|--------|-------------|
| Greeting          | Lexend Deca  | 16px | 300    | #6E6A7C     |
| User Name         | Lexend Deca  | 20px | 600    | Black87     |
| Empty State Text  | Lexend Deca  | 16px | 400    | #6E6A7C     |

## Responsive Behavior

- Uses `SafeArea` to avoid system UI overlays
- Column layout with `Expanded` for content section
- Flexible sizing that adapts to different screen sizes
- Centered empty state that works on various device dimensions
- FAB automatically positions according to Material Design guidelines

## State Management

The screen has two states:

1. **Empty State** (tasks.isEmpty == true)
   - Shows illustration and message
   - Encourages user to add first task

2. **Task List State** (tasks.isNotEmpty == true)
   - Shows list of tasks
   - Scrollable content
   - Maintains header and FAB
