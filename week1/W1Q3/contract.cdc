// https://play.onflow.org/b4730b92-2fe3-42ea-ad7f-019f2cd9b65c?type=account&id=ef8d567d-b096-450b-ba64-fbc0a836c101

pub contract Artist {

  pub struct Canvas {

    pub let width: UInt8
    pub let height: UInt8
    pub let pixels: String

    init(width: UInt8, height: UInt8, pixels: String) {
      self.width = width
      self.height = height
      // The following pixels
      // 123
      // 456
      // 789
      // should be serialized as
      // 123456789
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

    pub let width: UInt8
    pub let height: UInt8
    pub let prints: {String: Canvas}

    init(width: UInt8, height: UInt8) {
      self.width = width;
      self.height = height;
      self.prints = {}
    }

    pub fun print(canvas: Canvas): @Picture? {
      // Canvas needs to fit Printer's dimensions.
      let size = Int(self.width * self.height)
      log("size:".concat(size.toString()))
      if canvas.pixels.length != size {
        return nil
      }

      // Canvas can only use visible ASCII characters.
      for symbol in canvas.pixels.utf8 {
        if symbol < 32 || symbol > 126 {
          return nil
        }
      }

      // Printer is only allowed to print unique canvases.
      if self.prints.containsKey(canvas.pixels) == false {
        log("Key not exists")
        let picture <- create Picture(canvas: canvas)
        self.prints[canvas.pixels] = canvas
        return <- picture
      } else {
        log("Key exists")
        return nil
      }
    }
  }

  pub resource Collection {

    pub let pictures: @[Picture]

    init() {
      self.pictures <- []
    }

    pub fun deposit(picture: @Picture){
        self.pictures.append(<- picture)    
    }

    destroy() {
        destroy self.pictures
    }

  }
  
  pub fun createCollection(): @Collection {
    return <- create Collection()
  }

  init() {
    self.account.save(
      <- create Printer(width: 5, height: 5),
      to: /storage/ArtistPicturePrinter
    )
    self.account.save(
      <- self.createCollection(),
      to: /storage/ArtistPictureCollection
    )
    self.account.link<&Printer>(
      /public/ArtistPicturePrinter,
      target: /storage/ArtistPicturePrinter
    )
    self.account.link<&Collection>(
      /public/ArtistPictureCollection,
      target: /storage/ArtistPictureCollection
    )
  }
}
 