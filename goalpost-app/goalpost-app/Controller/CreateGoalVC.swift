//
//  CreateGoalVC.swift
//  goalpost-app
//
//  Created by Soufiane Salouf on 3/4/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController {

    //Outlets
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var shortTermBtn: UIButton!
    
    //var
    var goalType: GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.bindToKeyborad()
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
        
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func shortTermBtnWasPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
    }
    
    @IBAction func longTermBtnWasPressed(_ sender: Any) {
        goalType = .longTerm
        longTermBtn.setSelectedColor()
        shortTermBtn.setDeselectedColor()
    }
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        
    }
    

}
