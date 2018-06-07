//
//  InterfaceController.swift
//  TictTacToe WatchKit App Extension
//
//  Created by Alumno on 05/06/18.
//  Copyright © 2018 Alumno. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    
    @IBOutlet var label1: WKInterfaceLabel!
    @IBOutlet var label2: WKInterfaceLabel!
    @IBOutlet var label3: WKInterfaceLabel!
    @IBOutlet var label4: WKInterfaceLabel!
    @IBOutlet var label5: WKInterfaceLabel!
    @IBOutlet var label6: WKInterfaceLabel!
    @IBOutlet var label7: WKInterfaceLabel!
    @IBOutlet var label8: WKInterfaceLabel!
    @IBOutlet var label9: WKInterfaceLabel!

    var userTurn = true
    var board = ["-", "-", "-", "-", "-", "-", "-", "-", "-"]
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func start() {
        board = ["-", "-", "-", "-", "-", "-", "-", "-", "-"]
        label1.setText("-")
        label2.setText("-")
        label3.setText("-")
        label4.setText("-")
        label5.setText("-")
        label6.setText("-")
        label7.setText("-")
        label8.setText("-")
        label9.setText("-")
        
    }
    
    func checkGameOver() -> Bool {
        var isGameOver = false
    
        if board[0] == "X" && board[1] == "X" && board[2] == "X" ||
            board[3] == "X" && board[4] == "X" && board[5] == "X" ||
            board[6] == "X" && board[7] == "X" && board[8] == "X" ||
            board[0] == "X" && board[4] == "X" && board[8] == "X" ||
            board[2] == "X" && board[4] == "X" && board[6] == "X" ||
            board[0] == "X" && board[3] == "X" && board[6] == "X" ||
            board[1] == "X" && board[4] == "X" && board[7] == "X" ||
            board[2] == "X" && board[5] == "X" && board[8] == "X" {
            isGameOver = true
            userTurn = false
            showAlert(message: "User WINS")
        }
        else if board[0] == "O" && board[1] == "O" && board[2] == "O" ||
            board[3] == "O" && board[4] == "O" && board[5] == "O" ||
            board[6] == "O" && board[7] == "O" && board[8] == "O" ||
            board[0] == "O" && board[4] == "O" && board[8] == "O" ||
            board[2] == "O" && board[4] == "O" && board[6] == "O" ||
            board[0] == "O" && board[3] == "O" && board[6] == "O" ||
            board[1] == "O" && board[4] == "O" && board[7] == "O" ||
            board[2] == "O" && board[5] == "O" && board[8] == "O" {
            isGameOver = true
            userTurn = false
            showAlert(message: "Computer WINS")
        }
        else if  board[0] != "-" && board[1] != "-" && board[2] != "-"
                && board[3] != "-" && board[4] != "-" && board[5] != "-"
            && board[6] != "-" && board[7] != "-" && board[8] != "-"{
            isGameOver = true
            userTurn = false
            showAlert(message: "It's a DRAW")
        }
        return isGameOver
    }
    
    func setMove(number: Int, mark: String){
        board[number] = mark
        switch(number) {
            case 0: label1.setText(mark)
                break
            case 1: label2.setText(mark)
                break
            case 2: label3.setText(mark)
                break
            case 3: label4.setText(mark)
                break
            case 4: label5.setText(mark)
                break
            case 5: label6.setText(mark)
                break
            case 6: label7.setText(mark)
                break
            case 7: label8.setText(mark)
                break
            case 8: label9.setText(mark)
                break
            default: break
        }
    }
    
    func checkTwoInARow(check1: Int, check2: Int, check3: Int, checkMark: String, setMark: String) -> Bool {
        var moved = false
        if board[check1] == checkMark && board[check2] == checkMark && board[check3] == "-"{
            setMove(number: check3, mark: setMark)
            moved = true
        } else if board[check1] == checkMark && board[check3] == checkMark && board[check2] == "-"{
            setMove(number: check2, mark: setMark)
            moved = true
        } else if board[check2] == checkMark && board[check3] == checkMark && board[check1] == "-"{
            setMove(number: check1, mark: setMark)
            moved = true
        }
        return moved
    }
    
    func checkWin() -> Bool{
        var moved = checkTwoInARow(check1: 0, check2: 1, check3: 2, checkMark: "O", setMark: "O")
        if !moved {
            moved = checkTwoInARow(check1: 3, check2: 4, check3: 5, checkMark: "O", setMark: "O")
            if !moved{
                moved = checkTwoInARow(check1: 6, check2: 7, check3: 8, checkMark: "O", setMark: "O")
                if !moved{
                    moved = checkTwoInARow(check1: 0, check2: 3, check3: 6, checkMark: "O", setMark: "O")
                    if !moved{
                        moved = checkTwoInARow(check1: 1, check2: 4, check3: 7, checkMark: "O", setMark: "O")
                        if !moved{
                            moved = checkTwoInARow(check1: 2, check2: 5, check3: 8, checkMark: "O", setMark: "O")
                            if !moved {
                                moved = checkTwoInARow(check1: 0, check2: 4, check3: 8, checkMark: "O", setMark: "O")
                                if !moved {
                                    moved = checkTwoInARow(check1: 2, check2: 4, check3: 6, checkMark: "O", setMark: "O")
                                }
                            }
                        }
                    }
                }
            }
        }
        return moved
    }
    
    func checkBlock() -> Bool{
        var moved = checkTwoInARow(check1: 0, check2: 1, check3: 2, checkMark: "X", setMark: "O")
        if !moved {
            moved = checkTwoInARow(check1: 3, check2: 4, check3: 5, checkMark: "X", setMark: "O")
            if !moved{
                moved = checkTwoInARow(check1: 6, check2: 7, check3: 8, checkMark: "X", setMark: "O")
                if !moved{
                    moved = checkTwoInARow(check1: 0, check2: 3, check3: 6, checkMark: "X", setMark: "O")
                    if !moved{
                        moved = checkTwoInARow(check1: 1, check2: 4, check3: 7, checkMark: "X", setMark: "O")
                        if !moved{
                            moved = checkTwoInARow(check1: 2, check2: 5, check3: 8, checkMark: "X", setMark: "O")
                            if !moved {
                                moved = checkTwoInARow(check1: 0, check2: 4, check3: 8, checkMark: "X", setMark: "O")
                                if !moved {
                                    moved = checkTwoInARow(check1: 2, check2: 4, check3: 6, checkMark: "X", setMark: "O")
                                }
                            }
                        }
                    }
                }
            }
        }
        return moved
    }
    
    func checkCenter() -> Bool {
        var moved = false
        if board[4] == "-" {
            setMove(number: 4, mark: "0")
            moved = true
        }
        return moved
    }
    
    func checkOppositeCorner() -> Bool {
        var moved = false
        if board[0] == "X" && board[8] == "-" {
            setMove(number: 8, mark: "O")
            moved = true
        } else if board[8] == "X" && board[0] == "-" {
            setMove(number: 0, mark: "O")
            moved = true
        } else if board[2] == "X" && board[6] == "-" {
            setMove(number: 6, mark: "O")
            moved = true
        } else if board[6] == "X" && board[2] == "-" {
            setMove(number: 2, mark: "O")
            moved = true
        }
        return moved
    }
    
    func checkEmptyCorner() -> Bool {
        var moved = false
        if board[0] == "-" {
            setMove(number: 0, mark: "O")
            moved = true
        } else if board[8] == "-" {
            setMove(number: 8, mark: "O")
            moved = true
        } else if board[6] == "-" {
            setMove(number: 6, mark: "O")
            moved = true
        } else if board[2] == "-" {
            setMove(number: 2, mark: "O")
            moved = true
        }
        return moved
    }
    
    func setFirstEmptyPosition(){
        var moved = false
        for index in 0...8{
            if(!moved && board[index] == "-"){
                setMove(number: index, mark: "O")
                moved = true
            }
        }
    }
    
    func makeMove(){
        if !checkGameOver(){
            if !checkWin(){
                if !checkBlock(){
                    if !checkCenter(){
                        if !checkOppositeCorner(){
                            if !checkEmptyCorner(){
                                setFirstEmptyPosition()
                            }
                        }
                    }
                }
            }
            if !checkGameOver(){
                userTurn = true
            }
        }
    }
    
    @IBAction func handleTapLabel1(_ sender: Any) {
        if board[0] == "-" {
            setMove(number: 0, mark: "X")
            userTurn = false
            makeMove()
        }
    }
    
    @IBAction func handleTapLabel2(_ sender: Any) {
        if board[1] == "-" {
            setMove(number: 1, mark: "X")
            userTurn = false
            makeMove()
        }
    }
    
    @IBAction func handleTapLabel3(_ sender: Any) {
        if board[2] == "-" {
            setMove(number: 2, mark: "X")
            userTurn = false
            makeMove()
        }
    }
    
    @IBAction func handleTapLabel4(_ sender: Any) {
        if board[3] == "-" {
            setMove(number: 3, mark: "X")
            userTurn = false
            makeMove()
        }
    }
    
    @IBAction func handleTapLabel5(_ sender: Any) {
        if board[4] == "-" {
            setMove(number: 4, mark: "X")
            userTurn = false
            makeMove()
        }
    }
    
    @IBAction func handleTapLabel6(_ sender: Any) {
        if board[5] == "-" {
            setMove(number: 5, mark: "X")
            userTurn = false
            makeMove()
        }
    }
    
    @IBAction func handleTapLabel7(_ sender: Any) {
        if board[6] == "-" {
            setMove(number: 6, mark: "X")
            userTurn = false
            makeMove()
        }
    }
    
    @IBAction func handleTapLabel8(_ sender: Any) {
        if board[7] == "-" {
            setMove(number: 7, mark: "X")
            userTurn = false
            makeMove()
        }
    }
    
    @IBAction func handleTapLabel9(_ sender: Any) {
        if board[8] == "-" {
            setMove(number: 8, mark: "X")
            userTurn = false
            makeMove()
        }
    }
    
    func showAlert(message: String){
        let action1 = WKAlertAction(title: "OK", style: .cancel){}
        presentAlert(withTitle: "Game Over", message: message, preferredStyle: .actionSheet, actions: [action1])
    }
}
