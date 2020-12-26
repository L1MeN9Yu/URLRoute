//
// Created by Mengyu Li on 2020/12/26.
//

#if canImport(UIKit)
import UIKit

public protocol URLRouterDelegate: AnyObject {
    /// Returns whether the navigator should push the view controller or not. It returns `true` for
    /// default.
    func shouldPush(viewController: UIViewController, from: UINavigationControllerType) -> Bool

    /// Returns whether the navigator should present the view controller or not. It returns `true`
    /// for default.
    func shouldPresent(viewController: UIViewController, from: UIViewControllerType) -> Bool
}

public extension URLRouterDelegate {
    func shouldPush(viewController: UIViewController, from: UINavigationControllerType) -> Bool {
        true
    }

    func shouldPresent(viewController: UIViewController, from: UIViewControllerType) -> Bool {
        true
    }
}

#endif
