//
//  ViewController.swift
//  ChatApp
//
//  Created by Anil Kumar on 12/09/18.
//  Copyright © 2018 Anil Kumar. All rights reserved.
//

import UIKit
import MaterialComponents

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPopoverPresentationControllerDelegate{
    @IBOutlet weak var Scrokk: UIScrollView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var Tabelview: UITableView!
    @IBOutlet weak var TfBgView: UIView!
    @IBOutlet weak var texfeild: UITextField!
    var tabledata : [String] = []
    let dele = MyDelegate()
    override func viewDidLoad() {
        super.viewDidLoad()
        Tabelview.delegate = self
        Tabelview.dataSource = self
        texfeild.delegate = self
        
        let Table = MDCInkTouchController(view: Tabelview)
        let Butt = MDCInkTouchController(view: sendBtn)
        let Tf = MDCInkTouchController(view: texfeild)
        Table.delegate = self as? MDCInkTouchControllerDelegate
        Table.addInkView()
        Butt.delegate = self as? MDCInkTouchControllerDelegate
        Butt.addInkView()
        Tf.delegate = self as? MDCInkTouchControllerDelegate
        Tf.addInkView()
        sendBtn.layer.cornerRadius = sendBtn.frame.height / 2
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func PopOver(_ sender: Any) {
        UIView.animate(withDuration:0.1, animations: { () -> Void in
            
          
            
            let settingsPopOverVC = self.storyboard?.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
            settingsPopOverVC.preferredContentSize = CGSize(width: 150, height: 150)
            settingsPopOverVC.modalPresentationStyle = UIModalPresentationStyle.popover
            settingsPopOverVC.popoverPresentationController?.sourceRect = CGRect(x: 400, y: 150, width: 0, height: 0)
            settingsPopOverVC.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
            settingsPopOverVC.popoverPresentationController?.delegate = self
            settingsPopOverVC.popoverPresentationController?.sourceView = self.view
            settingsPopOverVC.popoverPresentationController?.backgroundColor = UIColor.clear
            settingsPopOverVC.view.layer.borderWidth = 0
            settingsPopOverVC.view.layer.cornerRadius = 0
            settingsPopOverVC.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue:0)
            self.present(settingsPopOverVC, animated: true, completion: nil)
        })
    }
    @objc func keyboardWillShow(notification: NSNotification){
        guard let keyboardFrame = notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as? NSValue else { return }
        Scrokk.contentInset.bottom = view.convert(keyboardFrame.cgRectValue, from: nil).size.height + 20
    }
    @objc func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.Scrokk.contentInset = contentInset
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tabledata.count == 0 {
            Tabelview.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.Tabelview.setEmptyMessage("No Messages are Available!")
            return 0
        } else {
            self.Tabelview.setEmptyMessage("")
            texfeild.backgroundColor = UIColor.white
            TfBgView.backgroundColor = UIColor.init(patternImage: UIImage(named: "WB.jpg")!)
            self.Tabelview.backgroundView = UIImageView(image: UIImage(named: "WB.jpg"))
            Tabelview.transform = CGAffineTransform(scaleX: 1, y: -1)
            return tabledata.count
        }
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.selectionStyle = .blue
        cell.accessoryType = .none
        cell.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        cell.receiver.text = tabledata[indexPath.row]
        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
        cell.layoutIfNeeded()
        cell.reloadInputViews()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61
    }
    
    @IBAction func Button(_ sender: Any) {
        guard texfeild.text != nil else {
            return
        }
        if texfeild.text == "" {
        }else{
            tabledata.append(texfeild.text!)
            let count = tabledata.count
            for i in 0..<count/2 {
                (tabledata[i],tabledata[count - i - 1])  = (tabledata[count - i - 1],tabledata[i])
            }
            Tabelview.reloadData()
            texfeild.text = ""
        }
  
    }
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

}
extension UITableView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel;
        self.separatorStyle = .none;
    }
}

