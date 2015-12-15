const aja = require('aja');

export default class JobService {

  failedList(params, cb) {
    aja()
      .url(window.AppSettings.links.failed.list)
      .data(params)
      .on('success', (data) => {
        cb(data)
      })
      .go()
  }

  failedRemove(id) {
    aja()
      .url(`${window.AppSettings.links.failed.remove}/${id}`)
      .go()
  }

  failedRetry(id) {
    aja()
      .url(`${window.AppSettings.links.failed.retry}/${id}`)
      .go()
  }

  failedRemoveAll() {
    aja()
      .url(`${window.AppSettings.links.failed.removeAll}`)
      .go()
  }

  failedRetryAll() {
    aja()
      .url(`${window.AppSettings.links.failed.retryAll}`)
      .go()
  }

}
