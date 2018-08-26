//
//  HelpViewController.swift
//  Верю-Не-верю
//
//  Created by Dmitry Dementyev on 25.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var helpTextView: UITextView!
    @objc private func singleTap(recognizer: UITapGestureRecognizer) {
        if (recognizer.state == UIGestureRecognizer.State.ended) {
            dismiss(animated: true, completion: nil)
        }
    }
    // MARK:- Override class func
    override func viewDidLoad() {
        super.viewDidLoad()
        helpTextView.text = "1. Играем компанией, от 4 человек, телефон нужен только ведущему.\n2. Ведущий озвучивает вопрос, после чего все игроки, включая вас, голосуют:\n     Согласен = Рука Поднята\n     Не согласен = Ничего\n3. Нажимаем “\(K.showAnswerButtonText)“: кто не угадал - выбывает и больше не играет.\n4. Если все ответили одинаково - нажимаем “\(K.laterButtonText)“ и вопрос задастся ещё раз на втором круге.\n5. Если определился победитель, а вопросы остались - играем заново все вместе на оставшихся вопросах!"
        popupView.layer.cornerRadius = K.cornerRadius
        
        addTaps(for: self, forSingle: #selector(singleTap))
    }
}
