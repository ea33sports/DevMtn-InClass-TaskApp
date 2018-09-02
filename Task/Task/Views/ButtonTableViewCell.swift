//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by Eric Andersen on 8/29/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

import UIKit

protocol ButtonTableViewCellDelegate: class {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell)
}

class ButtonTableViewCell: UITableViewCell {
    
    weak var delegate: ButtonTableViewCellDelegate?

    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    
    func updateButton(_ isComplete: Bool) {
        let imageName = isComplete ? "complete" : "incomplete"
        completeButton.setImage(UIImage(named: imageName), for: .normal)
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        delegate?.buttonCellButtonTapped(self)
    }
}

extension ButtonTableViewCell {
    
    func update(withTask task: Task) {
        primaryLabel.text = task.name
        updateButton(task.isComplete)
    }
}
