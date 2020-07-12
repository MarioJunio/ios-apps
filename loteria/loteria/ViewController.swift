//
//  Created by Mario Martins on 11/07/20.
//  Copyright © 2020 Mario Martins. All rights reserved.
//

import UIKit

enum GameType: String {
    case megaSena = "Mega sena"
    case quina = "Quina"
}

infix operator >-<
func >-< (size: Int, universe: Int) -> [Int] {
    var result: [Int] = []
        
    while (result.count < 6) {
        let number: Int = Int(arc4random_uniform(UInt32(universe)) + 1)
        
        if (!result.contains(number)) {
            result.append(number)
        }
    }
    
    return result;
}

class ViewController: UIViewController {
    
    @IBOutlet weak var lbType: UILabel!
    @IBOutlet weak var gameTypes: UISegmentedControl!
    @IBOutlet var gameNumbers: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.gameTypes.setTitleTextAttributes(titleTextAttributes, for: .selected)
        
        self.startGame()
    }

    @IBAction func generateGame(_ sender: Any) {
        
        self.lbType.text = self.currentSelectedGameType() == GameType.megaSena ? "Mega Sena" : "Quina"
        self.gameNumbers.last?.isHidden = currentSelectedGameType() == .quina
        
        self.startGame()
    }
    
    func startGame() {
        let numbers: [Int] = generateNumbers(for: self.currentSelectedGameType())
        
        for (i, n) in numbers.enumerated() {
            self.gameNumbers[i].setTitle(String(n), for: .normal)
        }
        
    }
    
    func generateNumbers(for type: GameType) -> [Int] {
        return type == GameType.megaSena ? 6>-<60 : 5>-<80
    }
    
    func currentSelectedGameType() -> GameType {
        return self.gameTypes.selectedSegmentIndex == 0 ? .megaSena : .quina
    }
    
}

