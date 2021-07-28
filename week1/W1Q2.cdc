pub struct Canvas {

  pub let width: UInt8
  pub let height: UInt8
  pub let pixels: String

  init(width: UInt8, height: UInt8, pixels: String) {
    self.width = width
    self.height = height
    self.pixels = pixels
  }
}


pub resource Picture {
  pub let canvas: Canvas
  
  init(canvas: Canvas) {
    self.canvas = canvas
  }
}

pub resource Printer {
  pub let canvasList: [String]

  pub fun print(canvas: Canvas): @Picture? {
    // log(self.canvasList)
    if !self.canvasList.contains(canvas.pixels) && canvas.height == 5 && canvas.width == 5 {
      log("Unique and valid size")
      self.canvasList.append(canvas.pixels)
      display(canvas: canvas)
      return <-create Picture(canvas: canvas)
    }
    log("Not uniqie or invalid size")
    return nil 
  }

  init() {
    self.canvasList = []
  }

}

pub fun serializeStringArray(_ lines: [String]): String {
  var buffer = ""
  for line in lines {
    buffer = buffer.concat(line)
  }

  return buffer
}

pub fun display(canvas: Canvas) {
  var rowId = 0
  log("Length: ".concat(canvas.height.toString()))
  while rowId < Int(canvas.height) {
    log(canvas.pixels.slice(from: Int(canvas.height)*rowId, upTo: Int(canvas.height)*rowId + Int(canvas.height)))
    rowId = rowId + 1
  }

}


pub fun main() {
  let pixels5X5 = [
    "+---+",
    "|* *|",
    "| * |",
    "|* *|",
    "+---+"
  ]
  let canvas5X5 = Canvas(
    width: 5,
    height: 5,
    pixels: serializeStringArray(pixels5X5)
  )
  let res <- create Printer()
  // Unique and valid size
  let pic <- res.print(canvas: canvas5X5)
  destroy pic
  // Not unique
  let pic2 <- res.print(canvas: canvas5X5)
  destroy pic2

  let pixels7X7 = [
    "+-----+",
    "|*   *|",
    "| * * |",
    "|  *  |",
    "| * * |",
    "|*   *|",
    "+-----+"
  ]
  let canvas7X7 = Canvas(
    width: 7,
    height: 7,
    pixels: serializeStringArray(pixels7X7)
  )
  // Invalid size
  let pic3<- res.print(canvas: canvas7X7)
  destroy pic3
  destroy res
}
