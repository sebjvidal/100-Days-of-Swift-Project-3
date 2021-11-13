//
//  ViewController.swift
//  100 Days of Swift Project 2
//
//  Created by Seb Vidal on 11/11/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var label1: UILabel!
    
    var countries: [String] = []
    var score = 0
    var correctAnswer = 0
    var askedQuestions = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        countries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        applyCornerRadius(to: [button1, button2, button3])
        applyStroke(to: [button1, button2, button3])
        askQuestion()
        setScoreLabel()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    @IBAction func buttonTapped(_ button: UIButton) {
        var title: String
        var message: String
        
        if button.tag == correctAnswer {
            score += 1
            title = "Correct"
            message = "Your score is \(score)."
        } else {
            score -= 1
            title = "Wrong"
            message = "That's the flag of \(countries[button.tag].countryCase()). Your score is \(score)."
        }
        
        setScoreLabel()
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    
    func setScoreLabel() {
        let label = UILabel()
        label.text = "Score: \(score)"
        label.textColor = .secondaryLabel
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: label)
    }
    
    func applyStroke(to buttons: [UIButton]) {
        for button in buttons {
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    func applyCornerRadius(to buttons: [UIButton]) {
        for button in buttons {
            button.layer.cornerCurve = .continuous
            button.layer.cornerRadius = 10
            button.clipsToBounds = true
        }
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        if askedQuestions == 10 {
            endGame()
            return
        }
        
        countries.shuffle()
        askedQuestions += 1
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        
        setTitle()
    }
    
    func setTitle() {
        title = countries[correctAnswer].countryCase()
    }
    
    func endGame() {
        button1.isHidden = true
        button2.isHidden = true
        button3.isHidden = true
        label1.isHidden = false
        title = ""
    }
    
    @objc func shareTapped() {
        let message = "I scored \(score) in 100 Days of Swift Project 2!"
        
        let viewController = UIActivityViewController(activityItems: [message], applicationActivities: [])
        viewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(viewController, animated: true)
    }
    
}

extension String {
    func countryCase() -> String {
        if self.count <= 2 {
            return self.uppercased(with: .current)
        } else{
            return self.capitalized
        }
    }
}
