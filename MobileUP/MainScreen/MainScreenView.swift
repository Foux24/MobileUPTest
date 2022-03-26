//
//  MainScreenView.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 26.03.2022.
//

import UIKit

// MARK: - MainScreenView
final class MainScreenView: UIView {
    
    /// Заголовок главного экрана
    private(set) lazy var headerMainScreenLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .customBlackColor
        label.font = UIFont(name: "SFProDisplay-Bold", size: 48)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Mobile Up\nGallery"
        return label
    }()
    
    /// Кнопка для авторизации в ВК
    private(set) lazy var authorisationVKButton: UIButton = {
        let button = UIButton()
        button.setTitle("Вход через VK", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .customBlackColor
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    /// Инициализтор
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setUIElementsInView()
        self.setConstreints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Private
private extension MainScreenView {
    
    /// Настройка View
    func setupView() {
        self.backgroundColor = .white
    }
    
    /// Добавления элементов на вью
    func setUIElementsInView() {
        self.addSubview(headerMainScreenLabel)
        self.addSubview(authorisationVKButton)
    }
    
    /// Растановка констрейнтов
    func setConstreints() {
        NSLayoutConstraint.activate([
            headerMainScreenLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 164),
            headerMainScreenLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            headerMainScreenLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            authorisationVKButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            authorisationVKButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            authorisationVKButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            authorisationVKButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    

}
