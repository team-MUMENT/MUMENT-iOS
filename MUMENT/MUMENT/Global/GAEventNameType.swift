//
//  GAEventNameType.swift
//  MUMENT
//
//  Created by madilyn on 2023/02/20.
//

import Foundation

enum GAEventNameType {
    case signup_process
    case home_activity_type
    case write_process
    case write_path
    case share_instagram
    case song_detail_activity
    case use_filter
    case noti_popup
    case use_storage_tap
    case use_grid_my_mument
    case use_grid_like_mument
    case mument_detail_page
    case noti_on
    case noti_off
    case mument_history_view
    case first_visit_page
}

extension GAEventNameType {
    var parameterKey: String {
        switch self {
        case .home_activity_type, .write_path, .use_filter, .mument_detail_page, .mument_history_view:
            return "type"
        case .share_instagram, .noti_off, .first_visit_page:
            return "count"
        case .noti_popup, .noti_on:
            return "choice"
        case .song_detail_activity, .use_storage_tap, .use_grid_my_mument, .use_grid_like_mument, .signup_process, .write_process:
            return "journey"
        }
    }
    
    enum ParameterValue {
        case signup_sns_login_apple
        case signup_sns_login_kakao
        case signup_profile_img
        case signup_duplication_test
        case signup_success
        case home_search
        case home_todaymu
        case home_relistenmu
        case home_tagmu
        case select_music
        case select_impressive
        case select_feeling
        case write_text
        case write_success
        case from_home
        case from_song_detail_page
        case from_mument_detail_page
        case from_history_list
        case form_storage
        case click_instagram
        case over_1_mument
        case over_5_mument
        case over_10_mument
        case over_20_mument
        case use_impressive_filter
        case use_feeling_filter
        case use_both_filter
        case noti_popup_success
        case noti_popup_delete
        case noti_popup_refuse
        case click_storage_tap
        case click_like_mument
        case my_mument_list
        case my_mument_grid
        case like_mument_list
        case like_mument_grid
        case from_storage_my_mument
        case from_storage_like_mument
        case noti_first_success
        case noti_page_success
        case noti_turn_off_success
        case from_song_detail
        case from_my_mument_detail
        case from_other_mument_detail
        case direct_write
        case direct_search
        case direct_curation
        case direct_storage
    }
}
