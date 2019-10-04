//
//  nextViewController.swift
//  mapAndProtocol
//
//  Created by 長坂豪士 on 2019/10/02.
//  Copyright © 2019 Tsuyoshi Nagasaka. All rights reserved.
//

import UIKit

protocol SearchLocationDelegate {
    
    func searchLocation(idoValue:String, keidoValue:String)
    
}


class nextViewController: UIViewController {

    
    @IBOutlet weak var idoTextField: UITextField!
    
    @IBOutlet weak var keidoTextField: UITextField!
    
    var delegate:SearchLocationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func okAction(_ sender: Any) {
        
        // 入力された値を取得
        let idoValue = idoTextField.text!
        let keidoValue = keidoTextField.text!
        
        // デリゲートメソッドの引数に入れる
        delegate?.searchLocation(idoValue: idoValue, keidoValue: keidoValue)
        
        // 両方のTFがnilでなければ戻る
        if idoTextField.text != nil && keidoTextField.text != nil {
            
            dismiss(animated: true, completion: nil)
        }
        
        
        
        
    
    }
    


}
