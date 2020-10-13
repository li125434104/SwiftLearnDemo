//
//  LoginVC.swift
//  WhzxSwiftProject
//
//  Created by Applezxk on 2020/9/29.
//

import UIKit
import Alamofire

struct LoginParameters: Encodable {
    let mobile: String
    let password: String
}

class ZXKLoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func loginButtonClick(_ sender: UIButton) {
        let parameters = LoginParameters(mobile: "18514006518", password: "123456")
        loginRequest(parameters: parameters)
    }

    func loginRequest(parameters: LoginParameters) {
        print(parameters.mobile + "-----" + parameters.password)
     
        ZXKNetworking.shared.requestGetWith(url: "app/advert") { (json) in
            debugPrint(json)
        } failed: { (error) in
            debugPrint(error)
        }


    }
}
