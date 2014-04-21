function ViewGroup() {
  View.call(this);
}

ViewGroup.prototype = Object.create(View.prototype);
ViewGroup.prototype.constructor = ViewGroup;

ViewGroup.prototype.children = []
ViewGroup.prototype.dispatchDraw = function(canvas) {
  if(!this.frame){
    return;
  }

  var context = canvas.getContext("2d");
  context.save();
  context.rect(this.frame.x, this.frame.y, this.frame.width, this.frame.height);
  context.clip();

  context.translate(this.frame.x, this.frame.y);
  for(index in this.children) {
    var child = this.children[index];
    if(child.frame) {
      child.draw(canvas);
    }
  }
  context.restore();
}

ViewGroup.prototype.draw = function(canvas) {
  View.prototype.draw.call(this, canvas);
  this.dispatchDraw(canvas);
}
