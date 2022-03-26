//
//  MainScreenViewController.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 26.03.2022.
//

import UIKit

// MARK: - MainScreenViewController
final class MainScreenViewController: UIViewController {
    
    private var mainScreenView: MainScreenView {
        return self.view as! MainScreenView
    }
    
    override func loadView() {
        super.loadView()
        self.view = MainScreenView()
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
