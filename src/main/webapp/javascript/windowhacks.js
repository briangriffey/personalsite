var viewGroup;
var nameView;
function resizeCanvas() {
  var canvas = document.getElementById("canvas");
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;

  if(!viewGroup) {
    viewGroup = new ViewGroup();
    viewGroup.background = "#22000000"

    nameView = new TextView();
    nameView.text = "Brian Griffey";

    viewGroup.children.push(nameView);
  }

  var height = canvas.height/4;
  var width = canvas.width/4;
  viewGroup.frame = new Frame(20, canvas.height/2 - height/2, width, height);

  nameView.frame = new Frame(20, 20, viewGroup.frame.width/2, viewGroup.frame.height/2);

  viewGroup.draw(canvas);
}


window.addEventListener('resize', resizeCanvas, false);
