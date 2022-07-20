//
//  SearchAPI.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/20.
//

import Foundation
import Alamofire

class SearchAPI: BaseAPI {
    static let shared = SearchAPI()
    
    private override init() { }
    
    /// [GET] 검색 결과 조회
    func getMusicSearch(keyword: String,
                    completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(SearchService.getMusicSearch(keyword: keyword)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, SearchResultResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
