import Artist from "./contract.cdc"// 0xf8d6e0586b0a20c7

transaction() {
  
  prepare(account: AuthAccount) {
    account.save(
      <- Artist.createCollection(),
      to: /storage/ArtistPictureCollection
    )
    
    account.link<&Artist.Collection>(
      /public/ArtistPictureCollection,
      target: /storage/ArtistPictureCollection
    )
  }

}