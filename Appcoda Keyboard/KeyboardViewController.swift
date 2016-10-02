//
//  KeyboardViewController.swift
//  Appcoda Keyboard
//
//  Created by Joyce Echessa on 10/27/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    var capsLockOn = true
    var text = ""
    var emojiDict = [String: String]()
    var alphabet = ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "a", "s", "d", "f", "g", "h", "j", "k", "l", "z", "x", "c", "v", "b", "n", "m", "!", "?", "$"]
    
    @IBOutlet weak var row1: UIView!
    @IBOutlet weak var row2: UIView!
    @IBOutlet weak var row3: UIView!
    @IBOutlet weak var row4: UIView!
    
    @IBOutlet weak var charSet1: UIView!
    @IBOutlet weak var charSet2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "KeyboardView", bundle: nil)
        let objects = nib.instantiate(withOwner: self, options: nil)
        view = objects[0] as! UIView;
        
        emojiDict["poop"] = "💩"
        emojiDict["i"] = "👀"
        emojiDict["love"] = "❤️"
        emojiDict["money"] = "💰"
        emojiDict["!"] = "❗"
        emojiDict["?"] = "❓"
        emojiDict["$"] = "💵"
        emojiDict["power"] = "💪🏼"
        emojiDict["friends"] = "👫"
        emojiDict["happiness"] = "😊"
        emojiDict["hi"] = "👋"
        emojiDict["world"] = "🌍"
        
        charSet2.isHidden = true
    }
    
    @IBAction func nextKeyboardPressed(_ button: UIButton) {
        advanceToNextInputMode()
    }
    
    @IBAction func capsLockPressed(_ button: UIButton) {
        capsLockOn = !capsLockOn
        
        changeCaps(containerView: self.row1)
        changeCaps(containerView: self.row2)
        changeCaps(containerView: self.row3)
        changeCaps(containerView: self.row4)
    }
    
    
    func changeCaps(containerView: UIView) {
        for view in containerView.subviews {
            if let button = view as? UIButton {
                let buttonTitle = button.titleLabel!.text
                if capsLockOn {
                    let text = buttonTitle!.uppercased()
                    button.setTitle("\(text)", for: .normal)
                } else {
                    let text = buttonTitle!.lowercased()
                    button.setTitle("\(text)", for: .normal)
                }
            }
        }
    }
    
    @IBAction func keyPressed(_ button: UIButton) {
        let string = button.titleLabel!.text
        (textDocumentProxy as UIKeyInput).insertText("\(string!)")
        self.text += string!
        
        UIView.animate(withDuration: 0.2 ,
                                   animations: {
                                    button.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.2){
                                        button.transform = CGAffineTransform.identity
                                    }
        })
    }
    
    @IBAction func backSpacePressed(_ button: UIButton) {
        (textDocumentProxy as UIKeyInput).deleteBackward()
        
        if (!self.text.isEmpty) {
            let index = self.text.index(self.text.endIndex, offsetBy: -1)
            self.text = self.text.substring(to: index)
        }
    }
    
    @IBAction func spacePressed(_ button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText(" ")
        self.text += " "
    }
    
    @IBAction func returnPressed(_ button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText("\n")
        self.text += " "
    }
    @IBAction func charSetPressed(_ button: UIButton) {
        self.text = self.text.lowercased()
        self.text = self.text.replacingOccurrences(of: "@", with: "")
        self.text = self.text.replacingOccurrences(of: "#", with: "")
        self.text = self.text.replacingOccurrences(of: "$", with: " $ ")
        self.text = self.text.replacingOccurrences(of: "%", with: "")
        self.text = self.text.replacingOccurrences(of: "^", with: "")
        self.text = self.text.replacingOccurrences(of: "&", with: "")
        self.text = self.text.replacingOccurrences(of: "*", with: "")
        self.text = self.text.replacingOccurrences(of: ".", with: "")
        self.text = self.text.replacingOccurrences(of: ",", with: "")
        self.text = self.text.replacingOccurrences(of: "!", with: " ! ")
        self.text = self.text.replacingOccurrences(of: "?", with: " ? ")
        
        for _ in 0...1000 {
            (textDocumentProxy as UIKeyInput).deleteBackward()
        }
        
        let strArray: [String] = self.text.components(separatedBy: " ")
        self.text = ""
        
        for s in strArray {
            if (s.isEmpty) {
                continue
            }
            
            let oink = s.substring(to: s.index(s.startIndex, offsetBy: 1))
            
            if !self.alphabet.contains(oink) {
                self.text += s
                (textDocumentProxy as UIKeyInput).insertText(s)
            }
            else if let str = self.emojiDict[s] {
                self.text += str
                (textDocumentProxy as UIKeyInput).insertText(str)
            }
        }
        
        self.text = self.text + " "
        (textDocumentProxy as UIKeyInput).insertText(" ")

    }

}
