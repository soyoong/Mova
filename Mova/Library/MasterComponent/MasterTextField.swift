//
//  MasterTextField.swift
//  Mova
//
//  Created by HauNguyen on 03/01/2566 BE.
//

import UIKit
import Foundation

class MasterTextField: UITextField {
    
    var backgroundNormal: UIColor? = .clear
    
    var backgroundSelected: UIColor? = .clear
    
    private var leftViewAction: (() -> Void)?
    
    private var rightViewAction: (() -> Void)?
    
    var contentInsets: UIEdgeInsets? = .zero {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    var contentPaddingVertical: CGFloat? = 0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    var contentPaddingHorizontal: CGFloat? = 0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    var inputPaddingHorizontal: CGFloat? = 0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    var inputPaddingVertical: CGFloat? = 0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupViews()
    }
    
    func setupViews() {
        
    }
    
    func setIconLeft(_ image: UIImage?, color: UIColor? = nil, size: CGFloat? = 16.0, for state: TextFieldState, action: (() -> Void)?) {
        self.leftViewAction = action
        
        var getImage = image?.resize(with: size!)

        if color != nil {
            getImage = getImage?.tintColor(color!)
        }
        
        let button = UIButton()
        button.imageView?.image = getImage
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(blockActionLeft), for: .touchUpInside)
        
        self.leftView = button
        self.leftViewMode = .always
    }
    
    func setIconRight(_ image: UIImage?, color: UIColor? = nil, size: CGFloat? = 16.0, for state: TextFieldState) {
        var getImage = image?.resize(with: size!)

        if color != nil {
            getImage = getImage?.tintColor(color!)
        }
        
        let button = UIButton()
        button.imageView?.image = getImage
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(blockActionRight), for: .touchUpInside)
        
        self.rightView = button
        self.rightViewMode = .always
    }
    
    func setPlaceholder(_ string: String? = "", color: UIColor? = .placeholder, textSize: CGFloat? = 14.0, font: UIFont? = nil) {
        self.attributedPlaceholder = NSAttributedString(
            string: string!,
            attributes: [
                .foregroundColor: color!,
                .font: (font ?? .regular(size: textSize!)!)
            ]
        )
    }
    
    func setBackgroundColor(color: UIColor, cornerRadius: CGFloat? = 12.0, for state: TextFieldState) {
        
        if state == .normal {
            self.backgroundNormal = color
            self.backgroundColor = color
        } else {
            self.backgroundSelected = color
        }
        self.layer.cornerRadius = cornerRadius!
    }
    
    func setBordered(color: UIColor, width: CGFloat? = 6, cornerRadius: CGFloat? = 14.0) {
        self.layer.borderWidth = width!
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = cornerRadius!
    }
    
    @objc private func blockActionLeft() {
        self.leftViewAction?()
    }
    
    @objc private func blockActionRight() {
        self.rightViewAction?()
    }
}

extension MasterTextField {
    
    enum TextFieldState {
        case normal
        case selected
    }
    
}

extension MasterTextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.textRect(forBounds: bounds)
        rect.origin.x += self.inputPaddingHorizontal!
        rect.size.width -= ((self.inputPaddingHorizontal! * 2) + self.contentPaddingHorizontal!)
        return rect
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.placeholderRect(forBounds: bounds)
        return rect
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.editingRect(forBounds: bounds)
        rect.origin.x += self.inputPaddingHorizontal!
        rect.size.width -= ((self.inputPaddingHorizontal! * 2) + self.contentPaddingHorizontal!)
        return rect
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += self.contentPaddingHorizontal!
        return rect
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x -= self.contentPaddingHorizontal!
        return rect
    }
    
    override var alignmentRectInsets: UIEdgeInsets {
        return self.contentInsets!
    }
    
}
