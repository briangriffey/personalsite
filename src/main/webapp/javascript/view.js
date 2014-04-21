function Frame(x, y, width, height) {
  this.x = typeof x !== 'undefined' ? x : 0;
  this.y = typeof y !== 'undefined' ? y : 0;
  this.height = typeof height !== 'undefined' ? height : 0;
  this.width = typeof width !== 'undefined' ? width : 0;
}

Frame.prototype.x = 0;
Frame.prototype.y = 0;
Frame.prototype.width = 0;
Frame.prototype.height = 0;

function View(x, y, width, height) {
  this.frame = new Frame(x, y, width, height);
}

View.prototype.frame = new Frame();
View.prototype.background = null;
View.prototype.draw = function() {
  var context = canvas.getContext("2d");
  if(this.background) {
    var rgba = this.hexToRgba(this.background);
    context.fillStyle = rgba;
    context.fillRect(this.frame.x, this.frame.y, this.frame.width, this.frame.height);
  }
}

View.prototype.hexToRgba = function(hex) {

  var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
  var argb = {
      a: parseInt(result[1], 16),
      r: parseInt(result[2], 16),
      g: parseInt(result[3], 16),
      b: parseInt(result[4], 16)
  };

  return "rgba(" + argb.r + "," + argb.g +"," + argb.b + "," + argb.a/255.0 +")";
}
