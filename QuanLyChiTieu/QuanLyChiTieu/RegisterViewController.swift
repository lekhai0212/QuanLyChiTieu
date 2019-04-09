//
//  RegisterViewController.swift
//  QuanLyChiTieu
//
//  Created by lam quang quan on 4/8/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit
import Masonry
import CoreData
import Toast

class RegisterViewController: UIViewController {

    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var viewInfo: UIView!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lbSepa: UILabel!
    @IBOutlet weak var btnShowPass: UIButton!
    
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var lbHaveAccount: UILabel!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var icWaiting: UIActivityIndicatorView!
    
    var paddingY:CGFloat!
    var hItem:CGFloat!
    var accModel:AccountModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUIForView()
        
        let tapOnScreen:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(closeKeyboard))
        self.view.addGestureRecognizer(tapOnScreen)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if accModel == nil {
            accModel = AccountModel()
        }
        
        btnRegister.setTitle(NSLocalizedString("Register", comment: "").uppercased(), for: .normal)
        tfEmail.placeholder = NSLocalizedString("Email", comment: "")
        tfPassword.placeholder = NSLocalizedString("Password", comment: "")
        lbHaveAccount.text = NSLocalizedString("Already have an account?", comment: "")
        btnSignIn.setTitle(NSLocalizedString("Login", comment: "").uppercased(), for: .normal)
        self.title = NSLocalizedString("Register account", comment: "")
        
        btnShowPass.tag = 0
        tfPassword.isSecureTextEntry = true
        
        icWaiting.isHidden = true
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 0.686, blue: 0.94, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        accModel = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSignInPress(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnRegisterPress(_ sender: UIButton) {
        if tfEmail.text?.count == 0 || tfPassword.text?.count == 0 {
            
            let alertView = UIAlertController.init(title: nil, message: NSLocalizedString("Please complete all information", comment: ""), preferredStyle: .alert)
            let closeAction = UIAlertAction.init(title: NSLocalizedString("Close", comment: ""), style: .default) { (alert:UIAlertAction?) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(closeAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        
        icWaiting.isHidden = false
        icWaiting.startAnimating()
        
        self.closeKeyboard()
        
        let account:String = tfEmail.text!
        let exsits:Bool = accModel.checkAccountExists(username: account)
        if exsits {
            let alertView = UIAlertController.init(title: nil, message: NSLocalizedString("This account already exists!", comment: ""), preferredStyle: .alert)
            let closeAction = UIAlertAction.init(title: NSLocalizedString("Close", comment: ""), style: .default) { (alert:UIAlertAction?) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(closeAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        let password:String = tfPassword.text!
        let result:Bool = accModel.addNewAccount(username: account, password: password)
        
        if result {
            self.view.makeToast(NSLocalizedString("Your account has been registered successful", comment: ""), duration: 2.0, position: CSToastPositionCenter)
            self.perform(#selector(dismissView), with: nil, afterDelay: 2.0)
        }else{
            self.view.makeToast(NSLocalizedString("Failed to register, please try later", comment: ""), duration: 2.0, position: CSToastPositionCenter)
            self.perform(#selector(dismissView), with: nil, afterDelay: 2.0)
        }
        icWaiting.isHidden = true
        icWaiting.stopAnimating()
    }
    
    @IBAction func btnShowPassPress(_ sender: UIButton) {
        if sender.tag == 0 {
            sender.tag = 1
            sender.setImage(UIImage.init(named: "pass_show"), for: .normal)
            tfPassword.isSecureTextEntry = false
        }else{
            sender.tag = 0
            sender.setImage(UIImage.init(named: "pass_hide"), for: .normal)
            tfPassword.isSecureTextEntry = true
        }
    }
    
    @objc func dismissView (){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func closeKeyboard(){
        self.view.endEditing(true)
    }
    
    func setupUIForView() {
        paddingY = 30.0
        hItem = 45.0
        let textColor:UIColor = UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
        
        btnRegister.layer.cornerRadius = 5.0
        btnRegister.setTitleColor(UIColor.white, for: .normal)
        btnRegister.backgroundColor = UIColor.init(red: 0, green: 0.686, blue: 0.94, alpha: 1.0)
        btnRegister.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        btnRegister.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.equalTo()(self.view)?.offset()(paddingY)
            make?.right.equalTo()(self.view)?.offset()(-paddingY)
            make?.centerY.equalTo()(self.view.mas_centerY)?.offset()(2*paddingY)
            make?.height.mas_equalTo()(hItem)
        }
        
        //  view info
        viewInfo.layer.borderWidth = 1.0
        viewInfo.layer.cornerRadius = 5.0
        viewInfo.layer.borderColor = UIColor.init(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0).cgColor
        viewInfo.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.right().equalTo()(self.btnRegister)
            make?.bottom.equalTo()(self.btnRegister.mas_top)?.offset()(-paddingY)
            make?.height.mas_equalTo()(2*hItem)
        }
        
        //  email
        tfEmail.textColor = textColor
        tfEmail.borderStyle = .none
        tfEmail.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        tfEmail.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.left().right().equalTo()(self.viewInfo)
            make?.height.mas_equalTo()(hItem)
        }
        let btnEmail:UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: hItem, height: hItem))
        btnEmail.setImage(UIImage.init(named: "ic_email"), for: .disabled);
        btnEmail.imageEdgeInsets = UIEdgeInsetsMake(13, 13, 13, 13)
        btnEmail.isEnabled = false
        
        self.tfEmail.leftView = btnEmail;
        self.tfEmail.leftViewMode = .always
        
        //  password
        tfPassword.textColor = textColor
        tfPassword.borderStyle = .none
        tfPassword.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        tfPassword.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.bottom.left().right().equalTo()(self.viewInfo)
            make?.height.mas_equalTo()(hItem)
        }
        
        let btnPassword:UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: hItem, height: hItem))
        btnPassword.setImage(UIImage.init(named: "ic_lock"), for: .disabled);
        btnPassword.imageEdgeInsets = UIEdgeInsetsMake(13, 13, 13, 13)
        btnPassword.isEnabled = false
        
        self.tfPassword.leftView = btnPassword;
        self.tfPassword.leftViewMode = .always
        
        lbSepa.backgroundColor = UIColor.init(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        lbSepa.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.right().equalTo()(self.viewInfo)
            make?.centerY.equalTo()(self.viewInfo.mas_centerY);
            make?.height.mas_equalTo()(1.0)
        }
        
        btnShowPass.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        btnShowPass.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.bottom().equalTo()(self.tfPassword)
            make?.right.equalTo()(self.tfPassword.mas_right)
            make?.width.mas_equalTo()(hItem)
        }
        
        //  logo
        imgLogo.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.centerX.equalTo()(self.view.mas_centerX)
            make?.bottom.equalTo()(self.tfEmail.mas_top)?.offset()(-2*paddingY)
            make?.width.height().mas_equalTo()(100.0)
        }
        
        let sizeText:CGFloat = self.getSizeOfText(content: NSLocalizedString("Already have an account?", comment: ""), font: UIFont.systemFont(ofSize: 16.0, weight: .regular))
        let sizeButton:CGFloat = self.getSizeOfText(content: NSLocalizedString("Login", comment: "").uppercased(), font: UIFont.systemFont(ofSize: 16.0, weight: .regular))
        
        let originX:CGFloat = (UIScreen.main.bounds.size.width - (sizeText + 6.0 + sizeButton)) / 2
        
        lbHaveAccount.textColor = textColor
        lbHaveAccount.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        lbHaveAccount.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.equalTo()(self.view)?.offset()(originX)
            make?.top.equalTo()(self.btnRegister.mas_bottom)?.offset()(paddingY)
            make?.height.mas_equalTo()(hItem)
            make?.width.mas_equalTo()(sizeText+3.0)
        }
        
        btnSignIn.setTitleColor(UIColor.init(red: 0, green: 0.686, blue: 0.94, alpha: 1.0), for: .normal)
        btnSignIn.contentHorizontalAlignment = .left
        btnSignIn.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        btnSignIn.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.equalTo()(self.lbHaveAccount.mas_right)?.offset()(5.0)
            make?.top.bottom().equalTo()(self.lbHaveAccount)
            make?.width.mas_equalTo()(sizeButton+3.0)
        }
        
        icWaiting.activityIndicatorViewStyle = .gray
        icWaiting.alpha = 0.5
        icWaiting.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.left().bottom().right().equalTo()(self.view)
        }
    }
    
    func getSizeOfText(content:String, font:UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedStringKey.font: font]
        let size:CGSize = content.size(withAttributes: fontAttributes)
        return size.width
    }
}
