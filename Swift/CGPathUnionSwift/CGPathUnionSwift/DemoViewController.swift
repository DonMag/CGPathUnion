//
//  DemoViewController.swift
//  CGPathUnionSwift
//
//  Created by Don Mag on 6/30/23.
//

import UIKit

class DemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

		self.title = "Drag the Shapes!"
		view.backgroundColor = .systemBackground
		
		let shapesView = ShapesView()
		shapesView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(shapesView)
	
		let g = view.safeAreaLayoutGuide

		NSLayoutConstraint.activate([
			
			shapesView.topAnchor.constraint(equalTo: g.topAnchor, constant: 20.0),
			shapesView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
			shapesView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),
			shapesView.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: -20.0),
			
		])

		var r =  CGRect(x: 40.0, y: 20.0, width: 100.0, height: 100.0)
		
		// create and arrange Square, Diamond, Triangle, Circle and PacMan shapes
		//	and add them to shapesView
		let shapes: [ShapeType] = [
			.kSquare, .kDiamond, .kTriangle, .kCircle, .kPacMan,
		]
		shapes.forEach { s in
			let p = PathGen().buildShape(s, in: r)
			let m = MyShape()
			m.thePath = p
			shapesView.addShape(m)
			if (r.origin.x > 40.0) {
				r.origin.x = 40.0;
				r.origin.y += r.size.height + 30.0;
			} else {
				r.origin.x += r.size.width + 60.0;
			}
		}

		// create and arrange a few polygons (5, 6, 7, 8 and 9 sides)
		//	and add them to shapesView
		for i in 5..<10 {
			let p = PathGen().buildShape(.kPolygon, in: r, numSides: i)
			let m = MyShape()
			m.thePath = p
			shapesView.addShape(m)
			if (r.origin.x > 40.0) {
				r.origin.x = 40.0;
				r.origin.y += r.size.height + 30.0;
			} else {
				r.origin.x += r.size.width + 60.0;
			}
		}
		
		shapesView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
    }

}
