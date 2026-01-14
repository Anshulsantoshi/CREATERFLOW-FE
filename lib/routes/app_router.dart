import 'package:go_router/go_router.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/signup_screen.dart';
import '../features/auth/screens/role_selection_screen.dart';
import '../features/home/screens/app_shell.dart';
import '../features/creator/screens/creator_profile_screen.dart';
import '../features/creator/screens/creator_dashboard_screen.dart';
import '../features/post/screens/post_detail_screen.dart';
import '../features/subscription/screens/subscribe_screen.dart';
import '../features/auth/screens/landing_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/landing', // App ab yahan se shuru hogi
    routes: [
      GoRoute(
        path: '/landing',
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        path: '/role-selection',
        builder: (context, state) => const RoleSelectionScreen(),
      ),
      GoRoute(
        path: '/login/:role',
        builder: (context, state) {
          final role = state.pathParameters['role']!;
          return LoginScreen(role: role);
        },
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const AppShell(),
      ),
      GoRoute(
        path: '/creator-dashboard',
        builder: (context, state) => const CreatorDashboardScreen(),
      ),
      GoRoute(
        path: '/creator/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return CreatorProfileScreen(creatorId: id);
        },
      ),
      GoRoute(
        path: '/post/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return PostDetailScreen(postId: id);
        },
      ),
      GoRoute(
        path: '/subscribe/:creatorId',
        builder: (context, state) {
          final creatorId = state.pathParameters['creatorId']!;
          return SubscriptionsScreen(creatorId: creatorId);
        },
      ),
    ],
  );
}