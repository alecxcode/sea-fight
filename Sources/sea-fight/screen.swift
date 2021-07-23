//Copyright (c) 2021 Alexander Vankov (Александр Ваньков)

import ANSITerminal
import Foundation

func gameTitle() {
  let intro = "A long time ahead in a sea far, far away...".lightBlue
  writeAt(5, 5, intro+"\n")
  delay(3000)
  let title = #"""

   _______   _______    _____    _______   _   _______   _     _   _______
  |  _____| |  _____|  / ___ \  |  _____| | | |  _____| | |   | | |__   __|
  | |_____  | |_____  | /___\ | | |__     | | | |       | |___| |    | |
  |_____  | |  _____| |  ___  | |  __|    | | | |    _  |  ___  |    | |
   _____| | | |_____  | |   | | | |       | | | |___| | | |   | |    | |
  |_______| |_______| |_|   |_| |_|       |_| |_______| |_|   |_|    |_|

  """#.lightBlue
  writeAt(1, 1, title+"\n")
}

func gameStartPrompt() {
  var prompt = "Press ENTER to contunie".lightBlue
  writeAt(11, 20, prompt+"\n")
  var gogame = askKey()
  if gogame {clearScreen()}
  // //код пригодится если переделвать прогу на работу с низкоуровневым вводом
  // var promptSwitcher = 1
  // repeat {
  //   switch promptSwitcher {
  //   case 1:
  //     delay(500)
  //     prompt = "Press any key to start the game".lightBlue
  //     writeAt(11, 20, prompt+"\n")
  //     promptSwitcher = 0
  //   default:
  //     delay(500)
  //     prompt = "Press any key to start the game".blue
  //     writeAt(11, 20, prompt+"\n")
  //     promptSwitcher = 1
  //   }
  // } while !keyPressed()
}

func gameEndPrompt(_ whoWins: Int) {
  delay(3000)
  clearScreen()
  var prompt = "Game Over".lightBlue.bold
    switch whoWins {
    case CONST.COMPUTER:
      prompt = "You have been defeated!".red.bold
      writeAt(11, 20, prompt+"\n\n")
      writeAt(12, 20, "Press ENTER to exit"+"\n")
    case CONST.PLAYER:
      prompt = "You win!".green.bold
      writeAt(11, 20, prompt+"\n\n")
      writeAt(12, 20, "Press ENTER to exit"+"\n")
    default:
      writeAt(11, 20, prompt+"\n\n")
      writeAt(12, 20, "Press ENTER to exit"+"\n")
    }
    var goexit = askKey()
    if goexit {clearScreen()}
}

func askCoords() -> String {
  var inputData = readLine()
  return inputData!
}

func askKey() -> Bool {
  var inputData = readLine()
  if inputData! == nil {
    return false
  } else {
    return true
  }
}

func checkInputedCoords(_ inputedCoords: String) -> Bool {
  var result = false
  var inputedCoords = inputedCoords.replacingOccurrences(of: " ", with: "")
  if inputedCoords.count == 2 && inputedCoords.range(of: #"[1-9][a-j]"#, options:.regularExpression) != nil {
    result = true
    for eachchar in inputedCoords {
      switch eachchar {
      case "1": HIT.Y = 0
      case "2": HIT.Y = 1
      case "3": HIT.Y = 2
      case "4": HIT.Y = 3
      case "5": HIT.Y = 4
      case "6": HIT.Y = 5
      case "7": HIT.Y = 6
      case "8": HIT.Y = 7
      case "9": HIT.Y = 8
      case "a": HIT.X = 0
      case "b": HIT.X = 1
      case "c": HIT.X = 2
      case "d": HIT.X = 3
      case "e": HIT.X = 4
      case "f": HIT.X = 5
      case "g": HIT.X = 6
      case "h": HIT.X = 7
      case "i": HIT.X = 8
      case "j": HIT.X = 9
      default: result = false
      }
    }
  } else if inputedCoords.count == 3 && inputedCoords.range(of: #"10[a-j]"#, options:.regularExpression) != nil {
    result = true
    for eachchar in inputedCoords {
      switch eachchar {
      case "1": HIT.Y = 9
      case "0": HIT.Y = 9
      case "a": HIT.X = 0
      case "b": HIT.X = 1
      case "c": HIT.X = 2
      case "d": HIT.X = 3
      case "e": HIT.X = 4
      case "f": HIT.X = 5
      case "g": HIT.X = 6
      case "h": HIT.X = 7
      case "i": HIT.X = 8
      case "j": HIT.X = 9
      default: result = false
      }
    }
  }
  return result
}
