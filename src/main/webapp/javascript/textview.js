function TextView() {
  View.call(this);
}

TextView.prototype = Object.create(View.prototype);
TextView.prototype.constructor = TextView;

TextView.prototype.textColor = "#000000";
TextView.prototype.textSize = 28;
TextView.prototype.text = "";

TextView.prototype.draw = function(canvas) {
  View.prototype.draw.call(this, canvas);

  var context = canvas.getContext("2d");
  context.font = this.textSize + "px sans-serif";
  context.textBaseline="top";
  context.fillStyle = this.textColor;

  context.fillText(this.text, this.frame.x, this.frame.y);
}
