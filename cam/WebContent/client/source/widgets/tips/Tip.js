/**
 * @class L5.Tip
 * @extends L5.Panel
 * This is the base class for {@link L5.QuickTip} and {@link L5.Tooltip} that provides the basic layout and
 * positioning that all tip-based classes require. This class can be used directly for simple, statically-positioned
 * tips that are displayed programmatically, or it can be extended to provide custom tip implementations.
 * @constructor
 * Create a new Tip
 * @param {Object} config The configuration options
 */
L5.Tip = L5.extend(L5.Panel, {
    /**
     * @cfg {Boolean} closable True to render a close tool button into the tooltip header (defaults to false).
     */
    /**
     * @cfg {Number} width
     * Width in pixels of the tip (defaults to auto).  Width will be ignored if it exceeds the bounds of
     * {@link #minWidth} or {@link #maxWidth}.  The maximum supported value is 500.
     */
    /**
     * @cfg {Number} minWidth The minimum width of the tip in pixels (defaults to 40).
     */
    minWidth : 40,
    /**
     * @cfg {Number} maxWidth The maximum width of the tip in pixels (defaults to 300).  The maximum supported value is 500.
     */
    maxWidth : 300,
    /**
     * @cfg {Boolean/String} shadow True or "sides" for the default effect, "frame" for 4-way shadow, and "drop"
     * for bottom-right shadow (defaults to "sides").
     */
    shadow : "sides",
    /**
     * @cfg {String} defaultAlign <b>Experimental</b>. The default {@link L5.Element#alignTo} anchor position value
     * for this tip relative to its element of origin (defaults to "tl-bl?").
     */
    defaultAlign : "tl-bl?",
    autoRender: true,
    quickShowInterval : 250,

    // private panel overrides
    frame:true,
    hidden:true,
    baseCls: 'l-tip',
    floating:{shadow:true,shim:true,useDisplay:true,constrain:false},
    autoHeight:true,

    // private
    initComponent : function(){
        L5.Tip.superclass.initComponent.call(this);
        if(this.closable && !this.title){
            this.elements += ',header';
        }
    },

    // private
    afterRender : function(){
        L5.Tip.superclass.afterRender.call(this);
        if(this.closable){
            this.addTool({
                id: 'close',
                handler: this.hide,
                scope: this
            });
        }
    },

    /**
     * Shows this tip at the specified XY position.  Example usage:
     * <pre><code>
// Show the tip at x:50 and y:100
tip.showAt([50,100]);
</code></pre>
     * @param {Array} xy An array containing the x and y coordinates
     */
    showAt : function(xy){
        L5.Tip.superclass.show.call(this);
        if(this.measureWidth !== false && (!this.initialConfig || typeof this.initialConfig.width != 'number')){
            this.doAutoWidth();
        }
        if(this.constrainPosition){
            xy = this.el.adjustForConstraints(xy);
        }
        this.setPagePosition(xy[0], xy[1]);
    },

    // protected
    doAutoWidth : function(){
        var bw = this.body.getTextWidth();
        if(this.title){
            bw = Math.max(bw, this.header.child('span').getTextWidth(this.title));
        }
        bw += this.getFrameWidth() + (this.closable ? 20 : 0) + this.body.getPadding("lr");
        this.setWidth(bw.constrain(this.minWidth, this.maxWidth));
        
        // IE7 repaint bug on initial show
        if(L5.isIE7 && !this.repainted){
            this.el.repaint();
            this.repainted = true;
        }
    },

    /**
     * <b>Experimental</b>. Shows this tip at a position relative to another element using a standard {@link L5.Element#alignTo}
     * anchor position value.  Example usage:
     * <pre><code>
// Show the tip at the default position ('tl-br?')
tip.showBy('my-el');

// Show the tip's top-left corner anchored to the element's top-right corner
tip.showBy('my-el', 'tl-tr');
</code></pre>
     * @param {Mixed} el An HTMLElement, L5.Element or string id of the target element to align to
     * @param {String} position (optional) A valid {@link L5.Element#alignTo} anchor position (defaults to 'tl-br?' or
     * {@link #defaultAlign} if specified).
     */
    showBy : function(el, pos){
        if(!this.rendered){
            this.render(L5.getBody());
        }
        this.showAt(this.el.getAlignToXY(el, pos || this.defaultAlign));
    },

    initDraggable : function(){
        this.dd = new L5.Tip.DD(this, typeof this.draggable == 'boolean' ? null : this.draggable);
        this.header.addClass('l-tip-draggable');
    }
});

// private - custom Tip DD implementation
L5.Tip.DD = function(tip, config){
    L5.apply(this, config);
    this.tip = tip;
    L5.Tip.DD.superclass.constructor.call(this, tip.el.id, 'WindowDD-'+tip.id);
    this.setHandleElId(tip.header.id);
    this.scroll = false;
};

L5.extend(L5.Tip.DD, L5.dd.DD, {
    moveOnly:true,
    scroll:false,
    headerOffsets:[100, 25],
    startDrag : function(){
        this.tip.el.disableShadow();
    },
    endDrag : function(e){
        this.tip.el.enableShadow(true);
    }
});