const replace = require("replace")

const getGitAbbrevRef = require("./utils/get-git-abbrev-ref")
const getGitMajorVersion = require("./utils/get-git-major-version")
const getGitVersion = require("./utils/get-git-version")
const sanitizeTag = require("./utils/sanitize-tag")

const getVersionFromBranch = async ({ major }) => {
  let ref = await getGitAbbrevRef()
  if (ref === "master") {
    if (major) {
      ref = await getGitMajorVersion()
    } else {
      ref = await getGitVersion()
    }
  }
  return ref
}
module.exports = async (toolPath, version, options = {}) => {
  const { major = false } = options
  if (!version) {
    version = await getVersionFromBranch({ major })
  }
  version = sanitizeTag(version)

  const defaultReplaceConfig = {
    paths: ["./"],
    recursive: true,
    silent: false,
    exclude: "*.md,node_modules",
  }

  replace({
    ...defaultReplaceConfig,
    regex: `${toolPath}(.*)(:|@)([a-zA-Z0-9-.]+)`,
    replacement: `${toolPath}$1$2${version}`,
  })
  console.log(`✨ all source files were linked to version "${version}" of "${toolPath}"`)

}
