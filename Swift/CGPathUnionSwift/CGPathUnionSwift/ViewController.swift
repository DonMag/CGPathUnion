//
//  ViewController.swift
//  CGPathUnionSwift
//
//  Created by Don Mag on 6/30/23.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		var tapAction: UIAction!
		var cfg: UIButton.Configuration!
		
		cfg = UIButton.Configuration.filled()
		cfg.title = "The Basics"
		tapAction = UIAction { _ in
			self.basicsTapped()
		}

		let b1 = UIButton(configuration: cfg, primaryAction: tapAction)

		cfg = UIButton.Configuration.filled()
		cfg.title = "Dragging Demo"
		tapAction = UIAction { _ in
			self.demoTapped()
		}
		
		let b2 = UIButton(configuration: cfg, primaryAction: tapAction)
		
		[b1, b2].forEach { b in
			b.translatesAutoresizingMaskIntoConstraints = false
			view.addSubview(b)
		}
		
		let g = view.safeAreaLayoutGuide
		
		NSLayoutConstraint.activate([
		
			b1.topAnchor.constraint(equalTo: g.topAnchor, constant: 120.0),
			b1.centerXAnchor.constraint(equalTo: g.centerXAnchor, constant: 0.0),
			b1.widthAnchor.constraint(equalToConstant: 200.0),
			
			b2.topAnchor.constraint(equalTo: b1.bottomAnchor, constant: 40.0),
			b2.centerXAnchor.constraint(equalTo: g.centerXAnchor, constant: 0.0),
			b2.widthAnchor.constraint(equalToConstant: 200.0),
			
		])

	}

	func basicsTapped() {
		let vc = BasicsViewController()
		self.navigationController?.pushViewController(vc, animated: true)
	}
	func demoTapped() {
		let vc = DemoViewController()
		self.navigationController?.pushViewController(vc, animated: true)
	}

}

