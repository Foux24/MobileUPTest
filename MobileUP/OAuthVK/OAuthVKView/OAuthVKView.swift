//
//  OAuthVKView.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 26.03.2022.
//

import WebKit

// MARK: - VKAuthoristionView
final class OAuthVKView: UIView {
    
    /// Web View
    private(set) lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let view = WKWebView(frame: .zero, configuration: webConfiguration)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Инициализтор
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupWebView()
        self.setupConstreints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

//MARK: - Private
private extension OAuthVKView {
    
    /// Добавим UI на слои
    func setupWebView() {
        self.addSubview(webView)
    }
    
    /// Установка констрейнтов
    func setupConstreints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: self.topAnchor),
            webView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
