//
//  HomeService.swift
//  MUMENT
//
//  Created by 김지민 on 2022/07/21.
//

import Alamofire

enum HomeService {
    case getCarouselData
    case getMumentForTodayData(userId: String)
    case getMumentOfRevisitedData
    case getMumentByTagData
}

extension HomeService: TargetType {
    var path: String {
        switch self {
        case .getCarouselData:
            return "/home/recommendation"
        case .getMumentForTodayData(userId: let userId):
            return "/home/today/\(userId)"
        case .getMumentOfRevisitedData:
            return "/home/known"
        case .getMumentByTagData:
            return "/random"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCarouselData:
            return .get
        case .getMumentForTodayData:
            return .get
        case .getMumentOfRevisitedData:
            return .get
        case .getMumentByTagData:
            return .get
        }
    }
    
    var header: HeaderType {
        switch self {

        case .getCarouselData:
            return .basic
        case .getMumentForTodayData:
            return .basic
        case .getMumentOfRevisitedData:
            return .basic
        case .getMumentByTagData:
            return .basic
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getCarouselData:
            return .requestPlain
        case .getMumentForTodayData(_):
            return .requestPlain
        case .getMumentOfRevisitedData:
            return .requestPlain
        case .getMumentByTagData:
            return .requestPlain
        }
    }
}

