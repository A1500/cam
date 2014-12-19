/**
 * @class L5.form.TriggerField
 * @extends L5.form.TextField
 * Provides a convenient wrapper for TextFields that adds a clickable trigger button (looks like a combobox by default).
 * The trigger has no default action, so you must assign a function to implement the trigger click handler by
 * overriding {@link #onTriggerClick}. You can create a TriggerField directly, as it renders exactly like a combobox
 * for which you can provide a custom implementation.  For example:
 * <pre><code>
var trigger = new L5.form.TriggerField();
trigger.onTriggerClick = myTriggerFn;
trigger.applyToMarkup('my-field');
</code></pre>
 *
 * However, in general you will most likely want to use TriggerField as the base class for a reusable component.
 * {@link L5.form.DateField} and {@link L5.form.ComboBox} are perfect examples of this.
 * @cfg {String} triggerClass An additional CSS class used to style the trigger button.  The trigger will always get the
 * class 'l-form-trigger' by default and triggerClass will be <b>appended</b> if specified.
 * @constructor
 * Create a new TriggerField.
 * @param {Object} config Configuration options (valid {@L5.form.TextField} config options will also be applied
 * to the base TextField)
 */
L5.form.TriggerField = L5.extend(L5.form.TextField,  {
    /**
     * @cfg {String} triggerClass A CSS class to apply to the trigger
     */
    /**
     * @cfg {String/Object} autoCreate A DomHelper element spec, or true for a default element spec (defaults to
     * {tag: "input", type: "text", size: "16", autocomplete: "off"})
     */
    defaultAutoCreate : {tag: "input", type: "text", size: "16", autocomplete: "off"},
    /**
     * @cfg {Boolean} hideTrigger True to hide the trigger element and display only the base text field (defaults to false)
     */
    hideTrigger:false,

    /**
     * @hide 
     * @method autoSize
     */
    autoSize: L5.emptyFn,
    // private
    monitorTab : true,
    // private
    deferHeight : true,
    // private
    mimicing : false,

    // private
    onResize : function(w, h){
        L5.form.TriggerField.superclass.onResize.call(this, w, h);
        if(typeof w == 'number'){
            this.el.setWidth(this.adjustWidth('input', w - this.trigger.getWidth()));
        }
        this.wrap.setWidth(this.el.getWidth()+this.trigger.getWidth());
    },

    // private
    adjustSize : L5.BoxComponent.prototype.adjustSize,

    // private
    getResizeEl : function(){
        return this.wrap;
    },

    // private
    getPositionEl : function(){
        return this.wrap;
    },

    // private
    alignErrorIcon : function(){
        if(this.wrap){
            this.errorIcon.alignTo(this.wrap, 'tl-tr', [2, 0]);
        }
    },

    // private
    onRender : function(ct, position){
        L5.form.TriggerField.superclass.onRender.call(this, ct, position);
        this.wrap = this.el.wrap({cls: "l-form-field-wrap"});
        this.trigger = this.wrap.createChild(this.triggerConfig ||
                {tag: "img", src: L5.BLANK_IMAGE_URL, cls: "l-form-trigger " + this.triggerClass});
        if(this.hideTrigger){
            this.trigger.setDisplayed(false);
        }
        this.initTrigger();
        if(!this.width){
            this.wrap.setWidth(this.el.getWidth()+this.trigger.getWidth());
        }
    },

    afterRender : function(){
        L5.form.TriggerField.superclass.afterRender.call(this);
        var y;
        if(L5.isIE && !this.hideTrigger && this.el.getY() != (y = this.trigger.getY())){
            this.el.position();
            this.el.setY(y);
        }
    },

    // private
    initTrigger : function(){
        this.trigger.on("click", this.onTriggerClick, this, {preventDefault:true});
        this.trigger.addClassOnOver('l-form-trigger-over');
        this.trigger.addClassOnClick('l-form-trigger-click');
    },

    // private
    onDestroy : function(){
        if(this.trigger){
            this.trigger.removeAllListeners();
            this.trigger.remove();
        }
        if(this.wrap){
            this.wrap.remove();
        }
        L5.form.TriggerField.superclass.onDestroy.call(this);
    },

    // private
    onFocus : function(){
        L5.form.TriggerField.superclass.onFocus.call(this);
        if(!this.mimicing){
            this.wrap.addClass('l-trigger-wrap-focus');
            this.mimicing = true;
            L5.get(L5.isIE ? document.body : document).on("mousedown", this.mimicBlur, this, {delay: 10});
            if(this.monitorTab){
                this.el.on("keydown", this.checkTab, this);
            }
        }
    },

    // private
    checkTab : function(e){
        if(e.getKey() == e.TAB){
            this.triggerBlur();
        }
    },

    // private
    onBlur : function(){
        // do nothing
    },

    // private
    mimicBlur : function(e){
        if(!this.wrap.contains(e.target) && this.validateBlur(e)){
            this.triggerBlur();
        }
    },

    // private
    triggerBlur : function(){
        this.mimicing = false;
        L5.get(L5.isIE ? document.body : document).un("mousedown", this.mimicBlur, this);
        if(this.monitorTab && this.el){
            this.el.un("keydown", this.checkTab, this);
        }
        this.beforeBlur();
        if(this.wrap){
            this.wrap.removeClass('l-trigger-wrap-focus');
        }
        L5.form.TriggerField.superclass.onBlur.call(this);
    },

    beforeBlur : L5.emptyFn, 

    // private
    // This should be overriden by any subclass that needs to check whether or not the field can be blurred.
    validateBlur : function(e){
        return true;
    },

    // private
    onDisable : function(){
        L5.form.TriggerField.superclass.onDisable.call(this);
        if(this.wrap){
            this.wrap.addClass(this.disabledClass);
            this.el.removeClass(this.disabledClass);
        }
    },

    // private
    onEnable : function(){
        L5.form.TriggerField.superclass.onEnable.call(this);
        if(this.wrap){
            this.wrap.removeClass(this.disabledClass);
        }
    },

    // private
    onShow : function(){
        if(this.wrap){
            this.wrap.dom.style.display = '';
            this.wrap.dom.style.visibility = 'visible';
        }
    },

    // private
    onHide : function(){
        this.wrap.dom.style.display = 'none';
    },

    /**
     * The function that should handle the trigger's click event.  This method does nothing by default until overridden
     * by an implementing function.
     * @method
     * @param {EventObject} e
     */
    onTriggerClick : L5.emptyFn

    /**
     * @cfg {Boolean} grow @hide
     */
    /**
     * @cfg {Number} growMin @hide
     */
    /**
     * @cfg {Number} growMax @hide
     */
});

