package loka.button.btnCheck
{
    import flash.display.Sprite;
    
    import loka.button.Btn;
    import loka.button.btnEffect.BtnEffectCheck;
    
    
    /**
     * ...
     *
     * @history create Jan 4, 2012 6:02:29 PM
     * @author g.savenko
     */    
    public class BtnCheck extends Btn
    {
        //------------------------------------------------
        //      Class constants
        //------------------------------------------------
        
        //------------------------------------------------
        //      Variables
        //------------------------------------------------
        private var _check:Boolean = false;
        //---------------------------------------------------------------
        //
        //      CONSTRUCTOR
        //
        //---------------------------------------------------------------
        public function BtnCheck(check:Boolean)
        {
            super();
            _check = check;
//            this.addEventListener(MouseEvent.CLICK, onClick);
            
//            this._btnEffect = new BtnEffectCheck(this._el;
            
        }
        
        override public function createBtnRect(w:Number, Text:String=''):Sprite
        {
            var mc:Sprite = super.createBtnRect(w, Text);
            this._btnEffect.destroy();
            this._btnEffect = new BtnEffectCheck(this._btn, _check);
            
            return mc;
        }
        
        //---------------------------------------------------------------
        //
        //      PRIVATE & PROTECTED METHODS
        //
        //---------------------------------------------------------------
        
        
        //---------------------------------------------------------------
        //
        //      EVENT HANDLERS
        //
        //---------------------------------------------------------------
        
        /*protected function onClick(event:MouseEvent):void
        {
            // TODO Auto-generated method stub
            _statusClick = !_statusClick;
            if(_statusClick)
            {
                
            } 
            else 
            {
                
            }
        }*/
        
        
        //---------------------------------------------------------------
        //
        //      PUBLIC METHODS
        //
        //---------------------------------------------------------------
        
        
        //---------------------------------------------------------------
        //
        //      ACCESSORS
        //
        //---------------------------------------------------------------
        public function get check():Boolean
        {
            return (_btnEffect as BtnEffectCheck).check;
        }
        
        public function set check(value:Boolean):void
        {
            (_btnEffect as BtnEffectCheck).check = value;
        }
    }
}