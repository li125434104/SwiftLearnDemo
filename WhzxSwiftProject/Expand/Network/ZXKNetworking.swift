//
//  ZXKNetworking.swift
//  WhzxSwiftProject
//
//  Created by Applezxk on 2020/10/10.
//

import Foundation
import Alamofire

typealias NetworkingSuccessClosure = (_ Json: Any) -> Void
typealias NetworkingFailedClosure = (_ error: HWNetworkingError) -> Void

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
    
    public func request(url: String, httpMethod: Int, parameters: [String: Any]?, ) {
        
    }
}


