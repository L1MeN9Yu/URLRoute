//
// Created by Mengyu Li on 2020/12/26.
//

#if canImport(UIKit)

import UIKit

public extension UIViewController {
    private class var sharedApplication: UIApplication? {
        UIApplication.shared
    }

    /// Returns the current application's top most view controller.
    class var topMost: UIViewController? {
        guard let currentWindows = sharedApplication?.windows else { return nil }
        var rootViewController: UIViewController?
        for window in currentWindows {
            if let windowRootViewController = window.rootViewController, window.isKeyWindow {
                rootViewController = windowRootViewController
                break
            }
        }

        return self.topMost(of: rootViewController)
    }

    /// Returns the top most view controller from given view controller's stack.
    class func topMost(of viewController: UIViewController?) -> UIViewController? {
        // presented view controller
        if let presentedViewController = viewController?.presentedViewController {
            return topMost(of: presentedViewController)
        }

        // UITabBarController
        if let tabBarController = viewController as? UITabBarController,
           let selectedViewController = tabBarController.selectedViewController
        {
            return topMost(of: selectedViewController)
        }

        // UINavigationController
        if let navigationController = viewController as? UINavigationController,
           let visibleViewController = navigationController.visibleViewController
        {
            return topMost(of: visibleViewController)
        }

        // UIPageController
        if let pageViewController = viewController as? UIPageViewController,
           pageViewController.viewControllers?.count == 1
        {
            return topMost(of: pageViewController.viewControllers?.first)
        }

        // child view controller
        for subview in viewController?.view?.subviews ?? [] {
            if let childViewController = subview.next as? UIViewController {
                return topMost(of: childViewController)
            }
        }

        return viewController
    }
}

#endif
