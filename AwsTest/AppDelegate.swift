//
//  AppDelegate.swift
//  AwsTest
//
//  Created by wang on 2018/4/2.
//  Copyright © 2018年 mapollo. All rights reserved.
//

import UIKit
import AWSAuthCore
import AWSCore
import AWSPinpoint
import AWSUserPoolsSignIn
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    // set up the initialized flag
    var isInitialized = false
    //APP分析是创建的
    var pinpoint: AWSPinpoint?
    
    //用户登录时创建的
    func application(_ application: UIApplication, open url: URL,
                     sourceApplication: String?, annotation: Any) -> Bool {
        
        print("didFinishLaunching")
        
        AWSSignInManager.sharedInstance().interceptApplication(
            application, open: url,
            sourceApplication: sourceApplication,
            annotation: annotation)
        
        if (!isInitialized) {
            isInitialized = true
        }
        
        return false;
    }
    
    //系统自带的
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let didFinishLaunching = AWSSignInManager.sharedInstance().interceptApplication(
            application, didFinishLaunchingWithOptions: launchOptions)
        
        //
        // Register the sign in provider instances with their unique identifier
        AWSSignInManager.sharedInstance().register(
            signInProvider: AWSCognitoUserPoolsSignInProvider.sharedInstance())
        
        //
        if (!isInitialized) {
            AWSSignInManager.sharedInstance().resumeSession(completionHandler: {
                (result: Any?, error: Error?) in
                print("Result: \(result) \n Error:\(error)")
            })
            isInitialized = true
        }
        
        //app分析时候，创建的
        // Initialize Pinpoint
        pinpoint = AWSPinpoint(configuration:
            AWSPinpointConfiguration.defaultPinpointConfiguration(launchOptions: launchOptions))
        
        //. . .
        
        let myVC = ViewController()
        let myNav = UINavigationController(rootViewController: myVC)
        self.window?.rootViewController = myNav
        
        
        
        
        return didFinishLaunching
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


}

