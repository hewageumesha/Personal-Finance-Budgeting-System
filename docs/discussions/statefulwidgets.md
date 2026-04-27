- Birth - createState() - Flutter calls this to create the logic "container" for your StatefulWidget. It only happens once.

- Setup - initState()  - This is the "Constructor" for your UI. It runs exactly once before the widget is drawn. It's the best place to start loading data

- Reference - BuildContext - context is the widget's "Identity Card." It tells Flutter where the widget sits in the tree so it can find things (like your Provider) above it.

- action - context.read - This looks up the tree to find the FinanceProvider and calls a function on it without "listening" for changes.

