//
//  UpdateProfileVC.swift
//  Core_Demo
//
//  Created by Sagar on 15/04/19.
//  Copyright © 2019 Sagar. All rights reserved.
//

import UIKit
import CoreData
import Photos

class UpdateProfileVC: UIViewController,UITextFieldDelegate {

      @IBOutlet weak var tblViewUpdate : UITableView!
    
    var selectedIndex = Int()
    var aUserData = User()
    var arrUpdatedata = ["","",""]
    var imgData = Data()
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       OnLoadOpration()
    }
    
    func OnLoadOpration(){
        tblViewUpdate.tableFooterView = UIView()
        arrUpdatedata[0] = aUserData.name ?? ""
        arrUpdatedata[1] = aUserData.email ?? ""
        arrUpdatedata[2] = aUserData.gender ?? ""
    }
    
    @objc func OpenGallery(){
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    self.imagePicker.delegate = self
                    self.imagePicker.allowsEditing = true
                    self.imagePicker.sourceType = .photoLibrary
                    self.imagePicker.mediaTypes = ["public.image"]
                    self.imagePicker.view.tag = 55
                    self.present(self.imagePicker, animated: true, completion: nil)
                } else {
                    
                }
            })
        }else if photos == .authorized{
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.mediaTypes = ["public.image"]
            self.imagePicker.view.tag = 55
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    //MARK:- TextFeild Delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if textField.tag == 0 {
            print(updatedText)
            arrUpdatedata[0] = updatedText
        }
        else if textField.tag == 1 {
            print(updatedText)
            arrUpdatedata[1] = updatedText
        }
        else if textField.tag == 2 {
            print(updatedText)
            arrUpdatedata[2] = updatedText
        }
        return true
    }
    
    //MARK:- Button Tap Event
    @IBAction func btnSaveTapped(_ sender: UIButton){
        let aTuple = (arrUpdatedata,imgData as NSData)
        Presistance.updateData(aTupleData: aTuple) { (isUpdated) in
            if isUpdated {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    @IBAction func btnBackTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension UpdateProfileVC : UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
        self.imgData = (info[UIImagePickerController.InfoKey.editedImage] as! UIImage).pngData()!
        dismiss(animated: true, completion: nil)
        self.tblViewUpdate.reloadData()
    }
}

extension UpdateProfileVC : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUpdatedata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aCell = tableView.dequeueReusableCell(withIdentifier: "profileUpdateTblCell", for: indexPath) as! profileUpdateTblCell
        aCell.txtFeilds.text = arrUpdatedata[indexPath.row]
        aCell.txtFeilds.tag = indexPath.row
        aCell.txtFeilds.delegate = self
        aCell.selectionStyle = .none
        return aCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         let headerView : ProfileImageHeaderView = Bundle.main.loadNibNamed("ProfileImageHeaderView", owner: self, options: nil)![0] as! ProfileImageHeaderView
        headerView.imgProfileView.image = UIImage(data: imgData)
        headerView.imgProfileView.layer.cornerRadius = headerView.imgProfileView.frame.height/2
        headerView.imgProfileView.clipsToBounds = true
        headerView.btnTapGallery.addTarget(self, action: #selector(OpenGallery), for: .touchUpInside)
        
        return headerView
    }
    
}

class profileUpdateTblCell: UITableViewCell {
    
    @IBOutlet weak var txtFeilds : UITextField!
    
}
