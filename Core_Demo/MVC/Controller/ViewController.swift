//
//  ViewController.swift
//  Core_Demo
//
//  Created by Sagar on 09/04/19.
//  Copyright © 2019 Sagar. All rights reserved.
//

import UIKit
import Photos
import CoreData
import Toaster
import DropDown



class ViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate {

    @IBOutlet var txtFeilds : [UITextField]!
    @IBOutlet weak var segment : UISegmentedControl!
    @IBOutlet weak var btnSubmit : UIButton!
    @IBOutlet weak var viewActype : UIView!
    
    var imgData = Data()
    var imagePicker = UIImagePickerController()
    var gradientLayer: CAGradientLayer!
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFeilds[4].delegate = self
        dropDownSetUp()
    }

    override func viewWillAppear(_ animated: Bool) {
        addGradiant()
    }
    
    func dropDownSetUp(){
        dropDown.anchorView = viewActype
        let arrData = ["Saving Account","Current Account","Loan Account","Recurring Account"]
        dropDown.dataSource = arrData
        dropDown.selectionAction = { (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
             self.txtFeilds[4].text = item
        }
    }
    
    func addGradiant(){
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.btnSubmit.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 2)
        gradientLayer.endPoint = CGPoint(x: 1, y: 2)
        gradientLayer.colors = [UIColor.cyan.cgColor, UIColor.orange.cgColor]
        
        //  let cgColorsTo = [UIColor.orange.cgColor,UIColor.cyan.cgColor]
        //  let cgColorsFrom = [UIColor.cyan.cgColor,UIColor.orange.cgColor]
        
        //Location based Animation
        /*   let colorChangeAnimation = CABasicAnimation(keyPath: "colors")
         colorChangeAnimation.duration = 2.0
         colorChangeAnimation.fromValue = cgColorsFrom
         colorChangeAnimation.toValue = cgColorsTo
         colorChangeAnimation.fillMode = CAMediaTimingFillMode.both
         colorChangeAnimation.isRemovedOnCompletion = false
         colorChangeAnimation.repeatCount = Float.infinity
         gradientLayer.add(colorChangeAnimation, forKey: "colorChange")
         self.btnSubmit.layer.addSublayer(gradientLayer)*/
        
        
        //Color based Animation
        let locationsChangeAnimation = CABasicAnimation(keyPath: "locations")
        locationsChangeAnimation.duration = 2.0
        locationsChangeAnimation.fromValue = [0.0,0.0]
        locationsChangeAnimation.toValue = [0.5,0.5]
        locationsChangeAnimation.fillMode = CAMediaTimingFillMode.both
        locationsChangeAnimation.isRemovedOnCompletion = false
        locationsChangeAnimation.repeatCount = Float.infinity
        gradientLayer.add(locationsChangeAnimation, forKey: "locationsChange")
        self.btnSubmit.layer.addSublayer(gradientLayer)
    }
    func ShowToast(TostMsg strMsg : String){
        let aToast = Toast(text: strMsg)
        aToast.show()
    }
    
    //MARK:- Media PIcker Delegates

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
        self.imgData = (info[UIImagePickerController.InfoKey.editedImage] as! UIImage).pngData()!
        dismiss(animated: true, completion: nil)
    }
   
    //MARK:- TExtfeild Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtFeilds[4]{
            dropDown.show()
            textField.resignFirstResponder()
        }
    }
    
   
    
    //MARK:- Validation
    func isValidate()->Bool{
        for (index,_) in txtFeilds.enumerated(){
            if index == 0{
                if txtFeilds[index].text?.count == 0{
                    ShowToast(TostMsg: "Email is required")
                     return false
                    }
                    if !txtFeilds[index].text!.isValidEmail{
                         ShowToast(TostMsg: "Email is invalid!")
                        return false
                    }
                }
            if index == 1{
                if txtFeilds[index].text?.count == 0{
                    ShowToast(TostMsg: "Name is required")
                    return false
                }
            }
            if index == 2{
                if txtFeilds[index].text?.count == 0{
                    ShowToast(TostMsg: "Please select Gender")
                    return false
                    }
                }
            }
        return true
    }
    
    
    //MARK:- Button tap Event
    @IBAction func btnImgaeTapped(_ sender: UIButton){
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

    @IBAction func btnSubmitTapped(_ sender: UIButton){
        guard isValidate() else { return }
    //Save to Core Data
        let aUser = User(context: Presistance.context)
        aUser.email = txtFeilds[0].text
        aUser.name = txtFeilds[1].text
        aUser.gender = txtFeilds[2].text
        aUser.image = imgData as NSData
        Presistance.saveContext { (isSaved) in
            guard isSaved else { return
            }
            self.ShowToast(TostMsg: "Saved")
            for (index,_) in self.txtFeilds.enumerated(){
                self.txtFeilds[index].text = ""
            }
        }
    }
    
    @IBAction func btnShowDataTapped(_ sender: UIButton){
        let aNextVC = self.storyboard?.instantiateViewController(withIdentifier: "UserprofileVC") as! UserprofileVC
        self.navigationController?.pushViewController(aNextVC, animated: true)
    }
    
    @IBAction func GenderChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            txtFeilds[2].text =  "Male"
        }else{
            txtFeilds[2].text =  "Female"
        }
    }
    
    
}