// TwinTriggerField is not a public class to be used directly.  It is meant as an abstract base class
// to be extended by an implementing class.  For an example of implementing this class, see the custom
// SearchField implementation here: http://extjs.com/deploy/ext/examples/form/custom.html
L5.form.TwinTriggerField = L5.extend(L5.form.TriggerField, {
    initComponent : function(){
        L5.form.TwinTriggerField.superclass.initComponent.call(this);

        this.triggerConfig = {
            tag:'span', cls:'l-form-twin-triggers', cn:[
            {tag: "img", src: L5.BLANK_IMAGE_URL, cls: "l-form-trigger " + this.trigger1Class},
            {tag: "img", src: L5.BLANK_IMAGE_URL, cls: "l-form-trigger " + this.trigger2Class}
        ]};
    },

    getTrigger : function(index){
        return this.triggers[index];
    },

    initTrigger : function(){
        var ts = this.trigger.select('.l-form-trigger', true);
        this.wrap.setStyle('overflow', 'hidden');
        var triggerField = this;
        ts.each(function(t, all, index){
            t.hide = function(){
                var w = triggerField.wrap.getWidth();
                this.dom.style.display = 'none';
                triggerField.el.setWidth(w-triggerField.trigger.getWidth());
            };
            t.show = function(){
                var w = triggerField.wrap.getWidth();
                this.dom.style.display = '';
                triggerField.el.setWidth(w-triggerField.trigger.getWidth());
            };
            var triggerIndex = 'Trigger'+(index+1);

            if(this['hide'+triggerIndex]){
                t.dom.style.display = 'none';
            }
            t.on("click", this['on'+triggerIndex+'Click'], this, {preventDefault:true});
            t.addClassOnOver('l-form-trigger-over');
            t.addClassOnClick('l-form-trigger-click');
        }, this);
        this.triggers = ts.elements;
    },

    onTrigger1Click : L5.emptyFn,
    onTrigger2Click : L5.emptyFn
});
L5.reg('trigger', L5.form.TriggerField);