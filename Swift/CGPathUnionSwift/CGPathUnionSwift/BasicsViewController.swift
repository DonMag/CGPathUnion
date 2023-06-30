//
//  BasicsViewController.swift
//  CGPathUnionSwift
//
//  Created by Don Mag on 6/30/23.
//

import UIKit

class BasicsViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.title = "The Basics..."
		view.backgroundColor = .systemBackground
	
		let sv = UIStackView()
		sv.axis = .vertical
		sv.spacing = 4.0
		sv.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(sv)
		
		let g = view.safeAreaLayoutGuide
		
		NSLayoutConstraint.activate([
			
			sv.topAnchor.constraint(equalTo: g.topAnchor, constant: 20.0),
			sv.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
			sv.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),

		])
		
		let pathRects: [CGRect] = [
			.init(x: 60, y: 20, width: 100, height: 100),
			.init(x: 200, y: 60, width: 100, height: 100),
			.init(x: 100, y: 20, width: 100, height: 100),
			.init(x: 160, y: 60, width: 100, height: 100),
			.init(x: 100, y: 20, width: 100, height: 100),
			.init(x: 160, y: 60, width: 100, height: 100),
		]

		let titles: [String] = ["Two Paths", "Overlapped", "Union"]
		
		var i: Int = 0, j: Int = 0
		
		titles.forEach { s in
			let label = UILabel()
			label.text = s
			label.textAlignment = .center
			sv.addArrangedSubview(label)
			let v = UIView()
			v.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
			v.heightAnchor.constraint(equalToConstant: 180.0).isActive = true
			let sl = CAShapeLayer()
			sl.fillColor = UIColor.clear.cgColor
			sl.strokeColor = UIColor.blue.cgColor
			sl.lineWidth = 8.0
			sl.lineJoin = .round
			v.layer.addSublayer(sl)
			sv.addArrangedSubview(v)
			sv.setCustomSpacing(12.0, after: v)
			
			let r1 = pathRects[i]
			i += 1
			let r2 = pathRects[i]
			i += 1
			let pthA = CGPath(rect: r1, transform: nil)
			let pthB = CGPath(rect: r2, transform: nil)

			if (j == 0 || j == 1) {
				let pth = CGMutablePath()
				pth.addPath(pthA)
				pth.addPath(pthB)
				sl.path = pth
			} else {
				// union the paths
				let pth = pthA.union(pthB)
				sl.path = pth
			}
			j += 1

		}
		
	}
    
}
