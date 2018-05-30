//
//  NetworkTools.swift
//  TelePost
//
//  Created by Hitender kumar on 30/05/18.
//  Copyright © 2018 Hitender kumar. All rights reserved.
//

import UIKit
import AFNetworking

//MARK: HTTP METHODS

enum AFRequestMethod: String {
    case GET = "GET"
    case POST = "POST"
}

class NetworkTools: AFHTTPSessionManager {

    //Shared instance
    static let sharedTools: NetworkTools = {
        let instance = NetworkTools()
        instance.responseSerializer.acceptableContentTypes?.insert("text/html")
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        instance.requestSerializer = AFJSONRequestSerializer.init()
        instance.requestSerializer.timeoutInterval = 20.0
        return instance
    }()
    
    // for handling callback data
    typealias AFNRequestCallBack = (_ response: Any?,_ error: Error?)->()
    
    /// - parameter urlString: path of the resource
    /// - parameter parameters: parameters to send in the request
    /// - parameter finished: closure as parameter for handling callback
    func request(method: AFRequestMethod = .GET, urlString: String, parameters: AnyObject?, finished:@escaping AFNRequestCallBack){
        
        print("urlString ============  " + urlString)
        print("parameters ============  " + String(describing: parameters))
        
        //success closure
        let success = { (dataTask: URLSessionDataTask, responseObject: Any?) -> Void in
            print("responseObject =========" + "\(String(describing: responseObject))")
            finished(responseObject, nil)
        }
        
        //failure closure
        let failure = { (dataTask: URLSessionDataTask?, error: Error) -> Void in
            print("request Error =========" + error.localizedDescription)
            finished(nil, error)
        }
        
        if method == .GET {
            get(urlString,parameters:parameters,progress:nil,success:success,failure:failure)
        }else{
            post(urlString, parameters: parameters, progress: nil, success:success, failure: failure)
        }
    }
    
    func requestBack(method: AFRequestMethod = .GET, urlString: String, parameters: AnyObject?, finished:@escaping AFNRequestCallBack) -> URLSessionDataTask{
        
        print("urlString ============  " + urlString)
        print("parameters ============  " + String(describing: parameters))
        
        //success closure
        let success = { (dataTask: URLSessionDataTask, responseObject: Any?) -> Void in
            print("responseObject =========" + "\(String(describing: responseObject))")
            finished(responseObject, nil)
        }
        
        //failure closure
        let failure = { (dataTask: URLSessionDataTask?, error: Error) -> Void in
            print("request Error =========" + error.localizedDescription)
            finished(nil, error)
        }
        
        if method == .GET {
            return get(urlString,parameters:parameters,progress:nil,success:success,failure:failure)!
        }else{
            return post(urlString, parameters: parameters, progress: nil, success:success, failure: failure)!
        }
    }
    
    //main methods for sending request and handling data
    func requestWithData(data: NSData, name: String, urlString: String, parameters: AnyObject?, finished:@escaping AFNRequestCallBack) {

        //success callback
        let success = { (dataTask: URLSessionDataTask, responseObject: AnyObject?) -> Void in
            finished(responseObject, nil)
        }
        
        //failure callback
        let failure = { (dataTask: URLSessionDataTask?, error: NSError) -> Void in
            finished(nil, error)
        }
        
        post(urlString, parameters: parameters, constructingBodyWith: { (formData) -> Void in
            formData.appendPart(withFileData: data as Data, name: name, fileName: "aa", mimeType: "application/octet-stream")
        }, progress: nil, success: success as? (URLSessionDataTask, Any?) -> Void, failure: (failure as! (URLSessionDataTask?, Error) -> Void))
    }
}

