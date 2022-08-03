//
//  ViewController.swift
//  Animations
//
//  Created by Burak AKCAN on 3.08.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myViewTopConstrait: NSLayoutConstraint!
    var isActive = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(myView.frame.origin.y)
       hideAlert()
    }
    @IBAction func buttonClick(_ sender: UIButton) {
       springAnimation(show: isActive)
    }
    
    private func animateShow(_ show:Bool){
        
        UIView.animate(withDuration: 1) {
            if show {
                self.hideAlert()
            }else{
                self.showAlert()
            }
            self.view.layoutIfNeeded()
        }
    }
    
    private func springAnimation(show:Bool){
        UIView.animate(withDuration: 1,
                       delay:0 ,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 0,
                       options: [.curveEaseInOut]) { [weak self] in
            if show {
                self?.hideAlert()
            }else{
                self?.showAlert()
            }
            self?.view.layoutIfNeeded()
        } completion: { _ in
            print("animation completed")
        }

    }
    
    private func showAlert(){
        isActive = true
        myViewTopConstrait.constant = 20
    }
    
    private func hideAlert(){
        isActive = false
        myViewTopConstrait.constant = -(myView.frame.origin.y) - myView.frame.height
    }

}

