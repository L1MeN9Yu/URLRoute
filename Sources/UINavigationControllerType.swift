//
// Created by Mengyu Li on 2020/12/26.
//

#if canImport(UIKit)
import UIKit

public protocol UINavigationControllerType {
    func pushViewController(_ viewController: UIViewController, animated: Bool)
}

extension UINavigationController: UINavigationControllerType {}

#endif
