//
//  ViewController.swift
//  example
//
//  Created by Hoo's MacBookPro on 2022/01/17.
//

import UIKit
import SnapKit
import FirebaseAuth

class ViewController: UIViewController {
	let phoneNumberTextField = UITextField()
	let sendButton = UIButton()
	let authNumberTextField = UITextField()
	let signinButton = UIButton()
	private var verifyID: String?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		configure()
		
		
	}
	
	func configure() {
		[phoneNumberTextField, sendButton, authNumberTextField, signinButton].forEach {
			view.addSubview($0)
		}
		phoneNumberTextField.layer.borderColor = UIColor.black.cgColor
		phoneNumberTextField.layer.borderWidth = 1
		phoneNumberTextField.snp.makeConstraints {
			$0.top.equalTo(view).offset(100)
			$0.leading.equalTo(view).offset(30)
			$0.width.equalTo(250)
			$0.height.equalTo(70)
		}
		
		sendButton.setTitle("인증하기", for: .normal)
		sendButton.setTitleColor(.black, for: .normal)
		sendButton.addTarget(self, action: #selector(sendbuttonClicked), for: .touchUpInside)
		sendButton.snp.makeConstraints {
			$0.leading.equalTo(phoneNumberTextField.snp.trailing).offset(10)
			$0.top.equalTo(phoneNumberTextField.snp.top)
			$0.size.equalTo(70)
		}
		
		authNumberTextField.layer.borderColor = UIColor.black.cgColor
		authNumberTextField.layer.borderWidth = 1
		authNumberTextField.snp.makeConstraints {
			$0.leading.equalTo(phoneNumberTextField.snp.leading)
			$0.top.equalTo(phoneNumberTextField.snp.bottom).offset(10)
			$0.width.equalTo(phoneNumberTextField.snp.width)
			$0.height.equalTo(phoneNumberTextField.snp.height)
		}
		
		signinButton.setTitle("가입하기", for: .normal)
		signinButton.setTitleColor(.black, for: .normal)
		signinButton.addTarget(self, action: #selector(signinButtonClicked), for: .touchUpInside)
		signinButton.snp.makeConstraints {
			$0.leading.equalTo(authNumberTextField.snp.trailing).offset(10)
			$0.top.equalTo(authNumberTextField.snp.top)
			$0.size.equalTo(70)
		}
		
	}
	
	@objc func sendbuttonClicked() {
		print(#function)
		PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumberTextField.text ?? "", uiDelegate: nil) { varification, error in
			print(self.phoneNumberTextField.text!)
			if error == nil {
				self.verifyID = varification
			} else {
				print("Phone Varification Error: \(error.debugDescription)")
			}
		}
	}
	
	@objc func signinButtonClicked() {
		print(#function)
		let credential = PhoneAuthProvider.provider().credential(withVerificationID: verifyID ?? "", verificationCode: authNumberTextField.text ?? "" )
		
		Auth.auth().signIn(with: credential) { success, error in
			if error == nil {
				print(success ?? "")
				print("user Sign in...")
			} else {
				print(error.debugDescription)
			}
		}
	}

}

