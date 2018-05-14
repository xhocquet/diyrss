import RouteDump from './routes_dump'

export default class {
  constructor() {
    this.routeDump = RouteDump
  }

  get(path) {
    const routeMatcher = /^\s*([a-z0-9-_]*)\s+(GET|PATCH|PUT|POST|DELETE)\s+([a-z0-9.-_:\(\)\/]*)\s*([a-z0-9#-_\/]*)\s*$/

    const line = this.routeDump.split("\n").find((line) => {
      if (line === "") return false

      const results = line.match(routeMatcher)

      if (results === null) return false
      const path_helper = results[1]
      // const method = results[2]
      const app_path = results[3]

      return path === path_helper
    })

    return line
  }
}
