//
//  SignInViewController.swift
//  QuanLyChiTieu
//
//  Created by lam quang quan on 4/8/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit
import Masonry

class SignInViewController: UIViewController {

    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lbCompany: UILabel!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var lbSepa: UILabel!
    @IBOutlet weak var lbOr: UILabel!
    @IBOutlet weak var btnSignInFacebook: UIButton!
    @IBOutlet weak var btnSignInGoogle: UIButton!
    
    var hItem:CGFloat!
    var paddingX:CGFloat!
    var paddingY:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupUIForView()
        
        let tapOnScreen:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(closeKeyboard))
        self.view.addGestureRecognizer(tapOnScreen)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.btnLogin.setTitle(NSLocalizedString("Login", comment: "").uppercased(), for: .normal)
        self.tfEmail.placeholder = NSLocalizedString("Email", comment: "")
        self.tfPassword.placeholder = NSLocalizedString("Password", comment: "")
        self.btnForgotPassword.setTitle(NSLocalizedString("Forgot password", comment: "").uppercased(), for: .normal)
        self.btnRegister.setTitle(NSLocalizedString("Register", comment: "").uppercased(), for: .normal)
        self.lbOr.text = NSLocalizedString("Or", comment: "")
        self.lbCompany.text = NSLocalizedString("Spend management", comment: "")
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLoginPress(_ sender: UIButton) {
    }
    
    @IBAction func btnForgotPasswordPress(_ sender: UIButton) {
    }
    
    @IBAction func btnRegisterPress(_ sender: UIButton) {
        let registerVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController
        self.navigationController?.pushViewController(registerVC!, animated: true)
    }
    
    @objc func closeKeyboard() {
        self.view.endEditing(false)
    }
    
    func setupUIForView() {
        
        let textColor:UIColor = UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
        
        hItem = 45.0
        paddingX = 30.0
        paddingY = 12.0
        
        self.btnLogin.backgroundColor = UIColor.init(red: 0, green: 0.686, blue: 0.94, alpha: 1.0)
        self.btnLogin.layer.cornerRadius = 5.0
        self.btnLogin.setTitleColor(UIColor.white, for: .normal)
        self.btnLogin.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        
        self.btnLogin.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.equalTo()(self.view)?.offset()(paddingX)
            make?.right.equalTo()(self.view)?.offset()(-paddingX)
            make?.centerY.equalTo()(self.view.mas_centerY)?.offset()(2*paddingY)
            make?.height.mas_equalTo()(hItem)
        }
        
        //  company
        self.lbCompany.textColor = textColor
        self.lbCompany.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        self.lbCompany.textAlignment = .center
        self.lbCompany.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.right().equalTo()(self.btnLogin)
            make?.bottom.equalTo()(self.tfEmail.mas_top)?.offset()(-2*paddingY)
            make?.height.mas_equalTo()(25.0)
        }
        
        self.imgLogo.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.centerX.equalTo()(self.view.mas_centerX)
            make?.bottom.equalTo()(self.lbCompany.mas_top)?.offset()(-5.0)
            make?.width.height().mas_equalTo()(100.0)
        }
        
        self.tfPassword.textColor = textColor
        self.tfPassword.borderStyle = UITextBorderStyle.none
        self.tfPassword.layer.borderColor = UIColor.init(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0).cgColor
        self.tfPassword.layer.borderWidth = 1.0
        self.tfPassword.layer.cornerRadius = 5.0
        self.tfPassword.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        self.tfPassword.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.bottom.equalTo()(self.btnLogin.mas_top)?.offset()(-paddingY);
            make?.left.right().equalTo()(self.btnLogin);
            make?.height.mas_equalTo()(hItem)
        }
        
        let btnPass:UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: hItem, height: hItem))
        btnPass.setImage(UIImage.init(named: "ic_lock"), for: .disabled);
        btnPass.imageEdgeInsets = UIEdgeInsetsMake(13, 13, 13, 13)
        btnPass.isEnabled = false
        
        self.tfPassword.leftView = btnPass;
        self.tfPassword.leftViewMode = .always
        
        //  username
        self.tfPassword.textColor = textColor
        self.tfEmail.borderStyle = .none
        self.tfEmail.layer.borderColor = UIColor.init(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0).cgColor
        self.tfEmail.layer.borderWidth = 1.0
        self.tfEmail.layer.cornerRadius = 5.0
        self.tfEmail.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        self.tfEmail.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.bottom.equalTo()(self.tfPassword.mas_top)?.offset()(-paddingY);
            make?.left.right().equalTo()(self.btnLogin);
            make?.height.mas_equalTo()(hItem)
        }
        
        let btnEmail:UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: hItem, height: hItem))
        btnEmail.setImage(UIImage.init(named: "ic_email"), for: .disabled);
        btnEmail.imageEdgeInsets = UIEdgeInsetsMake(13, 13, 13, 13)
        btnEmail.isEnabled = false
        
        self.tfEmail.leftView = btnEmail;
        self.tfEmail.leftViewMode = .always
        
        //  forgot password
        self.btnForgotPassword.contentHorizontalAlignment = .left
        self.btnForgotPassword.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        self.btnForgotPassword.setTitleColor(UIColor.init(red: 0, green: 0.686, blue: 0.94, alpha: 1.0), for: .normal)
        self.btnForgotPassword.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.equalTo()(self.btnLogin.mas_left)
            make?.top.equalTo()(self.btnLogin.mas_bottom)?.offset()(paddingY/2)
            make?.right.equalTo()(self.btnLogin.mas_centerX)
            make?.height.mas_equalTo()(hItem)
        }
        
        //  register button
        self.btnRegister.contentHorizontalAlignment = .right
        self.btnRegister.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        self.btnRegister.setTitleColor(UIColor.init(red: 0, green: 0.686, blue: 0.94, alpha: 1.0), for: .normal)
        self.btnRegister.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.right.equalTo()(self.btnLogin.mas_right)
            make?.top.bottom().equalTo()(self.btnForgotPassword)
            make?.left.equalTo()(self.btnLogin.mas_centerX)
        }
        
        //  Sepa
        self.lbOr.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        self.lbOr.textColor = textColor
        self.lbOr.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.centerX.equalTo()(self.view.mas_centerX)
            make?.top.equalTo()(self.btnForgotPassword.mas_bottom)?.offset()(paddingY)
            make?.width.mas_equalTo()(60.0)
            make?.height.mas_equalTo()(25.0)
        }
        
        self.lbSepa.backgroundColor = UIColor.init(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        self.lbSepa.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.centerY.equalTo()(self.lbOr.mas_centerY)
            make?.left.equalTo()(self.btnLogin.mas_left)
            make?.right.equalTo()(self.btnLogin.mas_right)
            make?.height.mas_equalTo()(1.0)
        }
        
        //  facebook button
        self.btnSignInFacebook.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        self.btnSignInFacebook.backgroundColor = UIColor.init(red: (49/255.0), green: (117/255.0), blue: (206/255.0), alpha: 1.0)
        self.btnSignInFacebook.layer.cornerRadius = 5.0
        self.btnSignInFacebook.setTitleColor(UIColor.white, for: .normal)
        self.btnSignInFacebook.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.right().equalTo()(self.btnLogin)
            make?.top.equalTo()(self.lbOr.mas_bottom)?.offset()(paddingY/2)
            make?.height.mas_equalTo()(hItem)
        }
        
        self.btnSignInGoogle.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        self.btnSignInGoogle.layer.borderColor = UIColor.init(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0).cgColor
        self.btnSignInGoogle.layer.borderWidth = 1.0
        self.btnSignInGoogle.layer.cornerRadius = 5.0
        self.btnSignInGoogle.setTitleColor(UIColor.darkGray, for: .normal)
        self.btnSignInGoogle.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.right().equalTo()(self.btnSignInFacebook)
            make?.top.equalTo()(self.btnSignInFacebook.mas_bottom)?.offset()(paddingY)
            make?.height.mas_equalTo()(hItem)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
