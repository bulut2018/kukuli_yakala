//
//  ViewController.swift
//  KukuliYakala
//
//  Created by Haydar bulut on 19.09.2022.
//

import UIKit

class ViewController: UIViewController {

    var score = 0
    var timer = Timer()
    var counter = 0
    var kukuliArray = [UIImageView]()
    var highTimer = Timer()
    var highScore = 0
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var highscoreLabel: UILabel!
    
    
    @IBOutlet weak var kukuli1: UIImageView!
    
    @IBOutlet weak var kukuli2: UIImageView!
    
    @IBOutlet weak var kukuli3: UIImageView!
    
    @IBOutlet weak var kukuli4: UIImageView!
    
    @IBOutlet weak var kukuli5: UIImageView!
    
    @IBOutlet weak var kukuli6: UIImageView!
    
    @IBOutlet weak var kukuli7: UIImageView!
    
    @IBOutlet weak var kukuli8: UIImageView!
    
    @IBOutlet weak var kukuli9: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: \(score)"
        
        //Highscore check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highscoreLabel.text = "Highscore : \(highScore)"
            
        }
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highscoreLabel.text = "Highscore: \(highScore)"
        }
        
        
        kukuli1.isUserInteractionEnabled = true
        kukuli2.isUserInteractionEnabled = true
        kukuli3.isUserInteractionEnabled = true
        kukuli4.isUserInteractionEnabled = true
        kukuli5.isUserInteractionEnabled = true
        kukuli6.isUserInteractionEnabled = true
        kukuli7.isUserInteractionEnabled = true
        kukuli8.isUserInteractionEnabled = true
        kukuli9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))

        kukuli1.addGestureRecognizer(recognizer1)
        kukuli2.addGestureRecognizer(recognizer2)
        kukuli3.addGestureRecognizer(recognizer3)
        kukuli4.addGestureRecognizer(recognizer4)
        kukuli5.addGestureRecognizer(recognizer5)
        kukuli6.addGestureRecognizer(recognizer6)
        kukuli7.addGestureRecognizer(recognizer7)
        kukuli8.addGestureRecognizer(recognizer8)
        kukuli9.addGestureRecognizer(recognizer9)
        
        kukuliArray = [kukuli1,kukuli2,kukuli3,kukuli4,kukuli5,kukuli6,kukuli7,kukuli8,kukuli9]
        //Timers
        counter = 10
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        highTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKukuli), userInfo: nil, repeats: true)
        
        hideKukuli()
        
    }

    @objc func hideKukuli(){
        for kukuli in kukuliArray{
            kukuli.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(kukuliArray.count - 1)))
        kukuliArray[random].isHidden = false
    }
    
    @objc func increaseScore(){
        
        score += 1

        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown(){
        
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            highTimer.invalidate()
            
            for kukuli in kukuliArray{
                kukuli.isHidden = true
            }
            
            //HighScore
            if self.score > self.highScore{
                self.highScore = self.score
                highscoreLabel.text = "Highscore : \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            //Alert
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default){
                (UIAlertAction) in
                //Replay Fonk
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.highTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKukuli), userInfo: nil, repeats: true)
                
                
                
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
            
            
            
            
        }
        
        
    }

}

