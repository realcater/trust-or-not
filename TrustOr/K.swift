import UIKit

struct K {
    static let foregroundColor = UIColor(red: 0, green: 110/256, blue: 182/256, alpha: 1)
    static let backgroundColor = UIColor.white
    static let activeButtonColor = UIColor(red: 0, green: 110/256, blue: 182/256, alpha: 1)
    static let grayColor = UIColor.gray
    static let confirmAnimalChoiceText1 = "Год "
    static let confirmAnimalChoiceText2 = "!"
    static let questionLabel = "Вопрос "
    static let scoreLabel = "      🏅"
    static let fontSizeTextViewZoomed : CGFloat = 18
    static let fontSizeTextViewNormal : CGFloat = 21
    static let startSingleGameButtonText = "Играем соло"
    static let startCrowdGameButtonText = "Играем компанией"
    static let continueGameButtonText = "Продолжить игру"
    
    static let showAnswerButtonText = "Показать ответ"
    static let laterButtonText = "Позже"
    static let nextQuestionButtonText = "Следующий вопрос"
    static let finishGameButtonText = "Спасибо за игру!"
    static let trueAnswerColor = UIColor(red: 0, green: 143/256, blue: 0, alpha: 1)
    static let falseAnswerColor = UIColor(red: 200/256, green: 0, blue: 0, alpha: 1)
    static let trueAnswerButtonColor = UIColor(red: 0, green: 165/256, blue: 1, alpha: 1)
    static let falseAnswerButtonColor = UIColor(red: 0, green: 73/256, blue: 121/256, alpha: 1)
    static let doubtAnswerButtonColor = UIColor(red: 0, green: 110/256, blue: 182/256, alpha: 1)
    static let trueText = "Верно"
    static let falseText = "Не верно"
    static let trueTextWin = "И это верно"
    static let trueTextLoose = "А это верно"
    static let falseTextWin = "И это не верно"
    static let falseTextLoose = "А это не верно"
    static let doubtText = "Не знаю"
    static let trustText = "Верю"
    static let notTrustText = "Не верю"
    
    static let winResultString = "! 🏅+1"
    static let looseResultString = "... 🏅-1"
    static let doubtResultString = ": 🏅0"
    
    static let hintCrowdGameText = "1. Играем компанией, от 4 человек, телефон нужен только ведущему!2. Все игроки, включая вас:\n     Согласен = Рука Поднята\n     Не согласен = Ничего\n3. Нажимаем “\(showAnswerButtonText)“.\n4. Кто не угадал - выбывает и больше не играет.\n5. Если все ответили одинаково - “\(laterButtonText)“ и вопрос остаётся на следующий раз.\n6. Если определился победитель, а вопросы остались - играем заново все вместе на оставшихся вопросах!"
    static let hintFontSizeDecrease : CGFloat = 6
    
    struct intro {
        static let showAnimationDuration = 1.0
        static let hideAnimationDuration = 0.3
        static let rouletteText = "Animals Roulette"
        static let titleFontSize : CGFloat = 36
    }
}
