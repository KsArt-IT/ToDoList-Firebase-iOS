//
//  AppDelegate.swift
//  ToDoList-Firebase
//
//  Created by KsArT on 05.09.2024.
//

import UIKit
import FirebaseCore
import FirebaseDatabase
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        // Включаем локальное кэширование до использования базы данных
        // Настройка isPersistenceEnabled = true должна быть выполнена один раз при инициализации Firebase,
        // и до того, как будет выполнен любой запрос к базе данных.
        let db = Database.database(url: DB.url)
        db.isPersistenceEnabled = true

        // needle generate ToDoList-Firebase/DI/NeedleGenerated.swift ToDoList-Firebase/
        // Выполнить сгенерированный код Neddle генератором
        registerProviderFactories()

        return true
    }

    // MARK: for GoogleSignIn
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
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

