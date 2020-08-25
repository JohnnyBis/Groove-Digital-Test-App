//
//  DatePickerPopupVC.swift
//  Test App Groove Digital
//
//  Created by Gianmaria Biselli on 8/24/20.
//  Copyright © 2020 Zodaj. All rights reserved.
//

import UIKit


protocol TimePickerPopupDelegate: AnyObject{
    func displayChosenTime(dateChosen: Date?)
}

class DatePickerPopupVC: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var setButton: UIButton!
    
    weak var delegate: TimePickerPopupDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.layer.cornerRadius = 5
        setButton.layer.cornerRadius = 5
        
        datePicker.timeZone = .current
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.minuteInterval = 10
        
        let currentDate = Date()
        datePicker.date = currentDate
        
    }

    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.05) {
            self.view.backgroundColor = .clear
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func setButtonPressed(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.05) {
            self.view.backgroundColor = .clear
        }
        
        if let delegate = delegate {
            delegate.displayChosenTime(dateChosen: datePicker.date)
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
}
