//
//  TabBarController.swift
//  iBuy
//
//  Created by Cesar A. Tavares on 04/11/20.
//

import UIKit

class TabBarController: UITabBarController {
    
    static let shared = TabBarController()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewControllers()
    }

    func loadViewControllers() {
        var arrayViews = [UIViewController]()

        /// DAQUI
        
        if let viewController1 = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? ViewController {
            viewController1.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
            viewController1.title = "Lista de compras"
            let navigation1 = UINavigationController(rootViewController: viewController1)
            arrayViews.append(navigation1)
        }
        
        if let viewController2 = UIStoryboard(name: "Settings", bundle: nil).instantiateInitialViewController() as? SettingsViewController {
            viewController2.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
            viewController2.title = "Configurações"
            let navigation2 = UINavigationController(rootViewController: viewController2)
            arrayViews.append(navigation2)
        }

        /// AQUI
                
        viewControllers = arrayViews
                
        
        self.selectedIndex = 0
    }
}



extension UIViewController {
    class func replaceRootViewController(viewController: UIViewController) {
        guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first
        else {
            return
        }
        let rootViewController = window.rootViewController!

        viewController.view.frame = rootViewController.view.frame
        viewController.view.layoutIfNeeded()

        UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromLeft, animations: {
            window.rootViewController = viewController
        }, completion: nil)
    }
}
