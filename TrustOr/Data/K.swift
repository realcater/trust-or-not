import UIKit

struct K {
    static let useSmallerFonts = (UIScreen.main.currentMode!.size.width >= 750) ? false : true
    static let cornerRadius : CGFloat = 16
    static let maxHelpShowedQty = 3
    static let helpPagesAll = [Int](0...8)
    static let helpPages = [GameType.singleGame: [4], GameType.crowdGame: [Int](5...8)]
    static let funnyGameAnimalsQty = 12
    static let hyphenationFactor: Float = 0.5
    
    struct Sounds {
        static let click = initSound(filename: "click.wav", volume: 0.2)
        static let correct = initSound(filename: "true.wav", volume: 0.2)
        static let error = initSound(filename: "false.wav", volume: 0.5)
        static let page = initSound(filename: "page.mp3", volume: 0.2)
        static let applause = initSound(filename: "applause.wav")
        static let rotate = initSound(filename: "rotate.wav")
    }
    
    struct Margins {
        static let title : CGFloat = 0
        static let helpScreen: CGFloat = 0
        struct FromQuestion {
            static let toResultLabel: CGFloat = 15
            static let toTopButton: CGFloat = -50
        }
    }
    
    struct Colors {
        static let foreground = UIColor(red: 0, green: 110/256, blue: 182/256, alpha: 1)
        static let foregroundLighter = UIColor(red: 0, green: 165/256, blue: 1, alpha: 1)
        static let foregroundDarker = UIColor(red: 0, green: 73/256, blue: 121/256, alpha: 1)
        static let background = UIColor.white
        static let gray = UIColor.gray
        static let funnyGameResults = UIColor.red
        
        static let resultBar = [true: UIColor(red: 0, green: 143/256, blue: 0, alpha: 1),
                                false: UIColor(red: 200/256, green: 0, blue: 0, alpha: 1)]
        struct Buttons {
            static let active = UIColor(red: 0, green: 110/256, blue: 182/256, alpha: 1)
            static let disabled = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
            static let topChoice = [GameType.singleGame: foregroundLighter,
                                    GameType.crowdGame: gray]
            static let bottomChoice = [GameType.singleGame: foreground,
                                    GameType.crowdGame: foreground]
            
        }
    }
    
    struct Labels {
        struct Buttons {
            static let startSingleGame = "Играем соло"
            static let startCrowdGame = "Играем компанией"
            static let continueGame = "Продолжить игру"
            
            static let nextQuestion = "Следующий вопрос"
            static let showResults = "Результаты!"
            static let finishGame = "Спасибо за игру!"
            
            static let topChoice = [GameType.singleGame: "Верю",
                                    GameType.crowdGame: "Позже"]
            static let bottomChoice = [GameType.singleGame: "Не верю",
                                       GameType.crowdGame: "Показать ответ"]
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
                static let neutral = "Это верно"
                static let win = "И это верно"
                static let loose = "А это верно"
            }
            struct False {
                static let neutral = "Это не верно"
                static let win = "И это не верно"
                static let loose = "А это не верно"
            }
            struct Result {
                static let win = "! 🏅+1"
                static let loose = "..."
                static let youGain = "Вы набрали: 🏅"
            }
        }
        struct FunnyGame {
            static let win = " wins!"
        }
    }
    struct Fonts {
        struct Name {
            static let systemRegular = UIFont.systemFont(ofSize: 20, weight: .regular).fontName
            static let systemSemibold = UIFont.systemFont(ofSize: 20, weight: .semibold).fontName
            static let intro = "Brushie Brushie"
        }
        struct Size {
            struct TextView {
                static let zoomed : CGFloat = 18
                static let normal : CGFloat = 21
            }
            struct ResultLabel {
                static let zoomed : CGFloat = 21
                static let normal : CGFloat = 24
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
                static let atStart: CGFloat = 50
                static let inFunnyGame: CGFloat = 36
            }
            static let naviBar: CGFloat = 20
        }
    }
    struct Alpha {
        struct Background {
            static let main : CGFloat = 0.1
            static let questions : CGFloat = 0.04
        }
    }
    struct Duration {
        static let pageChangeViaPageControl = 0.3
        struct FunnyGame {
            static let showAnimation = 1.0
            static let hideAnimation = 0.3
            static let playRotation: TimeInterval = 4.7
            static let playApplause: TimeInterval = 4.0
        }
    }
    struct Delay {
        static let flashScrollIndicators = 0.1
    }
    struct Urls {
        static let fb1 = "https://www.facebook.com/ilya.ber.5"
        static let fb2 = "https://www.facebook.com/dmitry.realcater"
    }
    struct FileNames {
        static let background = "textBackground"
    }
    struct AnimalButtons {
        static let columnsQty = 3
        static let rowsQty = 4
        static let marginX: CGFloat = 0
        static let marginTop: CGFloat = 90
        static let marginBottom: CGFloat = 55
    }
    static let resultTexts = Array([
        12:
        "Да, с этим годом у вас явно сложные отношения - будем откровенны, не самый высокий результат... Но всегда есть куда стремиться! Может, попробовать другой год?",
        14:
        "Поздравляем! Вы вошли в число 29% людей, которые лучше всего справились с данным заданием! В логике или удачи вам не откажешь!",
        16:
        "Поздравляем! Вы вошли в число 7% людей, которые лучше всего справились с данным заданием! Вы чертовски умны и сообразительны или просто на короткой ноге с Тюхе",
        18:
        "Фантастический результат! Вы вошли в число 2% людей, которые лучше всего справились с данным заданием! Вашей эрудиции и логике можно только позавидовать!",
        19:
        "Нереальный результат! Вы вошли в число 0.3% людей, которые лучше всего справились с данным заданием! Срочно играть в ”Что? Где? Когда?”!",
        100:
        "Все ответы верные? Серьёзно! Одно из двух: или вы играете не в первый раз, или ваша фамилия - Бер!"
        ]).sorted(by: <)
}
