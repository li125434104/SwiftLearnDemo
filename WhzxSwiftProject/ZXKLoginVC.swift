//
//  LoginVC.swift
//  WhzxSwiftProject
//
//  Created by Applezxk on 2020/9/29.
//

import UIKit
import Alamofire

class ZXKLoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func loginButtonClick(_ sender: UIButton) {
        var parameters = [String: String]()
        parameters["mobile"] = "18514006518"
        parameters["password"] = "123456"
        parameters["uuid"] = "8udfhsajkjds8fa8ljlfkdasj"
        loginRequest(parameters: parameters)
    }

    func loginRequest(parameters: [String: String]) {     
//        ZXKNetworking.shared.requestGetWith(url: "app/advert") { (json) in
//            debugPrint(json)
//        } failed: { (error) in
//            debugPrint(error)
//        }

        ZXKNetworking.shared.requestPostWithParameters(url: "v1.1/user/login", parameters: parameters) { (json) in
            
        } failed: { (error) in
            
        }


    }
}
