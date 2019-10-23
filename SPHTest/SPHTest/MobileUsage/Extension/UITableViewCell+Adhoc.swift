//
//  UITableViewCell+Adhoc.swift
//  SPHTest
//
//  Created by John Harries on 19/10/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    static func register(to tableView: UITableView, with identifier: String) {
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
}
