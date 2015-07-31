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
        self.pushNotification()
        self.askForAccessToCalendar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func askForAccessToCalendar() {
        let eventStore = EKEventStore()
        switch EKEventStore.authorizationStatusForEntityType(EKEntityType.Event) {
        case .Authorized:
            //            insertEvent(eventStore)
            print("Add an Event!")
        case .Denied:
            print("Access already denied")
        case .NotDetermined:
            eventStore.requestAccessToEntityType(EKEntityType.Event, completion: { (granted:Bool, error:NSError?) -> Void in
                if granted {
                    self.insertEvent(eventStore)
                } else {
                    print("Access denied")
                }
            })
        default:
            print("Case Default")
        }
    }

    func insertEvent(store: EKEventStore) {
        let calendars = store.calendarsForEntityType(EKEntityType.Event) as [EKCalendar]
        
        for calendar in calendars {
            if calendar.title == "Calendar" {
                let startDate = NSDate()
                let endDate = startDate.dateByAddingTimeInterval(2 * 60 * 60)
                let event = EKEvent(eventStore: store)
                event.calendar = calendar
                event.title = "New Meeting"
                event.startDate = startDate
                event.endDate = endDate
                
                do {
                    try store.saveEvent(event, span: EKSpan.ThisEvent)
                } catch let error as NSError {
                    print(error.description)
                }
            }
        }
    }
    
    func pushNotification() {
        let localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertAction = "Testing notifications on iOS9"
        localNotification.alertBody = "Local notifications are working"
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 5)
        localNotification.soundName = UILocalNotificationDefaultSoundName
        localNotification.category = "invite"
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }

}

