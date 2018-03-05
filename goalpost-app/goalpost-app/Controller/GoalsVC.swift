//
//  GoalsVCswift
//  goalpost-app
//
//  Created by Soufiane Salouf on 3/4/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {

    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //var
    var goals: [Goal] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
        tableView.reloadData()
    }
    
    func fetchCoreDataObjects(){
        self.fetch { (complete) in
            if goals.count >= 1 {
                tableView.isHidden = false
            } else {
                tableView.isHidden = true
            }
        }
    }

    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else { return }
        presentDetail(createGoalVC)
    }
    
    
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else { return UITableViewCell() }
        
        let goal = goals[indexPath.row]
        
        cell.configureCell(goal: goal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexPath) in
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        addAction.backgroundColor = #colorLiteral(red: 0.9771530032, green: 0.7062081099, blue: 0.1748393774, alpha: 1)
        
        return [deleteAction, addAction]
    }
}

extension GoalsVC {
    
    func setProgress(atIndexPath indexPath: IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let chosenGoal = goals[indexPath.row]
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgress = chosenGoal.goalProgress + 1
        } else {
            return
        }
        
        do{
            try managedContext.save()
        } catch {
            debugPrint("Could Not set Progress : \(error.localizedDescription)")
        }
    }
    
    func fetch(completion: (_ complete: Bool) -> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        do {
           goals =  try managedContext.fetch(fetchRequest)
            completion(true)
        } catch {
            debugPrint("Could Not Fetch : \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func removeGoal(atIndexPath indexPath: IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        managedContext.delete(goals[indexPath.row])
        do {
            try managedContext.save()
        } catch {
            debugPrint("Could Not Fetch : \(error.localizedDescription)")
        }
    }
}
