//
// Created by Mengyu Li on 2020/12/26.
//

#if canImport(UIKit)
import UIKit

public protocol URLRouterProtocol: AnyObject {
    var delegate: URLRouterDelegate? { get set }

    func register(_ pattern: URLPattern, _ factory: @escaping ViewControllerFactory)
    func handle(_ pattern: URLPattern, _ factory: @escaping URLOpenHandlerFactory)

    func viewController(for url: URLConvertible, context: Any?) -> UIViewController?
    func handler(for url: URLConvertible, context: Any?) -> URLOpenHandler?

    @discardableResult
    func push(_ url: URLConvertible, context: Any?, from: UINavigationControllerType?, animated: Bool) -> UIViewController?

    @discardableResult
    func push(_ viewController: UIViewController, from: UINavigationControllerType?, animated: Bool) -> UIViewController?

    @discardableResult
    func present(_ url: URLConvertible, context: Any?, wrap: UINavigationController.Type?, from: UIViewControllerType?, animated: Bool, completion: (() -> ())?) -> UIViewController?

    @discardableResult
    func present(_ viewController: UIViewController, wrap: UINavigationController.Type?, from: UIViewControllerType?, animated: Bool, completion: (() -> ())?) -> UIViewController?

    @discardableResult
    func open(_ url: URLConvertible, context: Any?) -> Bool
}

// MARK: - Optional Parameters

public extension URLRouterProtocol {
    func viewController(for url: URLConvertible, context: Any? = nil) -> UIViewController? {
        viewController(for: url, context: context)
    }

    func handler(for url: URLConvertible, context: Any? = nil) -> URLOpenHandler? {
        handler(for: url, context: context)
    }

    @discardableResult
    func push(_ url: URLConvertible, context: Any? = nil, from: UINavigationControllerType? = nil, animated: Bool = true) -> UIViewController? {
        push(url, context: context, from: from, animated: animated)
    }

    @discardableResult
    func present(_ url: URLConvertible, context: Any? = nil, wrap: UINavigationController.Type? = nil, from: UIViewControllerType? = nil, animated: Bool = true, completion: (() -> ())? = nil) -> UIViewController? {
        present(url, context: context, wrap: wrap, from: from, animated: animated, completion: completion)
    }

    @discardableResult
    func open(_ url: URLConvertible, context: Any? = nil) -> Bool {
        open(url, context: context)
    }
}

#endif
