//
//  OAuthVKViewController.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 26.03.2022.
//

import UIKit
import WebKit

// MARK: -  OAuthVKViewController
final class OAuthVKViewController: UIViewController {
    
    /// Ссылка на презентор
    private let presentor: OAuthVKPresentorOutout
    
    /// Инициализтор
    init(presentor: OAuthVKPresentorOutout) {
        self.presentor = presentor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// UIView
    private var oAuthView: OAuthVKView {
        return self.view as! OAuthVKView
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        self.view = OAuthVKView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        self.presentor.loadLoginVK { [weak self] request in
            guard let self = self else { return }
            self.oAuthView.webView.load(request)
        }
        self.setupWebView()
    }
}

// MARK: - Extension WKNavigationDelegate
extension OAuthVKViewController: WKNavigationDelegate {
    
    /// Настройка нативного метода webView
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0 .components(separatedBy: "=")}
            .reduce ([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        if let token = params["access_token"], let userId = params["user_id"] {
            
            Session.instance.token = token
            Session.instance.userId = Int(userId) ?? 0
            
            print(token)
            print(userId)
            
            decisionHandler(.cancel)
            presentor.showMobileUPGallery()
        }
    }
}

// MARK: - Private
private extension OAuthVKViewController {
    
    /// Настроим WebView
    func setupWebView() {
        self.oAuthView.webView.navigationDelegate = self
    }
}
