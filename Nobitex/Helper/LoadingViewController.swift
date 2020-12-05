//
//  LoadingViewController.swift
//  Nobitex
//
//  Created by Sina Rabiei on 12/2/20.
//

import UIKit

class LoadingViewController: UIViewController {

    static let shared = LoadingViewController()
    
    var container = UIView()
    var indicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    func showWaiting() {
            let screenSize = UIScreen.main.bounds
            DispatchQueue.main.async {
                self.container.frame = CGRect(x: 0, y: 0, width: screenSize.width/2, height: screenSize.height/2)
                self.container.backgroundColor = .systemBackground
                
                self.indicatorView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
                self.indicatorView.center = self.container.center
                self.indicatorView.backgroundColor = .systemBackground
                self.indicatorView.clipsToBounds = true
                self.indicatorView.layer.cornerRadius = 10
                
                let indicatorViewSize = self.indicatorView.frame.size
                self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
                self.activityIndicator.style = UIActivityIndicatorView.Style.large
                self.activityIndicator.center = CGPoint(x: indicatorViewSize.width/2, y: indicatorViewSize.height/2)
                
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
