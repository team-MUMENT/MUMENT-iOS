//
//  SearchService.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/20.
//

import Foundation
import Alamofire

enum SearchService {
    case getMusicSearch(keyword: String)
}

extension SearchService: TargetType {
    var path: String {
        switch self {
        case .getMusicSearch:
            return "/music/search"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMusicSearch:
            return .get
        }
    }
    
    var header: HeaderType {
        switch self {
        case .getMusicSearch:
            return .basic
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getMusicSearch(let keyword):
            return .query(["keyword": keyword])
        }
    }
}
