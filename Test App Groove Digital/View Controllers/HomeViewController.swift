//
//  HomeViewController.swift
//  Test App Groove Digital
//
//  Created by Gianmaria Biselli on 8/24/20.
//  Copyright © 2020 Zodaj. All rights reserved.
//

import UIKit
import Macaw

class HomeViewController: UIViewController, TimePickerPopupDelegate {

    @IBOutlet weak var changeDateButton: UIButton!
    
    @IBOutlet weak var activityAnalytics: GraphView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeDateButton.layer.cornerRadius = 5
        activityAnalytics.layer.cornerRadius = 10
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        activityAnalytics.showGraphAnalytics(dateChosen: dateFormatter.string(from: currentDate))
    }
    
    func displayChosenTime(dateChosen: Date?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if dateChosen != nil {
            activityAnalytics.showGraphAnalytics(dateChosen: dateFormatter.string(from: dateChosen!))
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPopup"{
            let destinationPopupController = segue.destination as! DatePickerPopupVC
            destinationPopupController.delegate = self
        }
    }
    
    
}
