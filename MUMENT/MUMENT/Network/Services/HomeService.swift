//
//  HomeService.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/21.
//

import Alamofire

enum HomeService {
    case getCarouselData
    case getMumentForTodayData
    case getMumentsOfRevisitedData
    case getMumentsByTagData
}

extension HomeService: TargetType {
    var path: String {
        switch self {
        case .getCarouselData:
            return "/mument/banner"
        case .getMumentForTodayData:
            return "/mument/today"
        case .getMumentsOfRevisitedData:
            return "/mument/again"
        case .getMumentsByTagData:
            return "/mument/random"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var header: HeaderType {
        return .basic
    }
    
    var parameters: RequestParams {
        return .requestPlain
    }
}

