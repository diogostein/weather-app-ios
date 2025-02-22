//
//  UIView+Extensions.swift
//  Weather App
//
//  Created by Diogo Ishihara Stein on 17/06/24.
//

import Foundation
import UIKit

extension UIView {
    
    func setConstraintsToParent(_ parent: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: parent.topAnchor),
            self.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
        ])
    }
    
}
