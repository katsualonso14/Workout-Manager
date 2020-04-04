
//  ViewController.swift
//  WorkOutApp
//
//  Created by 玉井　勝也 on 2020/02/27.
//  Copyright © 2020 katsuya tamai. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource,UIScrollViewDelegate {
    
    let workOutMenu = ["腕","胸","肩","背中","腹","足","その他"]
    var picker:String!
    var workOutDay:String!
//    let sc = UIScrollView();


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
//    Picker View の列を１にする
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return workOutMenu.count
    }
//    Picker View の行数は配列数にする
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return workOutMenu[row]
    }
//    表示する文字列を指定する
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         picker = workOutMenu[row]
    }
//    表示する
    
    @IBOutlet weak var workOutPickerView:
    UIPickerView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var WOText: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBAction func doneButton(_ sender: Any) {
        //まずは、同じstororyboard内であることをここで定義します
    let storyboard: UIStoryboard = self.storyboard!
    //ここで移動先のstoryboardを選択(今回の場合は先ほどsecondと名付けたのでそれを書きます)
    let calendar = storyboard.instantiateViewController(withIdentifier: "calendar") as! CalendarViewController

        //datePickerで指定した日付が表示される
        workOutDay = "\(self.format(date: datePicker.date))"
        
        let realm = try! Realm()
        try! realm.write {
        //日付表示の内容とスケジュール入力の内容が書き込まれる。
            let Events = [Event(value: ["date": workOutDay, "event": picker ?? "腕" + "　" + WOText.text])]
            realm.add(Events)
            print("データ書き込み中")
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        }
        
           
    //ここが実際に移動するコードとなります
    self.present(calendar, animated: true, completion: nil)
        
    }

    
    @IBAction func calendarButton(_ sender: Any) {
        let storyboard: UIStoryboard = self.storyboard!
           let calendar = storyboard.instantiateViewController(withIdentifier: "calendar")
        
           self.present(calendar, animated: true, completion: nil)
    }
    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//
//        return true
//    }
    
    
    override func viewDidLoad() {
                super.viewDidLoad()
            
        //        ピッカービューのデリゲートの設定
               workOutPickerView.delegate = self
               workOutPickerView.dataSource = self
                 
        WOText.text = ""
        WOText.layer.borderColor = UIColor.gray.cgColor
        WOText.layer.borderWidth = 1.0
        WOText.layer.cornerRadius = 10.0
//        view.addSubview(WOText)
        
        doneButton.layer.cornerRadius = 10.0
        
        
      
            }

    
       func format(date:Date)->String{
              
              let dateformatter = DateFormatter()
              dateformatter.dateFormat = "yyyy/MM/dd"
              let strDate = dateformatter.string(from: date)
              
              return strDate
    }
   
   
    
    
}

