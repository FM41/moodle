# Moodle Flutter Coursework

This project is a mobile-first Flutter recreation of core Moodle screens using static, hardcoded data. The app focuses on the coursework requirements for layout, navigation, profile information, course content, assessments, calendar tasks, and authentication UI.

## Implemented Features

### Dashboard

- Static dashboard layout with Moodle-style cards and widgets.
- Welcome panel for the student.
- Quick stats for courses, deadlines, messages, and grades.
- Course progress cards.
- Upcoming deadlines list.
- Recent activity list.
- Mobile-friendly layout with responsive spacing.

Main file: `lib/views/dashboard_view.dart`

### Top App Bar and Navigation Drawer

- Reusable top app bar with Moodle logo, page title, search icon, notification icon, messages icon, and account menu.
- Side navigation drawer with grouped menu items:
  - Dashboard
  - Site home
  - Calendar
  - Private files
  - My courses
  - Current course
  - Participants
  - Grades
  - Badges
  - Profile
  - Help and support
  - Preferences
- Working navigation for Dashboard, Calendar, My courses, Current course, Grades, and Profile.
- Placeholder links remain for menu items that are not required to function yet.

Main files:

- `lib/widgets/top_app_bar.dart`
- `lib/widgets/nav_drawer.dart`

### Profile Page

- Static student profile page.
- Displays:
  - Full name: Oluwaferanmi Muraino
  - Student number: UP2248415
  - Email address: up2248415@myport.ac.uk
  - Role: Student
  - Institution: University of Portsmouth
  - Enrolled courses
- Profile can be opened from the account menu or side drawer.

Main file: `lib/views/profile_view.dart`

### Dummy Courses Page

- Static modules overview page.
- Displays module cards for:
  - Programming Language
  - Web Development
  - Database Systems
  - User Experience Design
- Each module card shows:
  - Module code
  - Module title
  - Tutor
  - Progress
  - Status
  - Next task
- Includes an upcoming coursework section.

Main file: `lib/views/courses_view.dart`

### Dummy Course Details Page

- Static details page for the Programming Language module.
- Opened by tapping the Programming Language course card or the Current course drawer item.
- Includes:
  - Module summary
  - Tutor and progress information
  - Moodle course link: https://moodle.port.ac.uk/course/view.php?id=2299
  - Announcements section
  - Learning materials section
  - Weekly practicals section
  - Assessments section

Main file: `lib/views/programming_language_view.dart`

### Dummy Assessments Page

- Static assessments page linked from the Grades drawer item.
- Shows hardcoded assessment information:
  - Assessment title
  - Module name
  - Due date
  - Status
  - Weight
- Includes summary cards for total, due soon, submitted, and pending assessments.

Main file: `lib/views/assessments_view.dart`

### Calendar Page

- Static Moodle-style calendar/deadlines page.
- Linked from the Calendar drawer item.
- Includes:
  - Moodle calendar link: https://moodle.port.ac.uk/calendar/view.php?view=month
  - July 2026 summary
  - Upcoming deadlines
  - Past tasks
  - Dates, times, modules, and statuses

Main file: `lib/views/calendar_view.dart`

### Authentication UI

- Static login page inspired by the Moodle login screen.
- Opened by choosing Log out from the account menu.
- Includes:
  - Moodle Cloud welcome header
  - OpenID Connect button
  - Username/email field
  - Password field
  - Log in button
  - Lost password link
  - Cookies notice and footer text
- Buttons and fields are visual only and do not perform authentication.

Main file: `lib/views/login_view.dart`

## App Routes

The app currently defines these routes in `lib/main.dart`:

| Route | Page |
| --- | --- |
| `/` | Dashboard |
| `/calendar` | Calendar |
| `/courses` | My courses |
| `/courses/programming-language` | Programming Language details |
| `/assessments` | Assessments |
| `/profile` | Profile |
| `/login` | Login |

## Project Structure

```text
lib/
  constants.dart
  main.dart
  views/
    assessments_view.dart
    calendar_view.dart
    courses_view.dart
    dashboard_view.dart
    login_view.dart
    profile_view.dart
    programming_language_view.dart
  widgets/
    nav_drawer.dart
    top_app_bar.dart
test/
  widget_test.dart
```

## Running the App

Install dependencies:

```bash
flutter pub get
```

Run in Chrome:

```bash
flutter run -d chrome
```

If Flutter is not on your system PATH, use the local SDK path:

```powershell
C:\Users\ofera\Downloads\flutter\bin\flutter.bat run -d chrome
```

## Testing and Checks

Run the analyzer:

```bash
flutter analyze
```

Run widget tests:

```bash
flutter test
```

Build for web:

```bash
flutter build web
```

The current code has been verified with:

- `flutter analyze --no-pub`
- `flutter test --no-pub`
- `flutter build web --no-pub`

## Notes

- All page data is hardcoded for coursework demonstration purposes.
- The app is designed mobile-first but also adapts to wider screens.
- Moodle links are included as visible references where relevant.
- Authentication, search, notifications, and placeholder drawer links are not connected to live services.
