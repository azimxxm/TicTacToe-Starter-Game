//
//  GameVC.swift
//  TicTacToe
//
//  Created by Azimjon on 12/10/22.
//  Copyright © 2022 Macco. All rights reserved.
//

import UIKit

class GameVC: UIViewController {
    
    @IBOutlet weak var box1: UIImageView!
    @IBOutlet weak var box2: UIImageView!
    @IBOutlet weak var box3: UIImageView!
    @IBOutlet weak var box4: UIImageView!
    @IBOutlet weak var box5: UIImageView!
    @IBOutlet weak var box6: UIImageView!
    @IBOutlet weak var box7: UIImageView!
    @IBOutlet weak var box8: UIImageView!
    @IBOutlet weak var box9: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var playerScoreLbl: UILabel!
    @IBOutlet weak var compyuterScoreLbl: UILabel!
    var playerName:String?
    var lastValue: String = "o"
    var playerChouces: [Box] = []
    var compyuterChouces: [Box] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if playerName?.isEmpty != nil {
            nameLbl.text = "Player: "
        } else {
            nameLbl.text = playerName
        }
        
        createTap(on: box1, type: .one)
        createTap(on: box2, type: .two)
        createTap(on: box3, type: .three)
        createTap(on: box4, type: .four)
        createTap(on: box5, type: .five)
        createTap(on: box6, type: .six)
        createTap(on: box7, type: .seven)
        createTap(on: box8, type: .eight)
        createTap(on: box9, type: .nine)
    }
    
    func createTap(on imageView: UIImageView, type box:Box) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(boxClicked(_:)))
        tap.name = box.rawValue
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
    }
    

    
    @objc func boxClicked(_ sender: UITapGestureRecognizer) {
        let selectBox = getBox(form: sender.name ?? "" )
        makeChoice(selectBox)
        checkIfWon()
        playerChouces.append(Box(rawValue: sender.name!)!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.compyuterPlay()
        }
    }
    
    
    func compyuterPlay() {
        var availableSpace = [UIImageView]()
        var availableBoxes = [Box]()
        for name in Box.allCases {
            let box = getBox(form: name.rawValue)
            if box.image == nil {
                availableSpace.append(box)
                availableBoxes.append(name)
            }
        }
        
        guard availableBoxes.count > 0 else { return }
        
       let randIndex = Int.random(in: 0 ..< availableSpace.count)
        makeChoice(availableSpace[randIndex])
        compyuterChouces.append(availableBoxes[randIndex])
        checkIfWon()
    }
    
    func makeChoice(_ selectedBox: UIImageView) {
        guard selectedBox.image == nil else { return }
        
        if lastValue == "x" {
            selectedBox.image = #imageLiteral(resourceName: "icons-circled")
            lastValue = "o"
        } else {
            selectedBox.image = #imageLiteral(resourceName: "icons-multiply")
            lastValue = "x"
        }
    }
    
    func checkIfWon() {
        var currect = [[Box]]()
        let firstRow:[Box] = [.one, .two, .three]
        let secendRow:[Box] = [.four, .five, .six]
        let thirdRow:[Box] = [.seven, .eight, .nine]
        
        let firstCol:[Box] = [.one, .two, .three]
        let secendCol:[Box] = [.four, .five, .six]
        let thirdCol:[Box] = [.four, .five, .six]
        
        let backWorldSlash:[Box] = [.one, .five, .nine]
        let forwardSlash:[Box] = [.three, .five, .seven]
        
        currect.append(firstRow)
        currect.append(secendRow)
        currect.append(thirdRow)
        currect.append(firstCol)
        currect.append(secendCol)
        currect.append(thirdCol)
        currect.append(backWorldSlash)
        currect.append(forwardSlash)
        
        for valid in currect {
            let userMatch = playerChouces.filter { valid.contains($0)}.count
            let compyuterMatch = compyuterChouces.filter { valid.contains($0)}.count
            
            if userMatch == valid.count {
                playerScoreLbl.text = String((Int(playerScoreLbl.text ?? "0") ?? 0)+1)
                resetGame()
                break
            } else if compyuterMatch == valid.count {
                compyuterScoreLbl.text = String((Int(compyuterScoreLbl.text ?? "0") ?? 0)+1)
                resetGame()
                break
            } else if compyuterChouces.count + playerChouces.count == 9 {
                resetGame()
                break             }
        }
    }
    
    
    func resetGame() {
        for name in Box.allCases {
            let box = getBox(form: name.rawValue)
            box.image = nil
        }
        lastValue = "o"
        playerChouces = []
        compyuterChouces = []
    }
    
    func getBox(form name:String) -> UIImageView {
        let box = Box(rawValue: name) ?? .one
        
        switch box {
        case .one:
            return box1
        case .two:
            return box2
        case .three:
            return box3
        case .four:
            return box4
        case .five:
            return box5
        case .six:
            return box6
        case .seven:
            return box7
        case .eight:
            return box8
        case .nine:
            return box9
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    

}

enum Box: String, CaseIterable {
    case one, two, three, four, five, six, seven, eight, nine
}
