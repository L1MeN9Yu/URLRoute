//
// Created by Mengyu Li on 2020/12/26.
//

#if canImport(UIKit)
import UIKit

public protocol UIViewControllerType {
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> ())?)
}

extension UIViewController: UIViewControllerType {}

#endif
