//
//  ScheduleViewController.swift
//  schedule_app
//
//  Created by Акжан Калиматов on 02.01.2023.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore



class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
  

    
    
    
    
    
    @IBOutlet weak var groupLabel: UILabel!
   
    
    @IBOutlet weak var dayTableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
            super.viewDidLoad()

            groupLabel.layer.cornerRadius = 10
            groupLabel.clipsToBounds = true
            dayTableView.delegate = self
            dayTableView.dataSource = self
          
            
        
            // Activity settings
        
        
            activityView.center = self.view.center
            self.view.addSubview(activityView)
            dayTableView.isHidden = true
            groupLabel.isHidden = true
            activityView.startAnimating()
            
            
            fetchAllData()
        }
        
        func fetchAllData() {
            let db = Firestore.firestore()
            let userID = Auth.auth().currentUser?.uid
            if userID != nil {
                db.collection("Users").document(userID!).getDocument { [self] snapshot, error in
                    if error != nil {
                        print("Error")
                    }
                    else {
                        let data = snapshot!.data()
                        let groupData = data!["group"] as! String
                      
                        self.groupLabel.text = groupData
                    }
                    self.activityView.stopAnimating()
                    self.activityView.isHidden = true
                    dayTableView.isHidden = false
                    groupLabel.isHidden = false
                    
                }
                
            }
    
        
 
    }
    


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "firstDayCell", for: indexPath) as! FirstTableViewCell
   
            return cell1
        case 1:
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "secondDayCell", for: indexPath) as! SecondTableViewCell
            
            return cell2
        case 2:
            let cell3 = tableView.dequeueReusableCell(withIdentifier: "thirdDayCell", for: indexPath) as! ThirdTableViewCell
          
            return cell3
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
           
            return cell
        }
        
        
    }
    

    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    
    
    
    
}






