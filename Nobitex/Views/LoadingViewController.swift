//
//  LoadingViewController.swift
//  Nobitex
//
//  Created by Sina Rabiei on 12/2/20.
//

import UIKit

class LoadingViewController {
    
    var container = UIView()
    var indicatorView = UIView()
    static let shared = LoadingViewController()
    var activityIndicator = UIActivityIndicatorView()

    func showWaiting() {
        let screenSize = UIScreen.main.bounds
        DispatchQueue.main.async {
            self.container.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
            self.container.backgroundColor = UIColor(white: 0, alpha: 0.0)
            
            self.indicatorView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            self.indicatorView.center = self.container.center
            self.indicatorView.backgroundColor = UIColor(white: 0, alpha: 0.0)
            self.indicatorView.clipsToBounds = true
            self.indicatorView.layer.cornerRadius = 10
            
            
            let indicatorViewSize = self.indicatorView.frame.size
            self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            self.activityIndicator.style = .large
            self.activityIndicator.center = CGPoint(x: indicatorViewSize.width/2, y: indicatorViewSize.height/2)
            self.activityIndicator.color = .white
            
            self.indicatorView.addSubview(self.activityIndicator)
            self.container.addSubview(self.indicatorView)
            self.activityIndicator.startAnimating()
            
            UIView.animate(withDuration: 0.2) {
                self.container.backgroundColor = UIColor(white: 0, alpha: 0.3)
                self.indicatorView.backgroundColor = UIColor(white: 0, alpha: 0.7)
                UIApplication.shared.keyWindow?.addSubview(self.container)
            }
        }
    }

    func hideWaiting() {
        DispatchQueue.main.async {
            self.container.backgroundColor = UIColor(white: 0, alpha: 0.3)
            self.indicatorView.backgroundColor = UIColor(white: 0, alpha: 0.7)
            UIView.animate(withDuration: 0.2) {
                self.container.backgroundColor = UIColor(white: 0, alpha: 0.0)
                self.indicatorView.backgroundColor = UIColor(white: 0, alpha: 0.0)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.container.removeFromSuperview()
                self.activityIndicator.stopAnimating()
                
            }
        }
    }
}
