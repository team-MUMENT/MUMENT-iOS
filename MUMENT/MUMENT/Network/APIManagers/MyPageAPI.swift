//
//  MyPageAPI.swift
//  MUMENT
//
//  Created by 김지민 on 2023/01/25.
//

import Foundation
import Alamofire

class MyPageAPI: BaseAPI {
    static let shared = MyPageAPI()
    
    private override init() { }
    
    /// [POST] 탈퇴 사유 등록
    func postWithdrawalReason(body: WithdrawalReasonBodyModel,
                    completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(MyPageService.postWithdrawalReason(body: body)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, WithdrawalReasonResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [POST] 회원 탈퇴
    func postWithdrawal(socialToken: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(MyPageService.postWithdrawal(socialToken: socialToken)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, WithdrawalResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [GET] 닉네임 중복 체크
    func checkDuplicatedNickname(nickname: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(MyPageService.checkDuplicatedNickname(nickname: nickname)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                let networkResult = self.judgeStatus(by: statusCode)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [PUT] 프로필 설정
    func setProfile(data: SetProfileRequestModel, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.upload(
            multipartFormData: MyPageService.setProfile(data: data).multipart,
            with: MyPageService.setProfile(data: data)
        ).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, SetProfileResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [GET] 차단 유저 리스트 조회
    func getBlockedUserList(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(MyPageService.getBlockedUserList).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, GetBlockedUserListResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [DELETE] 유저 차단 해제
    func deleteBlockedUser(userId: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(MyPageService.deleteBlockedUser(userId: userId)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                let networkResult = self.judgeStatus(by: statusCode)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [GET] 공지사항 리스트 조회
    func getNoticeList(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(MyPageService.getNoticeList).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, GetNoticeListResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [GET] 공지사항 상세보기
    func getNoticeDetail(noticeId: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(MyPageService.getNoticeDetail(noticeId: noticeId)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, GetNoticeListResponseModelElement.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [GET] 마이페이지 URL 조회
    func getMypageURL(isFromSignIn: Bool, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(MyPageService.getMypageURL(isFromSignIn: isFromSignIn)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, GetAppURLresponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [GET] 유저 프로필 조회
    func getUserProfile(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(MyPageService.getUserProfile).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, GetUserProfileResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [GET] 앱 최신 버전 조회
    func getAppVersion(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(MyPageService.getAppVersion).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, GetAppVersionResponseModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
