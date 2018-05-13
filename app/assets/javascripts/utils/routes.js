import RouteDump from './routes_dump'

export default class {
  constructor() {
    // console.log(RouteDump)
  }

  readTextFile(file) {
    var fr = new FileReader();
    fr.onload = function(e) {
      showDataFile(e, o);
    };
    fr.readAsText(o.files[0]);
  }


  say(msg) {
    console.log(this.name + " says: " + msg);
  }
}
