//
//  StorageService.swift
//  MUMENT
//
//  Created by 김담인 on 2022/07/21.
//

import Foundation
import Alamofire

enum StorageService {
//  case getIsFirst(userId: String, musicId: String)
//  case postMument(userId: String, musicId: String, data: PostMumentBodyModel)
  case getMyMumentStorage(userId: String, filterTags: [Int])
}

extension StorageService: TargetType {
  var path: String {
    switch self {
    case .getMyMumentStorage(let userId, _):
      return "/user/my/\(userId)/list"
//    case .getIsFirst(let userId, let musicId):
//      return "/mument/\(userId)/\(musicId)/is-first"
//    case .postMument(let userId, let musicId, _):
//      return "/mument/\(userId)/\(musicId)"
    }
  }
   
  var method: HTTPMethod {
    switch self {
    case .getMyMumentStorage:
      return .get
//    case .getIsFirst:
//      return .get
//    case .postMument:
//      return .post
    }
  }
   
  var header: HeaderType {
    switch self {
//    case .getIsFirst, .postMument:
//      return .basic
    case .getMyMumentStorage:
      return .basic
    }
  }
   
  var parameters: RequestParams {
    switch self {
//    case .getIsFirst:
//      return .requestPlain
//    case .postMument(_, _, let data):
//      return .requestBody(["isFirst": data.isFirst, "impressionTag": data.impressionTag, "feelingTag": data.feelingTag, "content": data.content, "isPrivate": data.isPrivate])
    case .getMyMumentStorage(_, let filterTags):
      if filterTags.count == 0 {
        return .requestPlain
      } else if filterTags.count == 1 {
        return .query(["tag1": filterTags[0]])
      } else if filterTags.count == 2 {
        return .query(["tag1": filterTags[0], "tag2": filterTags[1]])
      } else {
        return .query(["tag1": filterTags[0], "tag2": filterTags[1], "tag3": filterTags[2]])
      }
    }
  }
}
