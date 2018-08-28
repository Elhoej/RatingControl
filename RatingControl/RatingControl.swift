//
//  RatingControl.swift
//  RatingControl
//
//  Created by Simon Elhoej Steinmejer on 28/08/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

extension UIView {
    // "Flare view" animation sequence
    func performFlare() {
        func flare()   { transform = CGAffineTransform(scaleX: 1.6, y: 1.6) }
        func unflare() { transform = .identity }
        
        UIView.animate(withDuration: 0.3,
                       animations: { flare() },
                       completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
    }
}

class RatingControl: UIControl
{
    private let componentDimension: CGFloat = 40
    private let componentCount = 5
    private let componentActiveColor = UIColor.black
    private let componentInactiveColor = UIColor.gray
    var value = 1
    
    lazy var oneStarLabel: UILabel =
    {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: componentDimension, height: componentDimension))
        label.text = "★"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        label.tag = 1
        label.textColor = componentActiveColor
        
        return label
    }()
    
    lazy var twoStarLabel: UILabel =
        {
            let label = UILabel(frame: CGRect(x: componentDimension + 8, y: 0, width: componentDimension, height: componentDimension))
            label.text = "★"
            label.font = UIFont.boldSystemFont(ofSize: 32)
            label.textAlignment = .center
            label.tag = 2
            label.textColor = componentInactiveColor
            
            return label
    }()
    
    lazy var threeStarLabel: UILabel =
        {
            let label = UILabel(frame: CGRect(x: componentDimension * 2 + 16, y: 0, width: componentDimension, height: componentDimension))
            label.text = "★"
            label.font = UIFont.boldSystemFont(ofSize: 32)
            label.textAlignment = .center
            label.tag = 3
            label.textColor = componentInactiveColor
            
            return label
    }()
    
    lazy var fourStarLabel: UILabel =
        {
            let label = UILabel(frame: CGRect(x: componentDimension * 3 + 24, y: 0, width: componentDimension, height: componentDimension))
            label.text = "★"
            label.font = UIFont.boldSystemFont(ofSize: 32)
            label.textAlignment = .center
            label.tag = 4
            label.textColor = componentInactiveColor
            
            return label
    }()
    
    lazy var fiveStarLabel: UILabel =
        {
            let label = UILabel(frame: CGRect(x: componentDimension * 4 + 32, y: 0, width: componentDimension, height: componentDimension))
            label.text = "★"
            label.font = UIFont.boldSystemFont(ofSize: 32)
            label.textAlignment = .center
            label.tag = 5
            label.textColor = componentInactiveColor
            
            return label
    }()
    
    override var intrinsicContentSize: CGSize
    {
        let componentsWidth = CGFloat(componentCount) * componentDimension
        let componentsSpacing = CGFloat(componentCount + 1) * 8.0
        let width = componentsWidth + componentsSpacing
        return CGSize(width: width, height: componentDimension)
    }

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setup()
    }
    
    private func setup()
    {
        addSubview(oneStarLabel)
        addSubview(twoStarLabel)
        addSubview(threeStarLabel)
        addSubview(fourStarLabel)
        addSubview(fiveStarLabel)
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool
    {
        updateValue(at: touch)
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool
    {
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint)
        {
            self.updateValue(at: touch)
            sendActions(for: [.touchDragInside])
        }
        else
        {
            sendActions(for: [.touchDragOutside])
        }
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?)
    {
        guard let touch = touch else { return }
        let touchPoint = touch.location(in: self)
        
        if bounds.contains(touchPoint)
        {
            self.updateValue(at: touch)
            sendActions(for: [.touchUpInside])
        }
        else
        {
            sendActions(for: [.touchUpOutside])
        }
    }
    
    override func cancelTracking(with event: UIEvent?)
    {
        sendActions(for: [.touchCancel])
    }
    
    func updateValue(at touch: UITouch)
    {
        let touchPoint = touch.location(in: self)
        let labelArray = [oneStarLabel, twoStarLabel, threeStarLabel, fourStarLabel, fiveStarLabel]
        for label in labelArray
        {
            if label.frame.contains(touchPoint)
            {
                self.value = label.tag
                label.performFlare()
                sendActions(for: [.valueChanged])
            }
            
            if value < label.tag
            {
                label.textColor = componentInactiveColor
            }
            else if value >= label.tag
            {
                label.textColor = componentActiveColor
            }
        }
        
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}


















