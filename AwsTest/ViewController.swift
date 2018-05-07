//
//  ViewController.swift
//  AwsTest
//
//  Created by wang on 2018/4/2.
//  Copyright © 2018年 mapollo. All rights reserved.
//

import UIKit
import Kingfisher
import AWSAuthUI
import AWSUserPoolsSignIn
class ViewController: UIViewController {

//    struct User {
//        var name : String!
//        var pwd :String!
//
//
//    }

    override func viewDidLoad() {
        let AppWidth = UIScreen.main.bounds.size.width
        let APPHeight = UIScreen.main.bounds.size.height
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let lab = UILabel(frame: CGRect(x: 50, y: 100, width: AppWidth, height: APPHeight))
//        lab.backgroundColor = .red
//        self.view.addSubview(lab)
        
//测试第三方库是否可用~
        let imageV = UIImageView()
        imageV.frame = CGRect(x: 0, y: 0, width: AppWidth, height: APPHeight)
        imageV.kf.setImage(with: URL.init(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1522667024058&di=065efcd5add71443e1c354fbdbaf98ed&imgtype=0&src=http%3A%2F%2Fimg4.duitang.com%2Fuploads%2Fitem%2F201504%2F22%2F20150422H1756_sNuWa.thumb.700_0.jpeg"))
        self.view.addSubview(imageV)
        
        
        
        //登录按钮
        let loginBtn = UIButton(type: .system)
        loginBtn.frame = CGRect(x: AppWidth/2 - 40, y: 300 + 80 + 20, width: 80, height: 50)
//        loginBtn.backgroundColor = .blue
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        loginBtn.addTarget(self, action:#selector(tapped(_:)), for:.touchUpInside)

        

        
        
        
        //统一加载

        self.view.addSubview(loginBtn)
//        presentAuthUIViewController()
    }
    //click
    @objc func tapped(_ button:UIButton) {
        
        
        print("跳转了！！！")
        presentAuthUIViewController()
    }
    //
    func presentAuthUIViewController() {
        let config = AWSAuthUIConfiguration()
        config.enableUserPoolsUI = true
        // you can use properties like logoImage, backgroundColor to customize screen
        // config.canCancel = false // prevent end user dismissal of the sign in screen
        
        // you should have a navigation controller for your view controller
        // the sign in screen is presented using the navigation controller
        
        AWSAuthUIViewController.presentViewController(
            with: navigationController!,  // put your navigation controller here
            configuration: config,
            completionHandler: {(
                _ signInProvider: AWSSignInProvider, _ error: Error?) -> Void in
                if error == nil {
                    DispatchQueue.main.async(execute: {() -> Void in
                        // handle successful callback here,
                        // e.g. pop up to show successful sign in
                        print("登陆成功！")
                        self.navigationController?.pushViewController(LoginViewController(), animated: true)
                    })
                    
                }
                else {
                    // end user faced error while loggin in,
                    // take any required action here
                }
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

