//
//  MobileUsageTableViewCell.swift
//  SPHTest
//
//  Created by John Harries on 19/10/19.
//  Copyright © 2019 John Harries. All rights reserved.
//

import Foundation
import UIKit

protocol MobileUsageTableViewCellDelegate {
    func onDecreaseTapped()
}

public class MobileUsageTableViewCell: UITableViewCell {
    static let identifier: String = "MobileUsageTableViewCell"
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var imgDefault: UIImageView!
    @IBOutlet weak var imgDecrease: UIImageView!
    
    var delegate: MobileUsageTableViewCellDelegate?
    
    override public func awakeFromNib() {
        super.awakeFromNib()

        self.selectionStyle = .none
        self.imgDecrease.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onDecreaseTapped)))
    }
    
    @objc private func onDecreaseTapped() {
        self.delegate?.onDecreaseTapped()
    }
    
    func setImgToDecrease() {
        DispatchQueue.main.async {
            self.imgDecrease.isHidden = false
        }
    }
    
    func setImgToIncrease() {
        DispatchQueue.main.async {
            self.imgDecrease.isHidden = true
        }
    }
}
