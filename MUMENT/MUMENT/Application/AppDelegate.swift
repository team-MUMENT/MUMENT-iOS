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
        
        // 원격 알림 등록
        UNUserNotificationCenter.current().delegate = self
        application.registerForRemoteNotifications()
        
        // MARK: Firebase SDK 초기화
        FirebaseApp.configure()
        
        /// 메시지 대리자 설정
        Messaging.messaging().delegate = self
        
        /// 자동 초기화 방지
        Messaging.messaging().isAutoInitEnabled = true
        
        /// 현재 등록 토큰 가져오기
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FCM registration token: \(token)")
                UserDefaults.standard.set(token, forKey: UserDefaults.Keys.FCMTokenForDevice)
            }
        }
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    /// 푸시 권한 물어보기
    private func requestNotificationPermission(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound, .badge], completionHandler: {didAllow, Error in
            if didAllow {
                debugPrint("Push: 권한 허용")
            } else {
                debugPrint("Push: 권한 거부")
            }
        })
    }
    
    /// APN 토큰과 등록 토큰 매핑
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    /// APN 토큰과 등록 토큰 매핑 실패
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        debugPrint("APN 토큰 등록 실패", "fail")
    }
    
    /// 디바이스 세로방향으로 고정
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
}

// MARK: - MessagingDelegate
extension AppDelegate: MessagingDelegate {
    
    /// 토큰 갱신 모니터링 메서드
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        UserDefaults.standard.set(fcmToken, forKey: UserDefaults.Keys.FCMTokenForDevice)
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
    }
}

// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    /// foreGround에 푸시알림이 올 때 실행되는 메서드
    func userNotificationCenter(_ center: UNUserNotificationCenter,willPresent notification: UNNotification,withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .sound, .list, .banner])
    }
    
    /// 푸시알림을 클릭했을 때 실행되는 메서드
    func userNotificationCenter(_ center: UNUserNotificationCenter,didReceive response: UNNotificationResponse,withCompletionHandler completionHandler: @escaping () -> Void) {
        NotificationCenter.default.post(name: Notification.Name.pushNotificationClicked, object: nil)
        
        /// 푸시알림을 통해서 앱에 진입함을 싱글톤 객체에 알림
        NotificationInfo.shared.isPushComes = true
        completionHandler()
    }
}
