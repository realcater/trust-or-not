import UIKit

struct K {
    static let titleMargin : CGFloat = 0
    static let cornerRadius : CGFloat = 16
    static let maxHelpShowedQty = 3
    
    struct Colors {
        static let foreground = UIColor(red: 0, green: 110/256, blue: 182/256, alpha: 1)
        static let foregroundLighter = UIColor(red: 0, green: 165/256, blue: 1, alpha: 1)
        static let foregroundDarker = UIColor(red: 0, green: 73/256, blue: 121/256, alpha: 1)
        static let background = UIColor.white
        static let gray = UIColor.gray
        
        struct ResultBar {
            static let trueAnswer = UIColor(red: 0, green: 143/256, blue: 0, alpha: 1)
            static let falseAnswer = UIColor(red: 200/256, green: 0, blue: 0, alpha: 1)
        }
        struct Buttons {
            static let active = UIColor(red: 0, green: 110/256, blue: 182/256, alpha: 1)
            static let disabled = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
            static let trueAnswer = foregroundLighter
            static let doubtAnswer = foreground
            static let falseAnswer = foregroundDarker
        }
    }
    
    struct Labels {
        struct Buttons {
            static let startSingleGame = "Играем соло"
            static let startCrowdGame = "Играем компанией"
            static let continueGame = "Продолжить игру"
            
            static let showAnswer = "Показать ответ"
            static let later = "Позже"
            static let nextQuestion = "Следующий вопрос"
            static let showResults = "Результаты!"
            static let finishGame = "Спасибо за игру!"
            
            static let trust = "Верю"
            static let doubt = "Не знаю"
            static let notTrust = "Не верю"
            }
        struct Titles {
            struct ChooseGame {
                static let part1 = "Год "
                static let part2 = "!"
            }
            static let question = "Вопрос "
            static let roulette = "Animals Roulette"
            static let chooseYear = "Какой год играем?"
        }
        struct ResultBar {
            struct True {
                static let neutral = "Верно"
                static let win = "И это верно"
                static let loose = "А это верно"
            }
            struct False {
                static let neutral = "Не верно"
                static let win = "И это не верно"
                static let loose = "А это не верно"
            }
            struct Result {
                static let win = "! 🏅+1"
                static let loose = "... 🏅-1"
                static let doubt = ": 🏅0"
                static let youGain = "Вы набрали: "
            }
        }
    }
    struct Fonts {
        static let systemRegular = UIFont.systemFont(ofSize: 20, weight: .regular).fontName
        static let systemSemibold = UIFont.systemFont(ofSize: 20, weight: .semibold).fontName
        struct Size {
            struct TextView {
                static let zoomed : CGFloat = 18
                static let normal : CGFloat = 21
            }
            struct Help {
                struct Header {
                    static let zoomed: CGFloat = 17
                    static let normal: CGFloat = 22
                }
                struct Text {
                    static let zoomed: CGFloat = 15
                    static let normal: CGFloat = 20
                }
            }
            struct Intro {
                static let title : CGFloat = 36
            }
        }
    }
    struct Alpha {
        struct Background {
            static let main : CGFloat = 0.1
            static let questions : CGFloat = 0.03
        }
    }
    struct Duration {
        static let showAnimation = 1.0
        static let hideAnimation = 0.3
    }
    struct Urls {
        static let fb1 = "https://www.facebook.com/ilya.ber.5"
        static let fb2 = "https://www.facebook.com/dmitry.realcater"
    }
    struct FileNames {
        static let background = "textBackGround"
    }
}
