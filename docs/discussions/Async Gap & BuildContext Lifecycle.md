Related Class: DashboardPage (Presentation Layer / Member 1)

Error Code / Message
Do not use BuildContexts across async gaps.

Looked up a deactivated widget's ancestor to unsafe method call.

Explanation
In the initState of the Dashboard, we initiated a data load. Because initState runs before the widget is fully "mounted" in the tree, and loadFinanceData is an asynchronous operation, there was a risk that the context would become invalid if the user navigated away before the data finished loading.

The issue: Accessing context.read<FinanceProvider>() after an async gap without a safety check can cause the app to crash if the widget is no longer in the UI tree.
The Fix: We implemented a mounted check (if (!mounted) return;) and wrapped the call in WidgetsBinding.instance.addPostFrameCallback. This ensures the widget is fully rendered and still active before we attempt to use its context.