//
//  ZXKNetworking.swift
//  WhzxSwiftProject
//
//  Created by Applezxk on 2020/10/10.
//

import Foundation
import Alamofire

public typealias NetworkingSuccessClosure = (_ Json: Any) -> Void
public typealias NetworkingFailedClosure = (_ error: String) -> Void

public enum ZXKReachabilityStatus {
    case unknown        //未知的
    case notReachable   //没有网络
    case wifi           //wifi网络
    case cellular       //移动网络
}

public enum HTTPMethod: Int {
    case get
    case post
    case put
    case delete
}

public class ZXKNetworking {
    public static let shared = ZXKNetworking()
    private var sessionManager: Alamofire.Session!
    var reachability: NetworkReachabilityManager?
    var networkStatus: ZXKReachabilityStatus = .unknown

    private init() {
        let config = URLSessionConfiguration.af.default
        config.timeoutIntervalForRequest = 20
        config.timeoutIntervalForResource = 20
        sessionManager = Alamofire.Session(configuration: config)
    }
    
    
    /// 无参数的Get请求
    /// - Parameters:
    ///   - url: url
    ///   - success: 成功的回调
    ///   - failed: 失败的回调
    public func requestGetWith(url: String,
                               success: @escaping NetworkingSuccessClosure,
                               failed: @escaping NetworkingFailedClosure) {
        request(url: url,
                httpMethod: HTTPMethod.get.rawValue,
                parameters: nil,
                success: success,
                failed: failed)
    }
    
    /// 有参数的Get请求
    /// - Parameters:
    ///   - url: url
    ///   - parameters: 参数
    ///   - success: 成功回调
    ///   - failed: 失败回调
    public func requestGetWithParameters(url: String,
                                         parameters: [String: Any]?,
                                         success: @escaping NetworkingSuccessClosure,
                                         failed: @escaping NetworkingFailedClosure) {
        request(url: url,
                httpMethod: HTTPMethod.get.rawValue,
                parameters: parameters,
                success: success,
                failed: failed)
    }
    
    public func request(url: String,
                        httpMethod: Int,
                        parameters: [String: Any]?,
                        success: @escaping NetworkingSuccessClosure,
                        failed: @escaping NetworkingFailedClosure) {
        if httpMethod == HTTPMethod.get.rawValue {
            managerGet(url: MainUrl + url, parameters: parameters, success: success, failed: failed)
        }
    }
    
    private func managerGet(url: String,
                            parameters: [String: Any]?,
                            success: @escaping NetworkingSuccessClosure,
                            failed: @escaping NetworkingFailedClosure) {
        //请求头信息
        var header = HTTPHeaders()
        header.add(name: "", value: "application/x-www-form-urlencoded")
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: header).responseJSON { (response) in
            switch response.result {
            case .success:
                let json = String(data: response.data!, encoding: String.Encoding.utf8)
                success(json as Any)
                
            case .failure:
                let statusCode = response.response?.statusCode
                failed("\(statusCode ?? 0)请求失败")
            }
        }
    }
    
}


