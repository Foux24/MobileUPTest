//
//  MainScreenViewController.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 26.03.2022.
//

import UIKit

// MARK: - MainScreenViewController
final class MainScreenViewController: UIViewController {
    
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
        setupTargetBuuton()
    }
}

// MARK: - Private
private extension MainScreenViewController {
    
    /// Метод добавления таргета кнопке
    func setupTargetBuuton() {
        mainScreenView.authorisationVKButton.addTarget(self, action: #selector(transitNextScreen), for: .touchUpInside)
    }
    
    /// Действие кнопки ( переход на экран авторизации в ВК )
    @objc func transitNextScreen() {
        let oAuthController = OAuthVKBuilder.build()
        self.navigationController?.showDetailViewController(oAuthController, sender: .none)
    }
}
