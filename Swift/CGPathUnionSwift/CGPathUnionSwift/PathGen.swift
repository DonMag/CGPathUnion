//
//  PathGen.swift
//  CGPathUnionSwift
//
//  Created by Don Mag on 6/30/23.
//

import UIKit

enum ShapeType : Int {
	case kSquare, kDiamond, kTriangle, kCircle, kPacMan, kPolygon
}

class PathGen: NSObject {

	func buildShape(_ s: ShapeType, in rect: CGRect) -> CGMutablePath {
		buildShape(s, in: rect, numSides: 0)
	}
	func buildShape(_ s: ShapeType, in rect: CGRect, numSides: Int) -> CGMutablePath {
		var newPath = CGMutablePath()
		switch s {
		case .kSquare:
			newPath = CGMutablePath(rect: rect, transform: nil)
			
		case .kCircle:
			newPath = CGMutablePath(ellipseIn: rect, transform: nil)
			
		case .kDiamond:
			newPath.move(to: .init(x: rect.midX, y: rect.minY))
			newPath.addLine(to: .init(x: rect.maxX, y: rect.midY))
			newPath.addLine(to: .init(x: rect.midX, y: rect.maxY))
			newPath.addLine(to: .init(x: rect.minX, y: rect.midY))
			newPath.closeSubpath()
			
		case .kTriangle:
			newPath.move(to: .init(x: rect.minX, y: rect.maxY))
			newPath.addLine(to: .init(x: rect.midX, y: rect.minY))
			newPath.addLine(to: .init(x: rect.maxX, y: rect.maxY))
			newPath.closeSubpath()
			
		case .kPacMan:
			var r: CGRect = rect
			r.origin = .zero
			r.size.height = r.size.width
			let cntr: CGPoint = .init(x: r.midX, y: r.midY)
			newPath.move(to: cntr)
			newPath.addArc(center: cntr, radius: r.width * 0.5, startAngle: .pi * 0.25, endAngle: .pi * 1.75, clockwise: false)
			newPath.closeSubpath()
			var tr = CGAffineTransform(scaleX: 1.0, y: rect.height / rect.width)
				.concatenating(.init(translationX: rect.origin.x, y: rect.origin.y))
			if let trPath = newPath.mutableCopy(using: &tr) {
				newPath = trPath
			}

		case .kPolygon:
			var r: CGRect = rect
			r.origin = .zero
			r.size.height = r.size.width
			let cntr: CGPoint = .init(x: r.midX, y: r.midY)
			let ptPath = CGMutablePath()
			let sPath = CGMutablePath()
			let radInc: CGFloat = (.pi * 2.0) / CGFloat(numSides)
			var startA: CGFloat = .pi * 1.5
			let pt: CGPoint = .init(x: r.midX, y: r.minY)
			ptPath.move(to: pt)
			sPath.move(to: pt)
			for _ in 0..<(numSides - 1) {
				ptPath.addArc(center: cntr, radius: r.size.width * 0.5, startAngle: startA, endAngle: startA + radInc, clockwise: true)
				sPath.addLine(to: ptPath.currentPoint)
				startA += radInc
			}
			sPath.closeSubpath()
			var tr = CGAffineTransform(scaleX: 1.0, y: rect.height / rect.width)
				.concatenating(.init(translationX: rect.origin.x, y: rect.origin.y))
			if let trPath = sPath.mutableCopy(using: &tr) {
				newPath = trPath
			}
			
		default:
			()
		}
		return newPath
	}

}
