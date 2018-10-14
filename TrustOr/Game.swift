enum GameType {
    case singleGame
    case crowdGame
}

class Game {
    var started = false
    var type : GameType!
    var single: SingleGame!
    var crowd: CrowdGame!
    var questionsPack: QuestionsPack!
}
