//
//  AppDelegate.swift
//  ServerRequestManager
//
//  Created by Synergy on 27/03/18. 
//  Copyright © 2018 Synergy.com.nl. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate  {

    var window: UIWindow? 
    var instanceIDTokenMessage: String?
    let gcmMessageIDKey = "gcm.message_id"
    let name = "name"
    let location = "location"
    let message = "google.c.a.c_l"
    let aps = "aps"
    let receivedNotification = Notification.Name(rawValue:"NotificationReceived")


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound] ) { (isGranted, error) in
            if error != nil {
                print("Eroare aparuta la autorizare!")
            } else {
                UNUserNotificationCenter.current().delegate = self
                Messaging.messaging().delegate = self
                DispatchQueue.main.async(execute: {
                    application.registerForRemoteNotifications()
                })
                
            }
            
        }
        FirebaseApp.configure()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func connectToFirebase() {
        Messaging.messaging().shouldEstablishDirectChannel = true
        
    }
    
}

extension AppDelegate {
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if(application.applicationState == UIApplicationState.inactive)
        {
            print("Inactive")
            //Show the view with the content of the push
            completionHandler(.newData)
            
        }else if (application.applicationState == UIApplicationState.background){
            
            print("Background")
            //Refresh the local model
            completionHandler(.newData)
            
        }else{
            
            print("Active")
            //Show an in-app banner
            completionHandler(.newData)
        }
        
        
        if let messageID = userInfo[gcmMessageIDKey],
            let name = userInfo[name],
            let location = userInfo[location],
            let message = userInfo[message]{
            print("Message ID  : \(messageID)")
            print("Message name : \(name)")
            print("Message location : \(location)")
            print("Message  : \(message)")
            
        }
        if let aps = userInfo[aps] {
            print("Message aps  : \(aps)")
            
        }
        
        print("userInfo = \(userInfo)")
        
        NotificationCenter.default.post(name: receivedNotification, object: nil)
        
    }
    
}


extension AppDelegate:MessagingDelegate {
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("nu avem token!!!")
    }
    
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print(" --- Remote instance ID token: \(result.token) --- ")
                self.instanceIDTokenMessage  = "Remote InstanceID token: \(result.token)"
            }
        }
        connectToFirebase()
        
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }
}


