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
    log(canvas.pixels.slice(from: 7*rowId, upTo: 7*rowId + 7))
    rowId = rowId + 1
  }

}

pub fun main() {
  let pixelsX = [
    "+-----+",
    "|*   *|",
    "| * * |",
    "|  *  |",
    "| * * |",
    "|*   *|",
    "+-----+"
  ]
  let canvasX = Canvas(
    width: 7,
    height: 7,
    pixels: serializeStringArray(pixelsX)
  )
  display(canvas: canvasX)
}
