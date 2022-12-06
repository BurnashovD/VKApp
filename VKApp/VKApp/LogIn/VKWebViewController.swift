// VKWebViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
import WebKit

/// WebView с входом в ВК
final class VKWebViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet private var vkWebView: WKWebView! {
        didSet {
            vkWebView.navigationDelegate = self
        }
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
    }

    // MARK: - Private methods

    private func loadWebView() {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.schemeComponent
        urlComponents.host = Constants.hostComponent
        urlComponents.path = Constants.pathComponent
        urlComponents.queryItems = [
            URLQueryItem(name: Constants.clientIdName, value: Constants.clientIdValue),
            URLQueryItem(name: Constants.displayItemName, value: Constants.displayItemValue),
            URLQueryItem(name: Constants.redirectItemName, value: Constants.redirectItemValue),
            URLQueryItem(name: Constants.scopeItemName, value: Constants.scopeItemValue),
            URLQueryItem(name: Constants.responseItemName, value: Constants.responseItemValue),
            URLQueryItem(name: Constants.vItemName, value: Constants.vItemValue),
            URLQueryItem(name: "revoke", value: "1")
        ]
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        vkWebView.load(request)
    }
}

/// Constants
extension VKWebViewController {
    private enum Constants {
        static let schemeComponent = "https"
        static let hostComponent = "oauth.vk.com"
        static let pathComponent = "/authorize"
        static let clientIdName = "client_id"
        static let clientIdValue = "51496459"
        static let displayItemName = "display"
        static let displayItemValue = "mobile"
        static let redirectItemName = "redirect_uri"
        static let redirectItemValue = "https://oauth.vk.com/blank.html"
        static let scopeItemName = "scope"
        static let scopeItemValue = "wall"
        static let responseItemName = "response_type"
        static let responseItemValue = "token"
        static let vItemName = "v"
        static let vItemValue = "5.131"
        static let accessTokenName = "access_token"
        static let userIdText = "user_id"
        static let urlPath = "/blank.html"
        static let separatorCharacter = "&"
        static let equalCharacter = "="
    }
}

// MARK: - WKNavigationDelegate

extension VKWebViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse: WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        guard let url = navigationResponse.response.url, url.path == Constants.urlPath,
              let fragment = url.fragment
        else { decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: Constants.separatorCharacter)
            .map { $0.components(separatedBy: Constants.equalCharacter) }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        guard let token = params[Constants.accessTokenName], let userId = params[Constants.userIdText],
              let intUserId = Int(userId) else { return }
        Session.shared.token = token
        Session.shared.userId = intUserId
        decisionHandler(.cancel)
        dismiss(animated: true)
    }
}
