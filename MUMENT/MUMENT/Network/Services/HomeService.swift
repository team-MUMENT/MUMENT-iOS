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
    case getUserPenalty
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
        case .getUserPenalty:
            return "/user/report/restrict"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCarouselData, .getMumentForTodayData, .getMumentsOfRevisitedData, .getMumentsByTagData, .getUserPenalty:
            return .get
        }
    }
    
    var header: HeaderType {
        switch self {
        case .getMumentForTodayData, .getMumentsOfRevisitedData, .getMumentsByTagData, .getCarouselData, .getUserPenalty:
            return .auth
        }
    }
    
    var parameters: RequestParams {
        return .requestPlain
    }
}

