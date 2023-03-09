//
//  ViewController.swift
//  SparrowHW3
//
//  Created by Aliaksandr Miatnikau on 8.03.23.
//

import UIKit

class ViewController: UIViewController {
    
    let animator = UIViewPropertyAnimator(duration: 0.3, curve: .linear)
    var squareView: UIView {
        let square = UIView()
        let side = view.frame.width / 5
        square.frame = CGRect(x: view.layoutMargins.left, y: 100, width: side, height: side)
        square.backgroundColor = .systemBlue
        square.layer.cornerRadius = 15
        let endPoint = CGRect(x: view.frame.width - square.frame.width * 1.5, y: square.frame.origin.y, width: square.frame.width, height: square.frame.height)
        animator.pausesOnCompletion = true
        animator.addAnimations {
            square.frame = endPoint
            square.transform = CGAffineTransform(rotationAngle: .pi / 2).scaledBy(x: 1.5, y: 1.5)
        }
        return square
    }
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.frame = CGRect(x: view.layoutMargins.left, y: squareView.frame.width * 1.5 + view.layoutMargins.top * 8, width: view.frame.width - view.layoutMargins.left - view.layoutMargins.right, height: 20)
        slider.addTarget(self, action: #selector(self.changeValue(sender: )), for: .valueChanged)
        slider.addTarget(self, action: #selector(slide), for: .touchUpInside)
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        view.backgroundColor = .white
        
        view.addSubview(slider)
        view.addSubview(squareView)
    }
    
    @objc func changeValue(sender: UISlider) {
        animator.fractionComplete = CGFloat(sender.value)
    }
    
    @objc func slide() {
        if animator.isRunning {
            slider.value = Float(animator.fractionComplete)
        }
        slider.setValue(slider.maximumValue, animated: true)
        animator.startAnimation()
    }
}
