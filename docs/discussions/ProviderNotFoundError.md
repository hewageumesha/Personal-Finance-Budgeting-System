Error Code / Message
`Error: Could not find the correct Provider<FinanceProvider> above this DashboardPage Widget`

Explanation
This error occurred when the DashboardPage attempted to access the FinanceProvider via context.read or context.watch, but the widget tree couldn't find an instance of that provider in its ancestry.

The issue: In Flutter, the Provider package follows the widget tree hierarchy. If a provider is initialized inside a specific route or a child widget, sibling routes (like those managed by GoRouter) cannot "see" it. Because GoRouter often pushes pages as siblings rather than direct children, a provider must be placed globally at the root of the application to be accessible across different features.

The Fix: We moved the FinanceProvider initialization into the MultiProvider block within the main.dart file. By wrapping the MaterialApp.router at the highest possible level, we ensured that the FinanceProvider is available to every route in the app, satisfying the dependency requirements of the DashboardPage.


```dart
runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProviderr(authRepository)),
      ChangeNotifierProvider(create: (_) => FinanceProvider(financeRepository))
    ],
    child: MyApp(authProvider: authProvider),
  ));
```