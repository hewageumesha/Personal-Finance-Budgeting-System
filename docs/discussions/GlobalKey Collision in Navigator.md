Related Class: AppRouter & GoRouter Configuration (Infrastructure Layer)

Error Code / Message
Assertion failed: ... Multiple widgets used the same GlobalKey.

The key [GlobalObjectKey int#f88ad] was used by multiple widgets.

Explanation
This happened because the GoRouter instance was being recreated every time the AuthProvider notified the app of a state change (like logging in).

The issue: Our AppRouter used static final GlobalKeys for the rootNavigator and shellNavigator. When a new GoRouter was instantiated during a build cycle, it tried to assign these static keys to a new Navigator while the "old" Navigator was still holding them. Flutter rules dictate that a GlobalKey must be unique across the entire widget tree.
The Fix: We implemented a Singleton Pattern in the AppRouter. By using the ??= operator, we ensured that the GoRouter is only created once and the same instance (holding the unique keys) is reused throughout the app's lifecycle.