//
//  UserprofileVC.swift
//  Core_Demo
//
//  Created by Sagar on 13/04/19.
//  Copyright © 2019 Sagar. All rights reserved.
//

import UIKit
import CoreData

class UserprofileVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tblViewUser : UITableView!
    
    var arrUser = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tblViewUser.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
          fetchData()
    }

    //MARK:- Table View Delegate & DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let aCell = tableView.dequeueReusableCell(withIdentifier:"profileCell", for: indexPath) as! profileCell
        aCell.lblEmail.text = arrUser[indexPath.row].email
        aCell.lblName.text = arrUser[indexPath.row].name
        aCell.imgViewProfile.layer.cornerRadius =  aCell.imgViewProfile.frame.height / 2
        aCell.imgViewProfile.clipsToBounds = true
        aCell.imgViewProfile.image = UIImage(data:  Data(referencing: arrUser[indexPath.row].image!))
        return aCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexpath) in
                Presistance.context.delete(self.arrUser[indexpath.row] as NSManagedObject)
                self.arrUser.remove(at: indexpath.row)
                 self.tblViewUser.deleteRows(at: [indexPath], with: .none)
                let _ : NSError! = nil
                do {
                    try Presistance.context.save()
                } catch {
                    print("error : \(error)")
                }
        }
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
        
            let aUpdateVC = self.storyboard?.instantiateViewController(withIdentifier: "UpdateProfileVC") as! UpdateProfileVC
            aUpdateVC.imgData = self.arrUser[indexPath.row].image! as Data
            aUpdateVC.aUserData = self.arrUser[indexPath.row]
            self.navigationController?.pushViewController(aUpdateVC, animated: true)
            
        }
            edit.backgroundColor = UIColor.lightGray
        
        return [edit,delete]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
        
    }
    
    
    //MARK:- Fetch from Core Data
    
    func fetchData(){
        let aFetchRequest : NSFetchRequest<User> = User.fetchRequest()
        do{
             let arrUserData = try Presistance.context.fetch(aFetchRequest)
            self.arrUser = arrUserData
            self.tblViewUser.reloadData()
        }catch{
            //handel Faild block
        }
    }
        
    
    //MARK:- Button tap Event
    @IBAction func btnBackTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
