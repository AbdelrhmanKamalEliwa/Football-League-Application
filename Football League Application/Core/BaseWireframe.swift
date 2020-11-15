//
//  BaseWireframe.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/12/20.
//

import UIKit

class BaseWireframe: UIViewController {
    //MARK: Properties
    final var navBar: UINavigationBar {
        return self.navigationController!.navigationBar
    }

    //MARK: Setup NavBar
    func setupNavBar(navBarTitle: AppScreens) {
        navBar.barTintColor = UIColor(named: "AppYellow")!
        navBar.tintColor = UIColor(named: "AppBlack1")
        navBar.prefersLargeTitles = false
        let title = navBarTitle.rawValue
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: "AppBlack1")!
        ]
        navBar.titleTextAttributes = titleAttributes
        navigationItem.title = title
    }
    
    // MARK: Generic Alert
    func presentGenericAlert(viewController: UIViewController, title: String, message: String, doneButtonTitle: String, dismissButtonTitle: String?, completion: @escaping(_ done: Bool) -> Void = {_ in}) {
        
        if dismissButtonTitle != nil {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let doneAction = UIAlertAction(title: doneButtonTitle, style: .cancel) { (_) in
                completion(true)
            }
            let dissmisAction = UIAlertAction(title: dismissButtonTitle, style: .destructive, handler: nil)
            alert.addAction(doneAction)
            alert.addAction(dissmisAction)
            viewController.present(alert, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let doneAction = UIAlertAction(title: doneButtonTitle, style: .cancel) { (_) in
                completion(true)
            }
            alert.addAction(doneAction)
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}

