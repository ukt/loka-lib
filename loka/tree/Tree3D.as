package loka.tree {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	
	import loka.bitmap.BitmapEdit;
	
	/**
	 * ...
	 * @author loka
	 */
	public class Tree3D extends Sprite{
		private var _tree:Tree3D;// = new Tree();
		private var _tree2:Tree3D;// = new Tree();
		private var _count:uint = 15;
		private var _scal:Number = .67;
		private var _angle:Number = 0;
		private var _trunkAngle:Number = 25;
		private var _trunk:DisplayObject;
		private var _trunk90:DisplayObject;
		private var _trunkTree:DisplayObject;
		private var _leaf:DisplayObject;
		private var _leafTree:DisplayObject;
		private var _i:uint = 0;
		
		private static var _countI:uint = 0;
		public function Tree3D() {
			trace(_countI++);
		}
		public function create():void {
			this._i++;
			//var DOTrunk:DisplayObject = BitmapEdit.drawImg(_trunk);
			//DOTrunk.rotationY = 90;
			//this._trunk.add
			if(this._count!=0){
			this._trunk.scaleY = 1/this._i;
			this._trunk.scaleX = 1 / this._i;
			
			this.addChild(this._trunk);
			//this._trunk.alpha = .2
			this._trunk.x = -this._trunk.width / 2;
			
			this._trunk90.scaleY = 1/this._i;
			this._trunk90.scaleX = 1 / this._i/2;
			
//			this.addChild(this._trunk90);
			this._trunk90.z = +this._trunk90.width / 2;
			//this._trunk90.x = -this._trunk90.width / 2;
			this._trunk90.rotationY = 90;
			}
			//this.y - this._trunk.height;
			if(this._count==0){
				return;
				var leafs:DisplayObject = (this._leaf);
				leafs.x = this._trunk.x;
				leafs.y = (this._trunk.y + this._trunk.height) / 2;
				
				this.addChild(leafs);
				leafs.rotationX = Math.random() * 360 - 180;
				leafs.rotationY = Math.random() * 360- 180;
				leafs.rotationZ = Math.random() * 360- 180;
			}else if (this._count > 0) {
				
				var countCreate:uint = Math.random() * 6;
				
				switch(countCreate) {
					case 0:
						this.createFirstTree();
						this.createSecondTree();
						break;
					case 1:
						this.createFirstTree();
						//this.createSecondTree();
						break;
					case 2:
						//this.createFirstTree();
						this.createSecondTree();
						break;
					case 3:
						this.createFirstTree();
						this.createSecondTree();
						break;
					case 4:
						this.createFirstTree();
						this.createSecondTree();
						break;
					case 5:
						this.createFirstTree();
						this.createSecondTree();
						break;
					case 6:
						this.createFirstTree();
						this.createSecondTree();
						break;
					
					default :
						trace("dont create");
						break;
						
				}
			}
			//this.rotationX = Math.random() * 360 - 180;
			//this.rotationY = Math.random() * 360 - 180;
			//this.rotationZ = Math.random() * 360 - 180;
			
		}
		private function createSecondTree():void {
			this._tree2 = new Tree3D();
			this._tree2.trunk = /*BitmapEdit.drawImg*/(this._trunkTree);
			this._tree2.leaf = /*BitmapEdit.drawImg*/(this._leafTree);
			this._tree2.angle = this._angle;
			this._tree2.count = this._count - 1;
			this._tree2.iterator(this._i);
			this._tree2.create();
			this.addChild(this._tree2);
			this._tree2.y = this._trunk.height;
			this._tree2.rotationX = Math.random() * 60 - 30;
			this._tree2.rotationY = Math.random() * 60 - 30;
			this._tree2.rotationZ = Math.random() * 60 - 30;
			//this._tree2.rotationX = Math.random() * 360 - 180;
			this._tree2.rotation = -this._trunkAngle + this._angle;
			this.swapChildren(this._tree2,this._trunk);
		}
		private function createFirstTree():void {
			this._tree = new Tree3D();
			this._tree.trunk = /*BitmapEdit.drawImg*/(this._trunkTree);
			this._tree.leaf = /*BitmapEdit.drawImg*/(this._leafTree);
			this._tree.angle = this._angle;
			this._tree.count = this._count - 1;
			this._tree.iterator(this._i);
			this._tree.rotationX = Math.random() * 60 - 30;
			this._tree.rotationY = Math.random() * 60 - 30;
			this._tree.rotationZ = Math.random() * 60 - 30;
			this._tree.create();
			this.addChild(this._tree);
			
			this._tree.y = this._trunk.height;
			this._tree.rotation = this._trunkAngle + this._angle;
			this.swapChildren(this._tree,this._trunk);
		}
		public function get rotate():Number { return this._angle; }
		public function set rotate(value:Number):void 
		{
			
			//trace(this._tree2.rotate);
			
			this._angle = value;
			if (this._tree != null) {
				this._tree.rotate = this._angle * 1.2;
				this._tree.trunkAngle = this._trunkAngle;
				this._tree.rotation = this._trunkAngle + this._angle;
				
			}
			if (this._tree2 != null) {
				this._tree2.rotate = this._angle * 1.2;
				this._tree2.trunkAngle = this._trunkAngle;
				this._tree2.rotation = -this._trunkAngle + this._angle;
			}
		}
		public function iterator(value:uint):void {this._i = value;}
		public function set trunk(value:DisplayObject):void {
			this._trunk = BitmapEdit.drawImg(value); 
			this._trunk90 = BitmapEdit.drawImg(value); 
			//this._trunk90.rotationY = 90;
			this._trunkTree = BitmapEdit.drawImg(value, true);
		}
		public function set leaf(value:DisplayObject):void {
			value.filters = [new DropShadowFilter(2) ];
			this._leafTree = BitmapEdit.drawImg(value);
			this._leaf = BitmapEdit.drawImg(value,true);
		}
		public function set angle(value:Number):void {this._angle = value;}
		public function set count(value:uint):void {this._count = value;}
		public function set scale(value:uint):void {this._scal = value;}
		public function set trunkAngle(value:uint):void {this._trunkAngle = value;}
		public function get GoodTree():Sprite {
			this.rotate=0;
			var mc:Sprite = new Sprite();
			mc.addChild(this);
			this.y = this.height+10;
			this.rotation = 180;
			return mc;
		}
		
		public function set myRotationX(value:Number):void {
			if(this._tree!=null) this._tree.myRotationX = value;;
			if (this._tree2 != null) this._tree2.myRotationX = value;
			this.rotationX = value;
		}
		public function set myRotationY(value:Number):void {
			if(this._tree!=null) this._tree.myRotationY = value;;
			if (this._tree2 != null) this._tree2.myRotationY = value;
			this.rotationY = value;
		}
		public function set myRotationZ(value:Number):void {
			if(this._tree!=null) this._tree.myRotationZ = value;;
			if (this._tree2 != null) this._tree2.myRotationZ = value;
			this.rotationZ = value;
		}
		override public function get rotationY():Number { return super.rotationY; }
		
		override public function set rotationY(value:Number):void 
		{
			//if (this._count == 10) {
//				trace(value)
				if (value > -166 && value < 75) {
					if (this._tree && this._tree2) {
						//trace("tree1 "+this.getChildIndex(this._tree));
						//trace("tree2 " + this.getChildIndex(this._tree2));
						if(this.getChildIndex(this._tree)<this.getChildIndex(this._tree2)){
							this.swapChildren(this._tree, this._tree2);
						}
					}
				}else {
					if (this._tree && this._tree2) {
						//trace("tree1 "+this.getChildIndex(this._tree));
						//trace("tree2 " + this.getChildIndex(this._tree2));
						if(this.getChildIndex(this._tree)<this.getChildIndex(this._tree2)){
							//this.swapChildren(this._tree, this._tree2);
						}
					}
				}
				//if(this._tree!=null)trace("tree1 "+this._tree.rotationY);
				//if(this._tree2!=null)trace("tree2 "+this._tree2.rotationY);
			//}
			super.rotationY = value;
		}
		/*override public function get height():Number { 
			var _height:Number = this.GoodTree.height;
			return super.height; 
		}
		
		override public function set height(value:Number):void 
		{
			super.height = value;
		}*/
	}

}