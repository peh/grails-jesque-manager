const aja = require('aja');

export default class ApplicationService {
  overview(cb) {
    aja()
    .url(window.AppSettings.links.overview)
    .on('success', (data)=>{
      cb(data)
    })
    .go()
  }
}
