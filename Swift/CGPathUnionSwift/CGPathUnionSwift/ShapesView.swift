//
//  ShapesView.swift
//  CGPathUnionSwift
//
//  Created by Don Mag on 6/30/23.
//

import UIKit

class ShapesView: UIView {

	private var theShapes: [MyShape] = []
	private let shapeLayer: CAShapeLayer = CAShapeLayer()
	private var activeIDX: Int = -1
	private var currentPT: CGPoint = .zero
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	func commonInit() {
		shapeLayer.fillColor = UIColor.clear.cgColor
		shapeLayer.strokeColor = UIColor.red.cgColor
		shapeLayer.lineWidth = 8.0
		shapeLayer.lineJoin = .round
		layer.addSublayer(shapeLayer)
	}
	
	func addShape(_ shape: MyShape) {
		theShapes.append(shape)
		setNeedsLayout()
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		guard let t = touches.first else { return }
		currentPT = t.location(in: self)
		activeIDX = -1
		for i in 0..<theShapes.count {
			let shape = theShapes[i]
			if shape.thePath.contains(currentPT, transform: .init(translationX: -shape.offset.x, y: -shape.offset.y)) {
				activeIDX = i
				break
			}
		}
	}
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesMoved(touches, with: event)
		guard activeIDX != -1, let t = touches.first else { return }
		let pt = t.location(in: self)
		theShapes[activeIDX].offset.x += (pt.x - currentPT.x)
		theShapes[activeIDX].offset.y += (pt.y - currentPT.y)
		currentPT = pt
		setNeedsLayout()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		var pth: CGPath!
		theShapes.forEach { shape in
			var t = CGAffineTransform(translationX: shape.offset.x, y: shape.offset.y)
			if let pr = shape.thePath.mutableCopy(using: &t) {
				if pth == nil {
					pth = pr
				} else {
					pth = pth.union(pr)
				}
			}
			//pth.addPath(shape.thePath, transform: .init(translationX: shape.offset.x, y: shape.offset.y))
		}
		shapeLayer.path = pth
//		if #available(iOS 116.0, *) {
//			shapeLayer.path = pth.normalized()
//		} else {
//			shapeLayer.path = pth
//		}
	}
	
}
