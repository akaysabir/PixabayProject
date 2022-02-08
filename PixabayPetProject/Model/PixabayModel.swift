import Foundation

struct VideoModel: Codable {
  let hits: [Video]?
}

struct Video: Codable {
  let videos: VideoSize?
  let user: String?
  let pictureId: String?

  enum CodingKeys: String, CodingKey {
    case pictureId = "picture_id"
    case videos
    case user
  }
}

struct VideoSize: Codable {
  let tiny: VideoURL?
  let medium: VideoURL?
  let small: VideoURL?
  let large: VideoURL?
}

struct VideoURL: Codable {
  let url: String?
}

struct ImageModel: Codable {
  let hits: [Image]?
}

struct Image: Codable {
  let previewURL: String?
  let largeImageURL: String?
  let user: String?
}
