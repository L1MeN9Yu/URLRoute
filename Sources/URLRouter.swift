//
// Created by Mengyu Li on 2020/12/26.
//

#if canImport(UIKit)
import UIKit

public typealias URLPattern = String
public typealias ViewControllerFactory = (_ url: URLConvertible, _ values: [String: Any], _ context: Any?) -> UIViewController?
public typealias URLOpenHandlerFactory = (_ url: URLConvertible, _ values: [String: Any], _ context: Any?) -> Bool
public typealias URLOpenHandler = () -> Bool

open class URLRouter: URLRouterProtocol {
    public let matcher = URLMatcher()
    open weak var delegate: URLRouterDelegate?

    private var viewControllerFactories = [URLPattern: ViewControllerFactory]()
    private var handlerFactories = [URLPattern: URLOpenHandlerFactory]()

    public init(delegate: URLRouterDelegate? = nil) {
        self.delegate = delegate
    }
}

public extension URLRouter {
    // MARK: Registering URLs

    /// Registers a view controller factory to the URL pattern.
    func register(_ pattern: URLPattern, _ factory: @escaping ViewControllerFactory) {
        viewControllerFactories[pattern] = factory
    }

    /// Registers an URL open handler to the URL pattern.
    func handle(_ pattern: URLPattern, _ factory: @escaping URLOpenHandlerFactory) {
        handlerFactories[pattern] = factory
    }

    /// Returns a matching view controller from the specified URL.
    ///
    /// - parameter url: An URL to find view controllers.
    ///
    /// - returns: A match view controller or `nil` if not matched.
    func viewController(for url: URLConvertible, context: Any? = nil) -> UIViewController? {
        let urlPatterns = Array(viewControllerFactories.keys)
        guard let match = matcher.match(url, from: urlPatterns) else { return nil }
        guard let factory = viewControllerFactories[match.pattern] else { return nil }
        return factory(url, match.values, context)
    }

    /// Returns a matching URL handler from the specified URL.
    ///
    /// - parameter url: An URL to find url handlers.
    ///
    /// - returns: A matching handler factory or `nil` if not matched.
    func handler(for url: URLConvertible, context: Any? = nil) -> URLOpenHandler? {
        let urlPatterns = Array(handlerFactories.keys)
        guard let match = matcher.match(url, from: urlPatterns) else { return nil }
        guard let handler = handlerFactories[match.pattern] else { return nil }
        return { handler(url, match.values, context) }
    }

    // MARK: Push

    /// Pushes a matching view controller to the navigation controller stack.
    ///
    /// - note: It is not a good idea to use this method directly because this method requires all
    ///         parameters. This method eventually gets called when pushing a view controller with
    ///         an URL, so it's recommended to implement this method only for mocking.
    @discardableResult
    func push(_ url: URLConvertible, context: Any? = nil, from: UINavigationControllerType? = nil, animated: Bool = true) -> UIViewController? {
        guard let viewController = viewController(for: url, context: context) else { return nil }
        return push(viewController, from: from, animated: animated)
    }

    /// Pushes the view controller to the navigation controller stack.
    ///
    /// - note: It is not a good idea to use this method directly because this method requires all
    ///         parameters. This method eventually gets called when pushing a view controller, so
    ///         it's recommended to implement this method only for mocking.
    @discardableResult
    func push(_ viewController: UIViewController, from: UINavigationControllerType? = nil, animated: Bool = true) -> UIViewController? {
        guard (viewController is UINavigationController) == false else { return nil }
        guard let navigationController = from ?? UIViewController.topMost?.navigationController else { return nil }
        guard delegate?.shouldPush(viewController: viewController, from: navigationController) != false else { return nil }
        navigationController.pushViewController(viewController, animated: animated)
        return viewController
    }

    // MARK: Present

    /// Presents a matching view controller.
    ///
    /// - note: It is not a good idea to use this method directly because this method requires all
    ///         parameters. This method eventually gets called when presenting a view controller with
    ///         an URL, so it's recommended to implement this method only for mocking.
    @discardableResult
    func present(_ url: URLConvertible, context: Any? = nil, wrap: UINavigationController.Type? = nil, from: UIViewControllerType? = nil, animated: Bool = true, completion: (() -> ())? = nil) -> UIViewController? {
        guard let viewController = viewController(for: url, context: context) else { return nil }
        return present(viewController, wrap: wrap, from: from, animated: animated, completion: completion)
    }

    /// Presents the view controller.
    ///
    /// - note: It is not a good idea to use this method directly because this method requires all
    ///         parameters. This method eventually gets called when presenting a view controller, so
    ///         it's recommended to implement this method only for mocking.
    @discardableResult
    func present(_ viewController: UIViewController, wrap: UINavigationController.Type? = nil, from: UIViewControllerType? = nil, animated: Bool = true, completion: (() -> ())? = nil) -> UIViewController? {
        guard let fromViewController = from ?? UIViewController.topMost else { return nil }

        let viewControllerToPresent: UIViewController
        if let navigationControllerClass = wrap, (viewController is UINavigationController) == false {
            viewControllerToPresent = navigationControllerClass.init(rootViewController: viewController)
        } else {
            viewControllerToPresent = viewController
        }

        guard delegate?.shouldPresent(viewController: viewController, from: fromViewController) != false else { return nil }
        fromViewController.present(viewControllerToPresent, animated: animated, completion: completion)
        return viewController
    }

    // MARK: Open

    /// Executes an URL open handler.
    ///
    /// - note: It is not a good idea to use this method directly because this method requires all
    ///         parameters. This method eventually gets called when opening an url, so it's
    ///         recommended to implement this method only for mocking.
    @discardableResult
    func open(_ url: URLConvertible, context: Any? = nil) -> Bool {
        guard let handler = handler(for: url, context: context) else { return false }
        return handler()
    }
}

#endif
