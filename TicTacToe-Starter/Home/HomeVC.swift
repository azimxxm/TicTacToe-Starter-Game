//
//  HomeVC.swift
//  TicTacToe
//
//  Created by Azimjon on 12/10/22.
//  Copyright © 2022 Macco. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var nameTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        startBtn.layer.cornerRadius = 10
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowOpacity = 0.4
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowRadius = 10
        cardView.layer.shadowOffset = .zero
    }
    

    @IBAction func startBtnPressed(_ sender: UIButton) {
        let gameVC = GameVC(nibName: "GameVC", bundle: nil)
        gameVC.modalPresentationStyle = .fullScreen
        modalTransitionStyle = .crossDissolve
        gameVC.playerName = "\(nameTF.text!): "
        self.present(gameVC, animated: true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTF.resignFirstResponder()
    }

}
