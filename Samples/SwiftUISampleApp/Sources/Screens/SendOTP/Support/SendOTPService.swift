// 
//  SendOTPService.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon

enum SendOTPService {

    case otpSend(request: SendOTPRequestModel)
    case otpVerify(request: VerifyOTPRequestModel)
}

extension SendOTPService: IOServiceType {
    
    var methodType: IOHTTPRequestType {
        switch self {
        default:
            return .post
        }
    }
    
    var requestContentType: IOServiceContentType {
        switch self {
        default:
            return .applicationJSON
        }
    }
    
    var path: String {
        switch self {
        case .otpSend:
            return "OTP/Send"
            
        case .otpVerify:
            return "OTP/Verify"
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
    
    var query: String? {
        switch self {
        default:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .otpSend(request: let request):
            return handleRequest(request)
            
        case .otpVerify(request: let request):
            return handleRequest(request)
        }
    }
    
    func response<TModel: Codable>(responseType: TModel.Type, result: IOHTTPResult?) -> IOServiceResult<TModel> {
        handleResponse(type: responseType, result: result)
    }
}
