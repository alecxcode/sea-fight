//Copyright (c) 2021 Alexander Vankov (Александр Ваньков)

import ANSITerminal
import Foundation

cursorOff()
clearScreen()
@inlinable public func writeAt(_ row: Int, _ col: Int, _ text: String) {
  moveTo(row, col)
  write(text)
}

struct CONST {
  static let PLAYER:   Int = 1
  static let COMPUTER: Int = 0
  static let VERTICAL:   Int = 1
  static let HORISONTAL: Int = 0
}

struct HIT {
  static var Y: Int = 0
  static var X: Int = 0
}

var ships = [Ship]()

gameTitle()
gameStartPrompt()
cursorOn()

writeAt(1, 25, "SEA FIGHT".lightBlue.bold)

let playerField = Field(name: "PLAYER", mode: CONST.PLAYER)
playerField.writeField(5, 5)

let compField = Field(name: "COMPUTER", mode: CONST.COMPUTER)
compField.writeField(5, 32)

let comp = computer()

var inputData = ""
writeAt(20, 5, "Enter a coorditate to HIT! (e.g.: 1a, 2b, 10c):".green)
writeAt(19, 5, "Command+.(Mac) or CTRL+C(PC) or to quit".green)

var quit = false
var coordsToHIT = ""
var compAlive = true
var playerAlive = true
var destuctCheck = false
var WINNER = 2
var whoHits = CONST.PLAYER
var playerHitResult = false
var compHitResult = false

// Главный цикл игры:
while quit == false {
  if whoHits == CONST.PLAYER {
    moveTo(20, 53); clearToEndOfLine()
    coordsToHIT = askCoords()
    if checkInputedCoords(coordsToHIT) {
      moveTo(21,5); clearLine()
      writeAt(21, 5, "A HIT into COMPUTER's \(coordsToHIT) was done".green)
      coordsToHIT = ""
      playerHitResult = compField.hit(HIT.Y, HIT.X)
      if playerHitResult {whoHits = CONST.PLAYER} else {whoHits = CONST.COMPUTER}
      moveTo(19,5); clearLine() // очистить строку о выстреле компьютера
    } else {
      moveTo(21,5); clearLine()
      writeAt(21, 5, "Wrong coords have you entered!, try to enter like this: 1a, 2b, 10c".red)
      coordsToHIT = ""
      moveTo(19,5); clearLine() // очистить строку о выстреле компьютера
    }
  } else if whoHits == CONST.COMPUTER {
    compHitResult = comp.strike()
    moveTo(19,5); clearLine()
    writeAt(19, 5, "The COMPUTER strikes back, last strike at: ".red + comp.humaReadableHitPosition(comp.lasty, comp.lastx).red)
    if compHitResult {whoHits = CONST.COMPUTER} else {whoHits = CONST.PLAYER}
  }
  compAlive = false
  playerAlive = false
  for eachShip in ships {
    destuctCheck = eachShip.checkDestruction()
    if destuctCheck == false && eachShip.field == CONST.COMPUTER {
      compAlive = true
    }
    if destuctCheck == false && eachShip.field == CONST.PLAYER {
      playerAlive = true
    }
  }
  if compAlive == false {quit = true; WINNER = CONST.PLAYER}
  if playerAlive == false {quit = true; WINNER = CONST.COMPUTER}
  playerField.writeField(5, 5)
  compField.writeField(5, 32)
}

gameEndPrompt(WINNER)
