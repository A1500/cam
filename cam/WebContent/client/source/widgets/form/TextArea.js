/**
 * @class L5.form.TextArea
 * @extends L5.form.TextField
 * Multiline text field.  Can be used as a direct replacement for traditional textarea fields, plus adds
 * support for auto-sizing.
 * @constructor
 * Creates a new TextArea
 * @param {Object} config Configuration options
 */
L5.form.TextArea = L5.extend(L5.form.TextField,  {
    /**
     * @cfg {Number} growMin The minimum height to allow when grow = true (defaults to 60)
     */
    growMin : 21,
    /**
     * @cfg {Number} growMax The maximum height to allow when grow = true (defaults to 1000)
     */
    growMax: 1000,
    growAppend : '&#160;\n&#160;',
    growPad : 0,

    enterIsSpecial : false,

    /**
     * @cfg {Boolean} preventScrollbars True to prevent scrollbars from appearing regardless of how much text is
     * in the field (equivalent to setting overflow: hidden, defaults to false)
     */
    preventScrollbars: false,
    grow : true,
    /**
     * @cfg {String/Object} autoCreate A DomHelper element spec, or true for a default element spec (defaults to
     * {tag: "textarea", style: "width:100px;height:60px;", autocomplete: "off"})
     */

    // private
    onRender : function(ct, position){
        if(!this.el){
            this.defaultAutoCreate = {
                tag: "textarea",
                style:"width:100px;height:60px;",
                autocomplete: "off"
            };
        }
        L5.form.TextArea.superclass.onRender.call(this, ct, position);
        if(this.grow){
            this.textSizeEl = L5.DomHelper.append(document.body, {
                tag: "pre", cls: "l-form-grow-sizer"
            });
            if(this.preventScrollbars){
                this.el.setStyle("overflow", "hidden");
            }
            this.el.setHeight(this.growMin);
        }
    },

    onDestroy : function(){
        if(this.textSizeEl){
            L5.removeNode(this.textSizeEl);
        }
        L5.form.TextArea.superclass.onDestroy.call(this);
    },

    fireKey : function(e){
        if(e.isSpecialKey() && (this.enterIsSpecial || (e.getKey() != e.ENTER || e.hasModifier()))){
            this.fireEvent("specialkey", this, e);
        }
    },

    // private
    onKeyUp : function(e){
        if(!e.isNavKeyPress() || e.getKey() == e.ENTER){
            this.autoSize();
        }
        L5.form.TextArea.superclass.onKeyUp.call(this, e);
    },

    /**
     * Automatically grows the field to accomodate the height of the text up to the maximum field height allowed.
     * This only takes effect if grow = true, and fires the {@link #autosize} event if the height changes.
     */
    autoSize : function(){
        if(!this.grow || !this.textSizeEl){
            return;
        }
        var el = this.el;
        var v = el.dom.value;
        var ts = this.textSizeEl;
        ts.innerHTML = '';
        ts.appendChild(document.createTextNode(v));
        v = ts.innerHTML;

        L5.fly(ts).setWidth(this.el.getWidth());
        if(v.length < 1){
            v = "&#160;&#160;";
        }else{
            if(L5.isIE){
                v = v.replace(/\n/g, '<p>&#160;</p>');
            }
            v += this.growAppend;
        }
        ts.innerHTML = v;
        var h;
        if(L5.isIE){
        	h = Math.min(this.growMax, Math.max(ts.offsetHeight/2, this.growMin)+this.growPad);
        }else{
        	h = Math.min(this.growMax, Math.max(ts.offsetHeight*0.7, this.growMin)+this.growPad);
        }
        if(h != this.lastHeight){
            this.lastHeight = h;
            this.el.setHeight(h);
            this.fireEvent("autosize", this, h);
        }
    }
});
L5.reg('textarea', L5.form.TextArea);