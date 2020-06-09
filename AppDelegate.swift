//
//  AppDelegate.swift
//  WorkOutApp
//
//  Created by 玉井　勝也 on 2020/02/27.
//  Copyright © 2020 katsuya tamai. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        
        let config = Realm.Configuration(
          // 新しいスキーマバージョンを設定します。以前のバージョンより大きくなければなりません。
          // （スキーマバージョンを設定したことがなければ、最初は0が設定されています）
          schemaVersion: 5,

          // マイグレーション処理を記述します。古いスキーマバージョンのRealmを開こうとすると
          // 自動的にマイグレーションが実行されます。
          migrationBlock: { migration, oldSchemaVersion in
            // 最初のマイグレーションの場合、`oldSchemaVersion`は0です
            if (oldSchemaVersion < 5) {
              // 何もする必要はありません！
              // Realmは自動的に新しく追加されたプロパティと、削除されたプロパティを認識します。
              // そしてディスク上のスキーマを自動的にアップデートします。
            }
          })

        // デフォルトRealmに新しい設定を適用します
        Realm.Configuration.defaultConfiguration = config

        // Realmファイルを開こうとしたときスキーマバージョンが異なれば、
        // 自動的にマイグレーションが実行されます
        _ = try! Realm()
        
        let userdefaults = UserDefaults.standard
//        初回起動時のキー
        let dic = ["firstLaunch": true]
        userdefaults.register(defaults: dic)
        
        
        return true
        
        
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
}

