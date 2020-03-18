//
//  UIViewHelpers.swift
//  PageSpeed
//
//  Created by Alex on 2/24/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import UIKit

extension UIView {
    func makeCircular() {
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
        self.clipsToBounds = true
    }

    func makeRectangular() {
        self.layer.cornerRadius = 0
        self.clipsToBounds = false
    }

    func addTriangleLayer(fillColor: CGColor) {
        let width = self.frame.size.width
        let path = CGMutablePath()

        path.move(to: CGPoint(x: 0, y: width))
        path.addLine(to: CGPoint(x: width / 2, y: 0))
        path.addLine(to: CGPoint(x: width, y: width))
        path.addLine(to: CGPoint(x: 0, y: width))

        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = fillColor
        self.layer.addSublayer(shape)
    }

    func addCircleLayer(fillColor: CGColor) {
        let center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        let shape = CAShapeLayer()
        let path = UIBezierPath(
            arcCenter: center,
            radius: self.frame.size.width / 2,
            startAngle: 0,
            endAngle: 2 * CGFloat.pi,
            clockwise: true
        )
        shape.path = path.cgPath
        shape.fillColor = fillColor
        self.layer.addSublayer(shape)
    }

    func addRectangleLayer(fillColor: CGColor) {
        let width = self.frame.size.width
        let path = CGMutablePath()

        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: width))
        path.addLine(to: CGPoint(x: width, y: width))
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))

        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = fillColor
        self.layer.addSublayer(shape)
    }

    func popLastLayer() -> CALayer? {
        return self.layer.sublayers?.popLast()
    }

    func removeSublayers() {
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
    }

    func addTapGesture(numberOfTouchesRequired: Int, target: Any, action: Selector) {
        let tapRecognizer = UITapGestureRecognizer(target: target, action: action)
        tapRecognizer.numberOfTouchesRequired = numberOfTouchesRequired
        addGestureRecognizer(tapRecognizer)
        isUserInteractionEnabled = true
    }
}

@IBDesignable
class UIViewDesignable: UIView {
    @IBInspectable
    var makeCircular: Bool {
        get {
            return layer.cornerRadius > 0 ? true : false
        }
        set {
            if newValue {
                layer.cornerRadius = min(frame.size.height, frame.size.width) / 2.0
            } else {
                layer.cornerRadius = 0
            }
            self.clipsToBounds = newValue
        }
    }

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
