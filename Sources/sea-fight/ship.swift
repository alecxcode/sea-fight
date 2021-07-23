//Copyright (c) 2021 Alexander Vankov (Александр Ваньков)

class Ship {
  var field: Int // поле: игрок или компьютер
  var decks: Int // количество палуб
  var coordy: Int // координата головы по высоте
  var coordx: Int // координата головы по ширине
  var direction: Int // направление от головы
  var destructed = false // статус: жив или уничтожен

  init(field: Int, decks: Int, coordy: Int, coordx: Int, direction: Int) {
    self.field = field
    self.decks = decks
    self.coordy = coordy
    self.coordx = coordx
    self.direction = direction
  }

  // метод проверяет уничтоже ли корабль:
  func checkDestruction() -> Bool {
    if field == CONST.COMPUTER {
      var thisDestroyed = true // перед проверкой на уничтоженность выставим флаг, что уничтожен
      if direction == CONST.VERTICAL {for n in 0...decks-1 {
        if compField.FD[coordy+n][coordx] == "#" {thisDestroyed = false}}}
      if direction == CONST.HORISONTAL {for n in 0...decks-1 {
        if compField.FD[coordy][coordx+n] == "#" {thisDestroyed = false}}}
      if thisDestroyed {drawDestruction(); destructed = true}
    } else if field == CONST.PLAYER {
      var thisDestroyed = true // перед проверкой на уничтоженность выставим флаг, что уничтожен
      if direction == CONST.VERTICAL {for n in 0...decks-1 {
        if playerField.FD[coordy+n][coordx] == "#" {thisDestroyed = false}}}
      if direction == CONST.HORISONTAL {for n in 0...decks-1 {
        if playerField.FD[coordy][coordx+n] == "#" {thisDestroyed = false}}}
      if thisDestroyed {drawDestruction(); destructed = true}
    }
    return destructed
  }

  // этот метод рисует клетки уничтожения вокруг корабля:
  func drawDestruction() {
    if field == CONST.COMPUTER {
      if direction == CONST.VERTICAL {for n in 0...decks-1 {
        var curposy: Int
        var curposx: Int
        for curaddy in -1...1{
          curposy = coordy + n + curaddy
          for curaddx in -1...1{
            curposx = coordx + curaddx
            if curposy > 9 {curposy = 9}
            if curposx > 9 {curposx = 9}
            if curposy < 0 {curposy = 0}
            if curposx < 0 {curposx = 0}
            compField.FD[curposy][curposx] = "X"
          }
        }
      }
      for n in 0...decks-1 {compField.FD[coordy+n][coordx] = "@"}
      }
      if direction == CONST.HORISONTAL {for n in 0...decks-1 {
        var curposy: Int
        var curposx: Int
        for curaddy in -1...1{
          curposy = coordy + curaddy
          for curaddx in -1...1{
            curposx = coordx + n + curaddx
            if curposy > 9 {curposy = 9}
            if curposx > 9 {curposx = 9}
            if curposy < 0 {curposy = 0}
            if curposx < 0 {curposx = 0}
            compField.FD[curposy][curposx] = "X"
          }
        }
      }
      for n in 0...decks-1 {compField.FD[coordy][coordx+n] = "@"}
      }
    } else if field == CONST.PLAYER {
      if direction == CONST.VERTICAL {for n in 0...decks-1 {
        var curposy: Int
        var curposx: Int
        for curaddy in -1...1{
          curposy = coordy + n + curaddy
          for curaddx in -1...1{
            curposx = coordx + curaddx
            if curposy > 9 {curposy = 9}
            if curposx > 9 {curposx = 9}
            if curposy < 0 {curposy = 0}
            if curposx < 0 {curposx = 0}
            playerField.FD[curposy][curposx] = "X"
          }
        }
      }
      for n in 0...decks-1 {playerField.FD[coordy+n][coordx] = "@"}
      }
      if direction == CONST.HORISONTAL {for n in 0...decks-1 {
        var curposy: Int
        var curposx: Int
        for curaddy in -1...1{
          curposy = coordy + curaddy
          for curaddx in -1...1{
            curposx = coordx + n + curaddx
            if curposy > 9 {curposy = 9}
            if curposx > 9 {curposx = 9}
            if curposy < 0 {curposy = 0}
            if curposx < 0 {curposx = 0}
            playerField.FD[curposy][curposx] = "X"
          }
        }
      }
      for n in 0...decks-1 {playerField.FD[coordy][coordx+n] = "@"}
      }
    }
  }
}
