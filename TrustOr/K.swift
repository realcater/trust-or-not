import UIKit

struct K {
    static let foregroundColor = UIColor(red: 0, green: 110/256, blue: 182/256, alpha: 1)
    static let backgroundColor = UIColor.white
    static let activeButtonColor = UIColor(red: 0, green: 110/256, blue: 182/256, alpha: 1)
    static let grayColor = UIColor.gray
    static let confirmAnimalChoiceText1 = "Год "
    static let confirmAnimalChoiceText2 = "!"
    static let questionLabel = "Вопрос "
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
    static let trueText = "Верно"
    static let falseText = "Не верно"
    static let trueTextWin = "И это верно"
    static let trueTextLoose = "А это верно"
    static let falseTextWin = "И это не верно"
    static let falseTextLoose = "А это не верно"
    static let doubtText = "Не знаю"
    static let trustText = "Верю"
    static let notTrustText = "Не Верю"
    
    static let winResultString = "! +1 очко"
    static let looseResultString = "... -1 очко"
    static let doubtResultString = ": 0 очков"
    
    struct intro {
        static let showAnimationDuration = 1.0
        static let hideAnimationDuration = 0.3
        static let rouletteText = "Animals Roulette"
        static let titleFontSize : CGFloat = 36
    }
}
