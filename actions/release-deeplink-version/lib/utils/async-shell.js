const { spawn } = require("child_process")

const parseCommand = require("./parse-command")

const promiseFromChildProcess = (child, callback, extraOptions) => {
  const { ignoreErrors = [] } = extraOptions
  child.on("error", () => {}) // avoid crash on not found executable
  const out = []
  child.stdout.on("data", (data) => {
    out.push(data)
  })
  const err = []
  child.stderr.on("data", (data) => {
    if (ignoreErrors.some((errCatch) => data.includes(errCatch))) {
      return
    }
    err.push(data)
  })
  return new Promise(async (resolve, reject) => {
    if (callback) {
      await callback(child)
    }
    child.on("close", (code) => {
      if (code === 0) {
        if (err.length > 0) {
          console.error(err.join())
        }
        resolve(Buffer.concat(out).toString())
      } else {
        const error = new Error(err.join())
        error.code = code
        reject(error)
      }
    })
  })
}

module.exports = (
  arg,
  options = {},
  callback = null,
  extraOptions = {}
) => {
  const [cmd, args] = parseCommand(arg)
  const defaultOptions = { encoding: "utf-8" }
  const childProcess = spawn(cmd, args, { ...defaultOptions, ...options })
  return promiseFromChildProcess(
    childProcess,
    callback,
    extraOptions
  )
}
