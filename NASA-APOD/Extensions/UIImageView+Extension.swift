//
//  UIImageView+Extension.swift
//  NASA-APOD
//
//  Created by Arnab Hore on 13/11/22.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(url: String?) {
        if let urlStr = url, let imgUrl = URL(string: urlStr) {
            self.kf.indicatorType = .activity
            self.kf.setImage(with: imgUrl)
        }
    }
}
