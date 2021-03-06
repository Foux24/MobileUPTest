//
//  Extension+UICollectionViewCell.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 26.03.2022.
//

import UIKit

// MARK: - Etension для UICollectionViewCell добавления reuseID для регистрации ячейки
protocol Reusable{}

extension UICollectionViewCell: Reusable {}

extension Reusable where Self: UICollectionViewCell {
    static var reuseID: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    
    func registerCell<Cell: UICollectionViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.reuseID)
    }
    
    func dequeueReusableCell<Cell: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: Cell.reuseID, for: indexPath)
                as? Cell else { fatalError("Fatal error for cell at \(indexPath)") }
        return cell
    }
}
