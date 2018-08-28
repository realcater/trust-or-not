import UIKit

struct K {
    static let foregroundColor = UIColor(red: 0, green: 110/256, blue: 182/256, alpha: 1)
    static let foregroundLighterColor = UIColor(red: 0, green: 165/256, blue: 1, alpha: 1)
    static let foregroundDarkerColor = UIColor(red: 0, green: 73/256, blue: 121/256, alpha: 1)
    
    static let backgroundColor = UIColor.white
    static let activeButtonColor = UIColor(red: 0, green: 110/256, blue: 182/256, alpha: 1)
    static let grayColor = UIColor.gray
    
    static let confirmAnimalChoiceText1 = "Год "
    static let confirmAnimalChoiceText2 = "!"
    static let questionLabel = "Вопрос "
    static let scoreLabel = "                🏅"
    static let fontSizeTextViewZoomed : CGFloat = 18
    static let fontSizeTextViewNormal : CGFloat = 21
    static let startSingleGameButtonText = "Играем соло"
    static let startCrowdGameButtonText = "Играем компанией"
    static let continueGameButtonText = "Продолжить игру"
    
    static let showAnswerButtonText = "Показать ответ"
    static let laterButtonText = "Позже"
    static let nextQuestionButtonText = "Следующий вопрос"
    static let showResultsText = "Результаты!"
    static let finishGameButtonText = "Спасибо за игру!"
    
    static let trueAnswerBarColor = UIColor(red: 0, green: 143/256, blue: 0, alpha: 1)
    static let falseAnswerBarColor = UIColor(red: 200/256, green: 0, blue: 0, alpha: 1)
    
    static let trueAnswerButtonColor = foregroundLighterColor
    static let doubtAnswerButtonColor = foregroundColor
    static let falseAnswerButtonColor = foregroundDarkerColor
    
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
    
    static let helpCrowdGameTexts1 = "В классической игре \"Верю-не-верю\" ведущий зачитывает утверждения на заданную тему, часть из которых является верными, а часть - выдумкой!\n"
    static let helpCrowdGameTexts2 = "🧐🤥\n"
    static let helpCrowdGameTexts = "В классической игре \"Верю-не-верю\" ведущий зачитывает утверждения на заданную тему, часть из которых является верными, а часть - выдумкой!\n🧐🤥\nКаждый игрок оценивает утверждение, вынося свой вердикт: \"Верно\" или \"Не верно\"\n ✅ 🤔 ❌\nВсе игроки, ответившие правильно, переходят в следующий тур и могут оценивать следующее утверждение, остальные - выбывают.\n😃😢\nИгра заканчивается, когда остаётся один игрок - он и объявляется победителем!"
    
    static let hintFontSizeDecrease : CGFloat = 6
    
    static let cornerRadius : CGFloat  = 10
    
    
    
    struct intro {
        static let showAnimationDuration = 1.0
        static let hideAnimationDuration = 0.3
        static let rouletteText = "Animals Roulette"
        static let titleFontSize : CGFloat = 36
    }
}
