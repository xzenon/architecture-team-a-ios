//
//  AppDelegate.swift
//  architectureTeamA
//
//  Created by basalaev on 10.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import UIKit
import HHNetwork

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    typealias LaunchOptions = [UIApplicationLaunchOptionsKey: Any]

    var window: UIWindow?
    var authBufferedController: UIViewController?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: LaunchOptions?
        ) -> Bool {

        let window = ARCHWindow()
        self.window = window
        launchOn(window: window)

        return true
    }

    private func launchOn(window: ARCHWindow) {
        ModulesUserStory.network(moduleIO: nil).displayOn(window: window, animated: false)
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}

extension AppDelegate: ARCHAuthObserverMoyaPluginDelegate {

    func didExpiredAuthToken() {
        print("[AppDelegate] >> didExpiredAuthToken")

        authBufferedController = window?.rootViewController
        // Делаем переход на экран авторизации
    }
}

extension AppDelegate: ARCHSignMoyaPluginDelegate {

    var signHeaderFields: [String: String] {
        if let token = Dependency.shared.userStorage.token?.value {
            return ["X-Auth-Token": token]
        } else {
            return [:]
        }
    }
}

extension AppDelegate: ARCHUserStorageDelegate {

    func didUpdateUser(from: ARCHUser?, to: ARCHUser?) {
        // TODO: Обновляем стек
    }
}