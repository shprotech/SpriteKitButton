//
//  BBButtonNode.swift
//  Fake Ball Blast
//
//  Created by Shahar Melamed on 7/10/20.
//  Copyright © 2020 Shahar Melamed. All rights reserved.
//

#if !os(macOS)
import UIKit
#else
import AppKit
#endif
import SpriteKit

class SKButtonNode: SKShapeNode {
    private var label: SKLabelNode
    
    var text: String {
        didSet {
            label.text = text
        }
    }
    #if !os(macOS)
    var textColor = UIColor.white {
        didSet {
            label.fontColor = textColor
        }
    }
    override var fillColor: UIColor {
        get {
            return super.fillColor
        }
        
        set {
            super.fillColor = newValue
            enabledColor = newValue
        }
    }
    #else
    var textColor = NSColor.white {
        didSet {
            label.fontColor = textColor
        }
    }
    override var fillColor: NSColor {
        get {
            return super.fillColor
        }
        
        set {
            super.fillColor = newValue
            enabledColor = newValue
        }
    }
    #endif
    var fontSize: CGFloat = 20.0 {
        didSet {
            label.fontSize = fontSize
        }
    }
    var disabled: Bool {
        didSet {
            if disabled {
                isUserInteractionEnabled = false
                fillColor = disabledColor
                state = .disabled
            } else {
                isUserInteractionEnabled = true
                fillColor = enabledColor
                state = .normal
            }
        }
    }
    
    #if !os(macOS)
    var highlightColor: UIColor
    var disabledColor: UIColor
    private var enabledColor: UIColor
    #else
    var highlightColor: NSColor
    var disabledColor: NSColor
    private var enabledColor: NSColor
    #endif
    private(set) var state: SKButtonState = .normal
    
    init(size: CGSize, text: String, cornerRadius: CGFloat = 0) {
        self.label = SKLabelNode(text: text)
        self.text = text
        highlightColor = .clear
        disabledColor = .clear
        enabledColor = .clear
        disabled = false
        
        super.init()
        
        addChild(label)
        self.label.position.y = -label.frame.height / 2
        
        self.isUserInteractionEnabled = true
        self.path = CGPath(roundedRect: CGRect(origin: CGPoint(x: -size.width / 2, y: -size.height / 2),
                                               size: size),
                           cornerWidth: cornerRadius, cornerHeight: cornerRadius,
                           transform: nil)
        highlightColor = fillColor
        disabledColor = fillColor
        enabledColor = fillColor
    }
    
    #if !os(macOS)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.fillColor = highlightColor
        state = .highlighted
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.fillColor = enabledColor
        state = .normal
    }
    #else
    override func touchesBegan(with event: NSEvent?) {
        super.fillColor = highlightColor
        state = .highlighted
    }
    
    override func touchesEnded(with event: NSEvent?) {
        super.fillColor = enabledColor
        state = .normal
    }
    #endif
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum SKButtonState {
    case normal, highlighted, disabled
}
