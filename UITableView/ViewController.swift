//
//  ViewController.swift
//  UITableView
//
//  Created by Rodion on 14/06/2019.
//  Copyright © 2019 Rodion. All rights reserved.


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    let identifier = "myCell"
    var array = ["1", "2", "3", "4"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func editTable(_ sender: Any) {
        myTableView.isEditing = !myTableView.isEditing // возможность редактирования ячеек
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let number = array[indexPath.row]
        cell.textLabel?.text = number
        return cell
    }
    
    // delete
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            array.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    // move cell
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = array[sourceIndexPath.row]
        array.remove(at: sourceIndexPath.row)
        array.insert(item, at: destinationIndexPath.row)
        
    }
    
    // cute, copy, paste
    
    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
       
        if action == #selector(copy(_:)) {
            print("Copy")
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        if action == #selector(copy(_:)) {
            let cell = tableView.cellForRow(at: indexPath)
            let pasteBoard = UIPasteboard.general
            pasteBoard.string = cell?.textLabel?.text
        }
    }
    
    
}
