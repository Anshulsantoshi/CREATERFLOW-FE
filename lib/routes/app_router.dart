import 'package:go_router/go_router.dart';

// --- EXISTING IMPORTS ---
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/signup_screen.dart';
import '../features/auth/screens/role_selection_screen.dart';
import '../features/home/screens/app_shell.dart';
import '../features/creator/screens/creator_profile_screen.dart';
import '../features/creator/screens/creator_dashboard_screen.dart';
import '../features/post/screens/post_detail_screen.dart';
import '../features/subscription/screens/subscribe_screen.dart';
import '../features/auth/screens/landing_page.dart';
import '../features/auth/screens/splash_screen.dart';
import '../features/home/screens/course_detail_screen.dart';

// --- NEW IMPORT (Ye add karna zaruri tha) ---
// Ensure ki learning_hub_screen.dart sahi folder (e.g., home/screens) mein ho
import '../features/home/screens/learning_hub_screen.dart';
import '../features/home/screens/my_collection_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
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
      GoRoute(
        path: '/course-details',
        builder: (context, state) => const CourseDetailsScreen(),
      ),

      // --- MISSING ROUTE ADDED ---
      // Payment success hone par user yahan aayega
      GoRoute(
        path: '/learning-hub',
        builder: (context, state) => const LearningHubScreen(),
      ),

      GoRoute(
        path: '/my-collection',
        builder: (context, state) => const MyCollectionScreen(),
      ),
    ],
  );
}