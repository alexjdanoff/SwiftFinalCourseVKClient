//
//  UITextView.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 04.02.2022.
//

import UIKit

extension UITextView {
    func adjustUITextViewHeight() {
        self.translatesAutoresizingMaskIntoConstraints = true
        self.sizeToFit()
        self.isScrollEnabled = false
    }
}
