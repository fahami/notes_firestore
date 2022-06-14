import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/features/auth/presentation/pages/forgot_password/forgot_password.dart';
import 'package:notes/features/auth/presentation/pages/login/login.dart';
import 'package:notes/features/auth/presentation/pages/onboard/onboard.dart';
import 'package:notes/features/todo/presentation/pages/error/error.dart';
import 'package:notes/features/auth/presentation/pages/register/register.dart';
import 'package:notes/features/todo/presentation/pages/note/note.dart';
import 'package:notes/features/todo/presentation/pages/notes/notes.dart';

class AppRouter {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const OnboardScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/notes',
        builder: (context, state) => NotesScreen(),
      ),
      GoRoute(
        path: '/note/new',
        builder: (context, state) => NoteDetailScreen(isNew: true),
      ),
      GoRoute(
        path: '/note/:id',
        builder: (context, state) => NoteDetailScreen(
          id: state.params['id'],
        ),
      ),
    ],
    errorBuilder: (context, state) => const ErrorScreen(),
    initialLocation: _auth.currentUser?.uid != null ? '/notes' : '/',
  );
}
