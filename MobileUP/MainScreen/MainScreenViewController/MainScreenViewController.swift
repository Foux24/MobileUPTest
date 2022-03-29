//
//  MainScreenViewController.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 26.03.2022.
//

import UIKit

// MARK: - MainScreenViewController
final class MainScreenViewController: UIViewController {
    
    /// Презентор
    private let presentor: MainScreenPresentorOutput
    
    /// Инициализтор
    init(presentor: MainScreenPresentorOutput) {
        self.presentor = presentor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// VIew
    private var mainScreenView: MainScreenView {
        return self.view as! MainScreenView
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        self.view = MainScreenView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestValidationToken()
        setupTargetBuuton()
    }
}

// MARK: - Private
private extension MainScreenViewController {

    /// Метод добавления таргета кнопке
    func setupTargetBuuton() {
        self.mainScreenView.authorisationVKButton.addTarget(self, action: #selector(showScreenOAuth), for: .touchUpInside)
    }
    
    /// Действие кнопки ( Переход на авторизацию )
    @objc func showScreenOAuth() {
        self.presentor.showScreenOAuth(mainViewController: self)
    }
    
    /// Проверка данных токена
    func dataValidation() {
        if Session.instance.session.token != nil && presentor.statusToken == 1 {
            self.presentor.showScreenMobileUPGallery()
        }
    }
    
    /// Запрос на валидность токена
    func requestValidationToken() {
        presentor.getStatusToken() {
            self.dataValidation()
        }
    }
}


