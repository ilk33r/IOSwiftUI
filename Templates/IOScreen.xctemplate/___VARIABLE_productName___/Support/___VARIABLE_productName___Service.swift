// ___FILEHEADER___

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation

enum ___VARIABLE_productName___Service {

}

extension ___VARIABLE_productName___Service: IOServiceType {
    
    var methodType: IOHTTPRequestType {
        switch self {
        default:
            return .get
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
        default:
            return ""
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
        default:
            return nil
        }
    }
    
    func response<TModel: Codable>(responseType: TModel.Type, result: IOHTTPResult?) -> IOServiceResult<TModel> {
//        return _handleResponse(type: responseType, result: result)
    }
}
