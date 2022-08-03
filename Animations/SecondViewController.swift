//
//  SecondViewController.swift
//  Animations
//
//  Created by Burak AKCAN on 3.08.2022.
//

import UIKit
import ProgressHUD

class SecondViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.animateFlag()
            self.animateRadius()
        })

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signClick(_ sender: UIButton) {
        guard validateEmail() else{
            shakeTextField(emailField)
            return
        }
        guard validatePassword() else{
            shakeTextField(passwordField)
            return
        }
        ProgressHUD.showSucceed("Sign In 👍🏻")
    }
    
    private func shakeTextField(_ field:UITextField){
        let animation = CAKeyframeAnimation(keyPath: "position.x")
        //current position then move x 10 position, x -10 position , x 10 position then start  position
        animation.values = [0,10,-10,10,0]
        animation.keyTimes = [0,0.08,0.25,0.42,0.5]
        animation.duration = 0.5
        animation.fillMode = .forwards
        animation.isAdditive = true
        animation.isRemovedOnCompletion = false
        
        field.layer.add(animation, forKey: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    private func animateFlag(){
       let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = CGFloat.pi * 2
        animation.duration = 3
        animation.repeatCount = .infinity
        
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        imageView.layer.add(animation, forKey:  nil)
    }
    private func animateRadius(){
//        UIView.animate(withDuration: 3, delay: 0, options: [.repeat,.autoreverse], animations: { [weak self] in
//            self?.imageView.layer.cornerRadius = 40
//        }, completion: nil)
        
        let animation = CABasicAnimation(keyPath: "cornerRadius")
        animation.fromValue = 0
        animation.toValue = 40
        animation.duration = 3
        animation.autoreverses = true
        animation.repeatCount = .infinity
        imageView.layer.add(animation, forKey: nil)
        
        
    }
    
    private func validateEmail()->Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

           let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailField.text!)
    }
    
    private func validatePassword()->Bool{
        guard passwordField.text != nil else {return false }
        if  passwordField.text!.count >= 8 {
            return true
        }else{
            return false
        }
        
        
    }

}
