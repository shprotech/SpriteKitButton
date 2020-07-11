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

/**
 A class that represents a button node in SpriteKit.
 */
class SKButtonNode: SKShapeNode {
    private var label: SKLabelNode
    
    /// The label of the button.
    var text: String {
        didSet {
            label.text = text
        }
    }
    #if !os(macOS)
    /// The color of the test inside the button.
    var textColor = UIColor.white {
        didSet {
            label.fontColor = textColor
        }
    }
    /// The fill color of the button.
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
    /// The color of the test inside the button.
    var textColor = NSColor.white {
        didSet {
            label.fontColor = textColor
        }
    }
    /// The fill color of the button.
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
    /// The font size of the button.
    var fontSize: CGFloat = 20.0 {
        didSet {
            label.fontSize = fontSize
        }
    }
    /// If set to true: the button won't respond to touches.
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
    /// The color of the button when highlighted.
    var highlightColor: UIColor
    /// The color of the button when disabled.
    var disabledColor: UIColor
    private var enabledColor: UIColor
    #else
    /// The color of the button when highlighted.
    var highlightColor: NSColor
    /// The color of the button when disabled.
    var disabledColor: NSColor
    private var enabledColor: NSColor
    #endif
    /// The state of the button.
    private(set) var state: SKButtonState = .normal
    
    /**
    Create a new button node.
     - Parameter size: The size of the button.
     - Parameter test: The test of the button.
     - Parameter cornerRadius: The radius of the corners of the button.
     */
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
    
    enum SKButtonState {
        case normal, highlighted, disabled
    }
}
