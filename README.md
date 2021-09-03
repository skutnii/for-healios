This is a test assignment written for a job interview. 
For the original assignment please refer to HEA-HMR-iOSEngineer-Test.pdf

I used my own implementation of JavaScript-style promises in Swift
(https://github.com/skutnii/easyasync) to deal with asynchronous
downloads. This small library is battle tested.

For the UI, I used a mix of SwiftUI and UIKit. In particular,
UINavigationController was used for navigation: this is because using
NavigationView/NavigationLink for master/detail interface tends to
result in eager initialization of everything instead of just the
active details view.

The details screen does not display all the user info just because I
thought that would be lots of not so interesting code.

Test coverage is not so extensive for the same reason: I just
demonstrated the most interesting (IMO) part: how view models can be
tested with mock objects and promises.

