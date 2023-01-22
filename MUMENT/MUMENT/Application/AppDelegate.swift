//
//  AppDelegate.swift
//  MUMENT
//
//  Created by madilyn on 2022/07/06.
//

import UIKit
import Firebase
import KakaoSDKCommon
import KakaoSDKAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        sleep(1)
        
        // 네이티브 앱 키(카카오 디벨로퍼 계정에서 제공)를 사용해 iOS SDK를 초기화합니다.
        KakaoSDK.initSDK(appKey: "a03c85e89f6892684a4533911f5ab502")
        self.requestNotificationPermission()
        
        // Firebase SDK를 초기화합니다.
        FirebaseApp.configure()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    private func requestNotificationPermission(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound, .badge], completionHandler: {didAllow, Error in
            if didAllow {
                debugPrint("Push: 권한 허용")
            } else {
                debugPrint("Push: 권한 거부")
            }
        })
    }
}
