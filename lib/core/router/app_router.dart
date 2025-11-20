import 'package:go_router/go_router.dart';

import '../../features/prompt/prompt_page.dart';
import '../../features/result/result_page.dart';
import 'app_routes.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const PromptPage(),
    ),
    GoRoute(
      path: AppRoutes.result,
      builder: (context, state) {
        final prompt = state.uri.queryParameters['prompt'] ?? '';
        return ResultPage(prompt: prompt);
      },
    ),
  ],
);
