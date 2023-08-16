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

final class ColorViewController: UITabBarController {
    
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

extension UIColor {
    var rgbaValue: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}

extension ColorViewController: EditColorViewControllerDelegate {
    func setColor(from colorView: UIColor) {
        view.backgroundColor = colorView
    }
}
