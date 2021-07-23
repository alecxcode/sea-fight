//Copyright (c) 2021 Alexander Vankov (Александр Ваньков)

class computer{
  var hitres: Bool // результат последнего выстрела
  var hitmade: Bool // сделан ли выстрел при последнем вызове метода
  var lasty: Int // координата последнего выстрела
  var lastx: Int // координата последнего выстрела

  init() {
    self.hitres = false
    self.hitmade = false
    self.lasty = 0
    self.lastx = 0
  }

  func strike() -> Bool {
    if hitres == false || hitmade == false {
      for y in 0...9 {
        for x in 0...9 {
          if playerField.FD[y][x] != "*" && playerField.FD[y][x] != "@" && playerField.FD[y][x] != "X" {
            hitres = playerField.hit(y, x)
            lasty = y ; lastx = x
            hitmade = true
            return hitres
          }
        }
      }
    } else {
      // следующий код смотрит вниз по отношению к выбитой палубе:
      hitmade = false
      var y = lasty + 1
      var x = lastx
      if y > 9 {y = 9}
      if x > 9 {x = 9}
      var checkbackx1 = x - 1 // что на клетку ниже и одну назад по горизонтали?
      var checkbackx2 = x - 2 // что на клетку ниже и две назад по горизонтали?
      var checkbackx3 = x - 3 // что на клетку ниже и три назад по горизонтали?
      if checkbackx1 < 0 {checkbackx1 = 0}
      if checkbackx2 < 0 {checkbackx2 = 0}
      if checkbackx3 < 0 {checkbackx3 = 0}
      if playerField.FD[y][checkbackx1] == "*" || playerField.FD[y][checkbackx2] == "*" || playerField.FD[y][checkbackx3] == "*" {
        hitmade = false // если внизу и позади выстрел был не результативным, надо вернуться к горизонтальной пробивке
      } else if playerField.FD[y][x] != "*" && playerField.FD[y][x] != "@" && playerField.FD[y][x] != "X" {
        hitres = playerField.hit(y, x)
        hitmade = true
        lasty = y ; lastx = x
        return hitres
      }
    }
    return hitres
  }

  func humaReadableHitPosition(_ y: Int, _ x: Int) -> String {
    let sty = String(y+1)
    var stx = ""
    switch x {
    case 0: stx = "a"
    case 1: stx = "b"
    case 2: stx = "c"
    case 3: stx = "d"
    case 4: stx = "e"
    case 5: stx = "f"
    case 6: stx = "g"
    case 7: stx = "h"
    case 8: stx = "i"
    case 9: stx = "j"
    default: stx = "a"
    }
    return sty+stx
  }

}
