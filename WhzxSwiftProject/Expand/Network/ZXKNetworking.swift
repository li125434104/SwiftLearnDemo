//
//  ZXKNetworking.swift
//  WhzxSwiftProject
//
//  Created by Applezxk on 2020/10/10.
//

import Foundation
import Alamofire

public typealias NetworkingSuccessClosure = (_ json: Any) -> Void
public typealias NetworkingFailedClosure = (_ error: NetworkingError) -> Void

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

public struct NetworkingError {
    var code: Int
    var localizedDescription: String
    var error: AFError
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
    
    public func requestPostWithParameters(url: String,
                                          parameters: [String: Any]?,
                                          success: @escaping NetworkingSuccessClosure,
                                          failed: @escaping NetworkingFailedClosure) {
         request(url: url,
                 httpMethod: HTTPMethod.post.rawValue,
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
            manageGet(url: MainUrl + url, parameters: parameters, success: success, failed: failed)
        }
        else if httpMethod == HTTPMethod.post.rawValue {
            managePost(url: MainUrl + url, parameters: parameters, success: success, failed: failed)
        }
    }
    
    /// Get请求
    /// - Parameters:
    ///   - url: url
    ///   - parameters: 参数
    ///   - success: 成功回调
    ///   - failed: 失败回调
    private func manageGet(url: String,
                           parameters: [String: Any]?,
                           success: @escaping NetworkingSuccessClosure,
                           failed: @escaping NetworkingFailedClosure) {
        //请求头信息
        var header = HTTPHeaders()
        header.add(name: "", value: "application/x-www-form-urlencoded")
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: header).responseJSON { (response) in
            
            self.handleResponse(response: response, successClosure: success, failedClosure: failed)

        }
    }
    
    /// Post请求
    /// - Parameters:
    ///   - url: url
    ///   - parameters: 参数
    ///   - success: 成功回调
    ///   - failed: 失败回调
    private func managePost(url: String,
                            parameters: [String: Any]?,
                            success: @escaping NetworkingSuccessClosure,
                            failed: @escaping NetworkingFailedClosure) {
        //请求头信息
        var header = HTTPHeaders()
        header.add(name: "", value: "application/x-www-form-urlencoded")
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: header).responseJSON { (response) in
            
            self.handleResponse(response: response, successClosure: success, failedClosure: failed)

        }
    }
    
    /// 处理请求回调
    /// - Parameters:
    ///   - response: 请求返回
    ///   - successClosure: 成功回调
    ///   - failedClosure: 失败回调
    private func handleResponse(response: AFDataResponse<Any>, successClosure: NetworkingSuccessClosure, failedClosure: NetworkingFailedClosure) {
        switch response.result {
        case .success:
            let json = String(data: response.data!, encoding: String.Encoding.utf8)
            handleRequestSuccess(json: json!, successClosure: successClosure, failedClosure: failedClosure)
        case .failure:
            handleReqeustError(error: response.error!, failedClosure: failedClosure)
        }
    }
        
    /// 处理失败的回调
    /// - Parameters:
    ///   - error: 错误
    ///   - failedClosure: 错误回调
    private func handleReqeustError(error: AFError, failedClosure: NetworkingFailedClosure) {
        let errorInfo = NetworkingError(code: error.responseCode!, localizedDescription: error.localizedDescription, error: error)
        failedClosure(errorInfo)
    }
    
    /// 处理成功的回调
    /// - Parameters:
    ///   - json: json string
    ///   - successClosure: 成功的回调
    ///   - failedClosure: 失败的回调
    private func handleRequestSuccess(json: String, successClosure: NetworkingSuccessClosure, failedClosure: NetworkingFailedClosure) {
        debugPrint(json)
    }
        
}


