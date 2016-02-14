//
//  UIKitExtension.swift
//  GitHub
//
//  Created by Sasikumar JP on 13/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import UIKit

func showErrorMessageAlertView(title: String, message: String, onViewController viewController: UIViewController) {
    let alertViewController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
    alertViewController.addAction(okAction)
    viewController.presentViewController(alertViewController, animated: true, completion: nil)

}
