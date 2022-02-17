//
//  Network.swift
//  ListProduct
//
//  Created by Maul on 16/02/22.
//

import Alamofire
import SwiftyJSON

class Network {
    
    /// Check is connect internet or nor
    class var isConnected: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    private class var baseUrl: String { return env.apiUrl }
    
    class func request(_ service: Services, completion: @escaping (_ data: Data?, _ error: String?) -> ()) {
        let url =  baseUrl + service.path
        AF.request(url, method: service.method, encoding: URLEncoding.queryString)
            .responseJSON { res in
                printResponse(service, res)
                switch res.result {
                case .success:
                    completion(res.data, nil)
                case .failure(let error):
                    guard isConnected == true else {
                        completion(nil, "Check your internet connection")
                        return
                    }
                    
                    let errorMsg = error.localizedDescription
                    completion(nil, errorMsg)
                }
        }
    }
    
    private class func printResponse(_ service: Services, _ response: AFDataResponse<Any>) {
        #if DEBUG
        if let d = response.data, let json = try? JSON(data: d) {
            printRequest(service)
            print(json)
        } else {
            debugPrint(response)
        }
        #endif
    }
    
    private class func printRequest(_ sercive: Services) {
        print(baseUrl + sercive.path)
    }
}
