//
//  FinishGoalVC.swift
//  goalpost-app
//
//  Created by Soufiane Salouf on 3/4/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController, UITextFieldDelegate {

    //Outlets
    @IBOutlet weak var pointsTextField: UITextField!
    @IBOutlet weak var createGoalBtn: UIButton!
    
    //var
    var goalDescription: String!
    var goalType: GoalType!
    
    func initData(description: String, type: GoalType){
        self.goalDescription = description
        self.goalType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyborad()
        pointsTextField.delegate = self
    }

    @IBAction func createGoalBtnWasPressed(_ sender: Any) {
        if pointsTextField.text != "" {
            self.save { (complete) in
                if complete {
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    func save(completion: (_ finished: Bool) -> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        
        do{
            try managedContext.save()
            completion(true)
        } catch  {
            debugPrint("Could not saved : \(error.localizedDescription)")
            completion(false)
        }
    }
    
}
