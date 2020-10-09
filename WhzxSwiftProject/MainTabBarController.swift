//
//  MainTabBarController.swift
//  WhzxSwiftProject
//
//  Created by Applezxk on 2020/9/28.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let viewControllersArray: [String] = ["ZXKFindVC", "ZXKClassroomVC"]
        let titleArray: [String] = ["发现", "同步课堂"]
        let imageArray: [String] = ["root_find", "root_classroom"]
        
        for i in 0..<viewControllersArray.count {
            var vc : UIViewController!

            switch i {
                case 0:
                    vc = ZXKFindVC()
                case 1:
                    vc = ZXKClassroomVC()

                default:
                    break
            }
            let title = titleArray[i]
            let imageString = imageArray[i]
            let navi = addChildViewController(childViewController: vc, title: title, imageString: imageString)
            self.addChild(navi)
        }
        self.tabBar.isTranslucent = false
    }
}

func addChildViewController(childViewController: UIViewController, title: String, imageString: String) -> UINavigationController {
    childViewController.title = title
    childViewController.tabBarItem.title = title
    childViewController.tabBarItem.image = UIImage.init(named: imageString)
    childViewController.tabBarItem.selectedImage = UIImage.init(named: imageString.appending("_select"))
    let naviController = UINavigationController.init(rootViewController: childViewController)
    return naviController
}
