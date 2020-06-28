//
//  CCUIExtensions.swift
//  CodeChallenge
//
//  Created by Pravin Ghogare on 28/06/20.
//  Copyright © 2020 own. All rights reserved.
//

import UIKit

// MARK: - declare dequeue reusable Indentifier protocol
protocol ReusableIdentifier: class {
    static var defaultIdentifier: String { get }
}

// MARK: - extend dequeue reusable Indentifier protocol to return the name of the Cell
extension ReusableIdentifier where Self: UIView {
    static var defaultIdentifier: String {
        return NSStringFromClass(self)
    }
}

// MARK: - UITable view cell extends to conform the protocol
extension UITableViewCell: ReusableIdentifier { }

// MARK: - UITable view extends functionality to register the cell identifier based on the name of the class and return the cell with specified identifier
extension UITableView {
    func register<T:UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.defaultIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: type.defaultIdentifier, for: indexPath) as? T else {
            fatalError("unable to dequeue cell")
        }
        return cell
    }
}
