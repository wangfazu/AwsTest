//
//  LoginViewController.swift
//  AwsTest
//
//  Created by wang on 2018/4/3.
//  Copyright © 2018年 mapollo. All rights reserved.
//

import UIKit
import AWSCore
import AWSAuthUI
import AWSUserPoolsSignIn
import AWSDynamoDB
class LoginViewController: UIViewController {

    var userName : UITextField!
    var userPwd : UITextField!

    override func viewDidLoad() {
        let AppWidth = UIScreen.main.bounds.size.width
        let APPHeight = UIScreen.main.bounds.size.height
        
        self.title = "新建一个笔记放到AWS"
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //        let lab = UILabel(frame: CGRect(x: 50, y: 100, width: AppWidth, height: APPHeight))
        //        lab.backgroundColor = .red
        //        self.view.addSubview(lab)
        
        //
        //        let imageV = UIImageView()
        //        imageV.frame = CGRect(x: 0, y: 0, width: AppWidth, height: APPHeight)
        //        imageV.kf.setImage(with: URL.init(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1522667024058&di=065efcd5add71443e1c354fbdbaf98ed&imgtype=0&src=http%3A%2F%2Fimg4.duitang.com%2Fuploads%2Fitem%2F201504%2F22%2F20150422H1756_sNuWa.thumb.700_0.jpeg"))
        //        self.view.addSubview(imageV)

        
        
        //登录按钮
        let loginBtn = UIButton(type: .system)
        loginBtn.frame = CGRect(x: 50, y: 500, width: AppWidth / 3, height: 50)
        //        loginBtn.backgroundColor = .blue
        loginBtn.setTitle("添加到数据库中", for: .normal)
        loginBtn.addTarget(self, action:#selector(tapped(_:)), for:.touchUpInside)
        
        
        
        //注册按钮
        let registBtn = UIButton(type: .system)
        registBtn.frame = CGRect(x: 25 + AppWidth / 2, y: 500, width: AppWidth / 3, height: 50)
        //        registBtn.backgroundColor = .black
        registBtn.setTitle("注册", for: .normal)
        
        
        
        //
        let titleArr = ["userId","noteId","title","content","creatDate"]
        

        
        
        //
        for i in 0...4 {
            //username
            let userNameLab = UILabel(frame: CGRect(x: 10, y: 105+i*35, width: 100, height: 20))
            userNameLab.text = titleArr[i]
            userNameLab.textColor = .black
            
            
            userName = UITextField(frame: CGRect(x: 120, y: 105 + i*35, width: Int(AppWidth - 100), height: 30))
            userName.borderStyle = .roundedRect
            userName.placeholder = "请输入\(titleArr[i])"
            userName.tag = 100+i
            self.view.addSubview(userNameLab)
            self.view.addSubview(userName)
        }
        self.view.backgroundColor = .white
        //统一加载

        self.view.addSubview(loginBtn)
        self.view.addSubview(registBtn)
        //        presentAuthUIViewController()
    }
    //click
    @objc func tapped(_ button:UIButton) {

        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
        
        //Create data object using data models you downloaded from Mobile Hub
        let newItem: Notes = Notes();
        
        // Use AWSIdentityManager.default().identityId here to get the user identity id.
        var userArr = [Any]()
        
        
        for i in 0...4 {
            let  tag = 100 + i
            if let texf = view.viewWithTag(tag) as? UITextField {
                print(texf.text ?? "wfz")
                userArr.append(texf.text ?? "hello")
                
            }

        }
        
        newItem._userId = userArr[0] as? String
        newItem._noteId = userArr[1] as? String
        newItem._title  = userArr[2] as? String
        newItem._content = userArr[3] as? String
        newItem._creationDate = 666
        
        print(Notes.jsonKeyPathsByPropertyKey())
        //Save a new item
        dynamoDbObjectMapper.save(newItem, completionHandler: {
            (error: Error?) -> Void in
            
            if let error = error {
                print("保存失败: \(error)")
                return
            }
            print("保存成功")
        })
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
