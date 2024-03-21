//
//  SceneDelegate.swift
//  CenApp
//
//  Created by 김민솔 on 3/16/24.
//

import UIKit
import SwiftKeychainWrapper
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        guard let windowScene = (scene as? UIWindowScene) else {return}
        window = UIWindow(frame: UIScreen.main.bounds)
        if let JWTaccessToken = KeychainWrapper.standard.string(forKey: "JWTaccesstoken"){
            print("\(JWTaccessToken)")
            LoginCheckService.requestLogin { result in
                if let message = result?.message {
                    if message == "login" {
                        let viewController = TabViewController()
                        let navigationController = UINavigationController(rootViewController: viewController)
                        self.window?.rootViewController = navigationController
                    }
                }
            } onError: { error in
                LogoutService.requestLogout()
                let viewController = LoginViewController()
                let navigationController = UINavigationController(rootViewController: viewController)
                self.window?.rootViewController = navigationController
            }
        }else{
            let viewController = LoginViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            window?.rootViewController = navigationController
        }
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
    }
}


