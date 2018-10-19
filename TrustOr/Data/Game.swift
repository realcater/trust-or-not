//Game object created before we know the type of the game
//includes the game itself (single or crowd), its type, status
//and link to the questions

enum GameType {
    case singleGame
    case crowdGame
}
enum AnswerState {
    case notAnswered
    case answered
    case gotResults
}
class Game {
    var started = false
    var type : GameType!
    var single: SingleGame!
    var crowd: CrowdGame!
    var questionsPack: QuestionsPack!
}
