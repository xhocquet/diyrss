import RouteDump from './routes_dump'

function get(path) {
  const routeMatcher = /^\s*([a-z0-9-_]*)\s+(GET|PATCH|PUT|POST|DELETE)\s+([a-z0-9.-_:\(\)\/]*)\s*([a-z0-9#-_\/]*)\s*$/

  const bingoLine = RouteDump.split("\n").find((line) => {
    if (line === "") return false

    const results = line.match(routeMatcher)

    if (results === null) return false
    const path_helper = results[1]

    return path === path_helper
  })

  const appPath = bingoLine.match(routeMatcher)[3]
  return appPath.replace("(.:format)","")
}

export default {
  get,
}
