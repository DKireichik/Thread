//
//  ViewController.swift
//  Thread
//
//  Created by Darya on 10.01.24.
//

import UIKit

class BankAccount {
    var balance : Double = 0
    private let lock = NSLock()
    
    func deposit ( amount : Double ) {
        lock.lock()
        balance += amount
        print("Пополнение: \(amount), итого : \(balance)")
        lock.unlock()
    }
    
    func withdraw ( amount : Double ) {
        lock.lock()
        if balance >= amount {
            balance -= amount
        } else {
            print ("Недостаточно средств")
        }
        print("Снятие: \(amount), итого : \(balance)")
        lock.unlock()
    }
}

class ViewController: UIViewController {

    let bankAccount = BankAccount()
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        let firstThread = Thread {
            self.bankAccount.deposit(amount: 15)
        }
        
        let secondThread = Thread {
            self.bankAccount.withdraw(amount: 10)
        }
        
        firstThread.start()
        secondThread.start()
        
    }


}

