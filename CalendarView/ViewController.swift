//
//  ViewController.swift
//  CalendarView
//
//  Created by Haoyu on 7/31/15.
//  Copyright © 2015 travo. All rights reserved.
//

import UIKit
import EventKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let eventStore = EKEventStore()
        switch EKEventStore.authorizationStatusForEntityType(EKEntityType.Event) {
        case .Authorized:
            print("Access already granted")
        case .Denied:
            print("Access already denied")
        case .NotDetermined:
            eventStore.requestAccessToEntityType(EKEntityType.Event, completion: { (granted:Bool, error:NSError?) -> Void in
                if granted {
                    print("Access granted!")
                } else {
                    print("Access denied")
                }
            })
        default:
            print("Case Default")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

