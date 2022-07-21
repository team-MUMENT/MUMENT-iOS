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
    case getMumentsOfRevisitedData
    case getMumentsByTagData
}

extension HomeService: TargetType {
    var path: String {
        switch self {
        case .getCarouselData:
            return "/mument/banner"
        case .getMumentForTodayData(userId: let userId):
            return "/mument/today/\(userId)"
        case .getMumentsOfRevisitedData:
            return "/home/known"
        case .getMumentsByTagData:
            return "/mument/random"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCarouselData:
            return .get
        case .getMumentForTodayData:
            return .get
        case .getMumentsOfRevisitedData:
            return .get
        case .getMumentsByTagData:
            return .get
        }
    }
    
    var header: HeaderType {
        switch self {

        case .getCarouselData:
            return .basic
        case .getMumentForTodayData:
            return .basic
        case .getMumentsOfRevisitedData:
            return .basic
        case .getMumentsByTagData:
            return .basic
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getCarouselData:
            return .requestPlain
        case .getMumentForTodayData(_):
            return .requestPlain
        case .getMumentsOfRevisitedData:
            return .requestPlain
        case .getMumentsByTagData:
            return .requestPlain
        }
    }
}

