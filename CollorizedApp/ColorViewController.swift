//
//  ColorViewController.swift
//  CollorizedApp
//
//  Created by Екатерина Теляубердина on 15.08.2023.
//

import UIKit

protocol EditColorViewControllerDelegate: AnyObject {
    func setColor(from colorView: UIColor)
}

final class ColorViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let editColorVC = segue.destination as? EditColorViewController else { return }
        editColorVC.color = view.backgroundColor
        editColorVC.delegate = self
    }
}

// MARK: - EditColorViewControllerDelegate
extension ColorViewController: EditColorViewControllerDelegate {
    func setColor(from colorView: UIColor) {
        view.backgroundColor = colorView
    }
}
