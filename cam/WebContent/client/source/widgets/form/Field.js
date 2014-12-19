/**
 * @class L5.form.Field
 * @extends L5.BoxComponent
 * Base class for form fields that provides default event handling, sizing, value handling and other functionality.
 * @constructor
 * Creates a new Field
 * @param {Object} config Configuration options
 */
L5.form.Field = L5.extend(L5.BoxComponent,  {
    /**
     * @cfg {String} fieldLabel The label text to display next to this field (defaults to '')
     * <p><b>A Field's label is not by default rendered as part of the Field's structure.
     * The label is rendered by the {@link L5.layout.FormLayout form layout} layout manager
     * of the {@link L5.form.Container Container} to which the Field is added.</b></p>
     */
    /**
     * @cfg {String} labelStyle A CSS style specification to apply directly to this field's label (defaults to the
     * container's labelStyle value if set, or ''). For example, <code>labelStyle: 'font-weight:bold;'</code>.
     */
    /**
     * @cfg {String} labelSeparator The standard separator to display after the text of each form label (defaults
     * to the value of {@link L5.layout.FormLayout#labelSeparator}, which is a colon ':' by default).  To display
     * no separator for this field's label specify empty string ''.
     */
    /**
     * @cfg {Boolean} hideLabel True to completely hide the label element (defaults to false)
     */
    /**
     * @cfg {String} clearCls The CSS class used to provide field clearing (defaults to 'l-form-clear-left')
     */
    /**
     * @cfg {String} itemCls An additional CSS class to apply to the wrapper's form item element of this field (defaults
     * to the container's itemCls value if set, or '').  Since it is applied to the item wrapper, it allows you to write
     * standard CSS rules that can apply to the field, the label (if specified) or any other element within the markup for
     * the field. NOTE: this will not have any effect on fields that are not part of a form. Example use:
     * <pre><code>
// Apply a style to the field's label:
&lt;style>
    .required .l-form-item-label {font-weight:bold;color:red;}
&lt;/style>

new L5.FormPanel({
	height: 100,
	renderTo: document.body,
	items: [{
		xtype: 'textfield',
		fieldLabel: 'Name',
		itemCls: 'required' //this label will be styled
	},{
		xtype: 'textfield',
		fieldLabel: 'Favorite Color'
	}]
});
</code></pre>
     */
    /**
     * @cfg {String} inputType The type attribute for input fields -- e.g. radio, text, password, file (defaults
     * to "text"). The types "file" and "password" must be used to render those field types currently -- there are
     * no separate L5 components for those. Note that if you use <tt>inputType:'file'</tt>, {@link #emptyText}
     * is not supported and should be avoided.
     */
    /**
     * @cfg {Number} tabIndex The tabIndex for this field. Note this only applies to fields that are rendered,
     * not those which are built via applyTo (defaults to undefined).
     */
    /**
     * @cfg {Mixed} value A value to initialize this field with (defaults to undefined).
     */
    /**
     * @cfg {String} name The field's HTML name attribute (defaults to "").
     */
    /**
     * @cfg {String} cls A custom CSS class to apply to the field's underlying element (defaults to "").
     */

    /**
     * @cfg {String} invalidClass The CSS class to use when marking a field invalid (defaults to "l-form-invalid")
     */
    invalidClass : "l-form-invalid",
    /**
     * @cfg {String} invalidText The error text to use when marking a field invalid and no message is provided
     * (defaults to "The value in this field is invalid")
     */
    invalidText : "The value in this field is invalid",
    /**
     * @cfg {String} focusClass The CSS class to use when the field receives focus (defaults to "l-form-focus")
     */
    focusClass : "l-form-focus",
    /**
     * @cfg {String/Boolean} validationEvent The event that should initiate field validation. Set to false to disable
      automatic validation (defaults to "keyup").
     */
    validationEvent : "keyup",
    /**
     * @cfg {Boolean} validateOnBlur Whether the field should validate when it loses focus (defaults to true).
     */
    validateOnBlur : true,
    /**
     * @cfg {Number} validationDelay The length of time in milliseconds after user input begins until validation
     * is initiated (defaults to 250)
     */
    validationDelay : 250,
    /**
     * @cfg {String/Object} autoCreate A DomHelper element spec, or true for a default element spec (defaults to
     * {tag: "input", type: "text", size: "20", autocomplete: "off"})
     */
    defaultAutoCreate : {tag: "input", type: "text", size: "20", autocomplete: "off"},
    /**
     * @cfg {String} fieldClass The default CSS class for the field (defaults to "l-form-field")
     */
    fieldClass : "l-form-field",
    /**
     * @cfg {String} msgTarget The location where error text should display.  Should be one of the following values
     * (defaults to 'qtip'):
     *<pre>
Value         Description
-----------   ----------------------------------------------------------------------
qtip          Display a quick tip when the user hovers over the field
title         Display a default browser title attribute popup
under         Add a block div beneath the field containing the error text
side          Add an error icon to the right of the field with a popup on hover
[element id]  Add the error text directly to the innerHTML of the specified element
</pre>
     */
    msgTarget : 'qtip',
    /**
     * @cfg {String} msgFx <b>Experimental</b> The effect used when displaying a validation message under the field
     * (defaults to 'normal').
     */
    msgFx : 'normal',
    /**
     * @cfg {Boolean} readOnly True to mark the field as readOnly in HTML (defaults to false) -- Note: this only
     * sets the element's readOnly DOM attribute.
     */
    readOnly : false,
    /**
     * @cfg {Boolean} disabled True to disable the field (defaults to false).
     * <p>Be aware that conformant with the <a href="http://www.w3.org/TR/html401/interact/forms.html#h-17.12.1">HTML specification</a>,
     * disabled Fields will not be {@link L5.form.BasicForm#submit submitted}.</p>
     */
    disabled : false,

    // private
    isFormField : true,
	
    editable : true,
    // private
    hasFocus : false,

	// private
	initComponent : function(){
        L5.form.Field.superclass.initComponent.call(this);
        this.addEvents(
            /**
             * @event focus
             * Fires when this field receives input focus.
             * @param {L5.form.Field} this
             */
            'focus',
            /**
             * @event blur
             * Fires when this field loses input focus.
             * @param {L5.form.Field} this
             */
            'blur',
            /**
             * @event specialkey
             * Fires when any key related to navigation (arrows, tab, enter, esc, etc.) is pressed.  You can check
             * {@link L5.EventObject#getKey} to determine which key was pressed.
             * @param {L5.form.Field} this
             * @param {L5.EventObject} e The event object
             */
            'specialkey',
            /**
             * @event change
             * Fires just before the field blurs if the field value has changed.
             * @param {L5.form.Field} this
             * @param {Mixed} newValue The new value
             * @param {Mixed} oldValue The original value
             */
            'change',
            /**
             * @event invalid
             * Fires after the field has been marked as invalid.
             * @param {L5.form.Field} this
             * @param {String} msg The validation message
             */
            'invalid',
            /**
             * @event valid
             * Fires after the field has been validated with no errors.
             * @param {L5.form.Field} this
             */
            'valid'
        );
    },

    /**
     * Returns the name attribute of the field if available
     * @return {String} name The field name
     */
    getName: function(){
         return this.rendered && this.el.dom.name ? this.el.dom.name : (this.hiddenName || '');
    },

    // private
    onRender : function(ct, position){
        L5.form.Field.superclass.onRender.call(this, ct, position);
        if(!this.el){
            var cfg = this.getAutoCreate();
            if(!cfg.name){
                cfg.name = this.name || this.id;
            }
            if(this.inputType){
                cfg.type = this.inputType;
            }
            this.el = ct.createChild(cfg, position);
        }
        var type = this.el.dom.type;
        if(type){
            if(type == 'password'){
                type = 'text';
            }
            this.el.addClass('l-form-'+type);
        }
        if(this.readOnly){
            this.el.dom.readOnly = true;
        }
        if(this.tabIndex !== undefined){
            this.el.dom.setAttribute('tabIndex', this.tabIndex);
        }

        this.el.addClass([this.fieldClass, this.cls]);
    },

    // private
    initValue : function(){
        if(this.value !== undefined){
            this.setValue(this.value);
        }else if(this.el.dom.value.length > 0 && this.el.dom.value != this.emptyText){
            this.setValue(this.el.dom.value);
        }
        // reference to original value for reset
        this.originalValue = this.getValue();
    },

    /**
     * Returns true if this field has been changed since it was originally loaded and is not disabled.
     */
    isDirty : function() {
        if(this.disabled) {
            return false;
        }
        return String(this.getValue()) !== String(this.originalValue);
    },

    // private
    afterRender : function(){
        L5.form.Field.superclass.afterRender.call(this);
        this.initEvents();
        this.initValue();
    },

    // private
    fireKey : function(e){
        if(e.isSpecialKey()){
            this.fireEvent("specialkey", this, e);
        }
    },

    /**
     * Resets the current field value to the originally loaded value and clears any validation messages
     */
    reset : function(){
        this.setValue(this.originalValue);
        this.clearInvalid();
    },

    // private
    initEvents : function(){
        this.el.on(L5.isIE || L5.isSafari3 ? "keydown" : "keypress", this.fireKey,  this);
        this.el.on("focus", this.onFocus,  this);

        // fix weird FF/Win editor issue when changing OS window focus
        var o = this.inEditor && L5.isWindows && L5.isGecko ? {buffer:10} : null;
        this.el.on("blur", this.onBlur,  this, o);
    },

    // private
    onFocus : function(){
        if(this.focusClass){
            this.el.addClass(this.focusClass);
        }
        if(!this.hasFocus){
            this.hasFocus = true;
            this.startValue = this.getValue();
            this.fireEvent("focus", this);
        }
    },

    // private
    beforeBlur : L5.emptyFn,

    // private
    onBlur : function(){
        this.beforeBlur();
        if(this.focusClass){
            this.el.removeClass(this.focusClass);
        }
        this.hasFocus = false;
        if(this.validationEvent !== false && this.validateOnBlur && this.validationEvent != "blur"){
            this.validate();
        }
        var v = this.getValue();
        if(String(v) !== String(this.startValue)){
            this.fireEvent('change', this, v, this.startValue);
        }
        this.fireEvent("blur", this);
    },

    /**
     * Returns whether or not the field value is currently valid
     * @param {Boolean} preventMark True to disable marking the field invalid
     * @return {Boolean} True if the value is valid, else false
     */
    isValid : function(preventMark){
        if(this.disabled){
            return true;
        }
        var restore = this.preventMark;
        this.preventMark = preventMark === true;
        var v = this.validateValue(this.processValue(this.getRawValue()));
        this.preventMark = restore;
        return v;
    },

    /**
     * Validates the field value
     * @return {Boolean} True if the value is valid, else false
     */
    validate : function(){
        if(this.disabled || this.validateValue(this.processValue(this.getRawValue()))){
            this.clearInvalid();
            return true;
        }
        return false;
    },

    // protected - should be overridden by subclasses if necessary to prepare raw values for validation
    processValue : function(value){
        return value;
    },

    // private
    // Subclasses should provide the validation implementation by overriding this
    validateValue : function(value){
        return true;
    },

    /**
     * Mark this field as invalid, using {@link #msgTarget} to determine how to display the error and
     * applying {@link #invalidClass} to the field's element.
     * @param {String} msg (optional) The validation message (defaults to {@link #invalidText})
     */
    markInvalid : function(msg){
        if(!this.rendered || this.preventMark){ // not rendered
            return;
        }
        this.el.addClass(this.invalidClass);
        msg = msg || this.invalidText;

        switch(this.msgTarget){
            case 'qtip':
                this.el.dom.qtip = msg;
                this.el.dom.qclass = 'l-form-invalid-tip';
                if(L5.QuickTips){ // fix for floating editors interacting with DND
                    L5.QuickTips.enable();
                }
                break;
            case 'title':
                this.el.dom.title = msg;
                break;
            case 'under':
                if(!this.errorEl){
                    var elp = this.getErrorCt();
                    if(!elp){ // field has no container el
                        this.el.dom.title = msg;
                        break;
                    }
                    this.errorEl = elp.createChild({cls:'l-form-invalid-msg'});
                    this.errorEl.setWidth(elp.getWidth(true)-20);
                }
                this.errorEl.update(msg);
                L5.form.Field.msgFx[this.msgFx].show(this.errorEl, this);
                break;
            case 'side':
                if(!this.errorIcon){
                    var elp = this.getErrorCt();
                    if(!elp){ // field has no container el
                        this.el.dom.title = msg;
                        break;
                    }
                    this.errorIcon = elp.createChild({cls:'l-form-invalid-icon'});
                }
                this.alignErrorIcon();
                this.errorIcon.dom.qtip = msg;
                this.errorIcon.dom.qclass = 'l-form-invalid-tip';
                this.errorIcon.show();
                this.on('resize', this.alignErrorIcon, this);
                break;
            default:
                var t = L5.getDom(this.msgTarget);
                t.innerHTML = msg;
                t.style.display = this.msgDisplay;
                break;
        }
        this.fireEvent('invalid', this, msg);
    },

    // private
    getErrorCt : function(){
        return this.el.findParent('.l-form-element', 5, true) || // use form element wrap if available
            this.el.findParent('.l-form-field-wrap', 5, true);   // else direct field wrap
    },

    // private
    alignErrorIcon : function(){
        this.errorIcon.alignTo(this.el, 'tl-tr', [2, 0]);
    },

    /**
     * Clear any invalid styles/messages for this field
     */
    clearInvalid : function(){
        if(!this.rendered || this.preventMark){ // not rendered
            return;
        }
        this.el.removeClass(this.invalidClass);
        switch(this.msgTarget){
            case 'qtip':
                this.el.dom.qtip = '';
                break;
            case 'title':
                this.el.dom.title = '';
                break;
            case 'under':
                if(this.errorEl){
                    L5.form.Field.msgFx[this.msgFx].hide(this.errorEl, this);
                }
                break;
            case 'side':
                if(this.errorIcon){
                    this.errorIcon.dom.qtip = '';
                    this.errorIcon.hide();
                    this.un('resize', this.alignErrorIcon, this);
                }
                break;
            default:
                var t = L5.getDom(this.msgTarget);
                t.innerHTML = '';
                t.style.display = 'none';
                break;
        }
        this.fireEvent('valid', this);
    },

    /**
     * Returns the raw data value which may or may not be a valid, defined value.  To return a normalized value see {@link #getValue}.
     * @return {Mixed} value The field value
     */
    getRawValue : function(){
        var v = this.rendered ? this.el.getValue() : L5.value(this.value, '');
        if(v === this.emptyText){
            v = '';
        }
        return v;
    },

    /**
     * Returns the normalized data value (undefined or emptyText will be returned as '').  To return the raw value see {@link #getRawValue}.
     * @return {Mixed} value The field value
     */
    getValue : function(){
        if(!this.rendered) {
            return this.value;
        }
        var v = this.el.getValue();
        if(v === this.emptyText || v === undefined){
            v = '';
        }
        return v;
    },

    /**
     * Sets the underlying DOM field's value directly, bypassing validation.  To set the value with validation see {@link #setValue}.
     * @param {Mixed} value The value to set
     * @return {Mixed} value The field value that is set
     */
    setRawValue : function(v){
        return this.el.dom.value = (v === null || v === undefined ? '' : v);
    },

    /**
     * Sets a data value into the field and validates it.  To set the value directly without validation see {@link #setRawValue}.
     * @param {Mixed} value The value to set
     */
    setValue : function(v){
        this.value = v;
        if(this.rendered){
            this.el.dom.value = (v === null || v === undefined ? '' : v);
            this.validate();
        }
    },

    // private
    adjustSize : function(w, h){
        var s = L5.form.Field.superclass.adjustSize.call(this, w, h);
        s.width = this.adjustWidth(this.el.dom.tagName, s.width);
        return s;
    },

    // private
    adjustWidth : function(tag, w){
        tag = tag.toLowerCase();
        if(typeof w == 'number' && !L5.isSafari){
            if(L5.isIE && (tag == 'input' || tag == 'textarea')){
                if(tag == 'input' && !L5.isStrict){
                    return this.inEditor ? w : w - 3;
                }
                if(tag == 'input' && L5.isStrict){
                    return w - (L5.isIE6 ? 4 : 1);
                }
                if(tag == 'textarea' && L5.isStrict){
                    return w-2;
                }
            }else if(L5.isOpera && L5.isStrict){
                if(tag == 'input'){
                    return w + 2;
                }
                if(tag == 'textarea'){
                    return w-2;
                }
            }
        }
        return w;
    }

    /**
     * @cfg {Boolean} autoWidth @hide
     */
    /**
     * @cfg {Boolean} autoHeight @hide
     */

    /**
     * @cfg {String} autoEl @hide
     */
});

L5.form.MessageTargets = {
    'qtip' : {
        mark: function(f){
            this.el.dom.qtip = msg;
            this.el.dom.qclass = 'l-form-invalid-tip';
            if(L5.QuickTips){ // fix for floating editors interacting with DND
                L5.QuickTips.enable();
            }
        },
        clear: function(f){
            this.el.dom.qtip = '';
        }
    },
    'title' : {
        mark: function(f){
            this.el.dom.title = msg;
        },
        clear: function(f){
            this.el.dom.title = '';
        }
    },
    'under' : {
        mark: function(f){
            if(!this.errorEl){
                var elp = this.getErrorCt();
                if(!elp){ // field has no container el
                    this.el.dom.title = msg;
                    return;
                }
                this.errorEl = elp.createChild({cls:'l-form-invalid-msg'});
                this.errorEl.setWidth(elp.getWidth(true)-20);
            }
            this.errorEl.update(msg);
            L5.form.Field.msgFx[this.msgFx].show(this.errorEl, this);
        },
        clear: function(f){
            if(this.errorEl){
                L5.form.Field.msgFx[this.msgFx].hide(this.errorEl, this);
            }else{
                this.el.dom.title = '';
            }
        }
    },
    'side' : {
        mark: function(f){
            if(!this.errorIcon){
                var elp = this.getErrorCt();
                if(!elp){ // field has no container el
                    this.el.dom.title = msg;
                    return;
                }
                this.errorIcon = elp.createChild({cls:'l-form-invalid-icon'});
            }
            this.alignErrorIcon();
            this.errorIcon.dom.qtip = msg;
            this.errorIcon.dom.qclass = 'l-form-invalid-tip';
            this.errorIcon.show();
            this.on('resize', this.alignErrorIcon, this);
        },
        clear: function(f){
            if(this.errorIcon){
                this.errorIcon.dom.qtip = '';
                this.errorIcon.hide();
                this.un('resize', this.alignErrorIcon, this);
            }else{
                this.el.dom.title = '';
            }
        }
    },
    'around' : {
        mark: function(f){

        },
        clear: function(f){

        }
    }
};


// anything other than normal should be considered experimental
L5.form.Field.msgFx = {
    normal : {
        show: function(msgEl, f){
            msgEl.setDisplayed('block');
        },

        hide : function(msgEl, f){
            msgEl.setDisplayed(false).update('');
        }
    },

    slide : {
        show: function(msgEl, f){
            msgEl.slideIn('t', {stopFx:true});
        },

        hide : function(msgEl, f){
            msgEl.slideOut('t', {stopFx:true,useDisplay:true});
        }
    },

    slideRight : {
        show: function(msgEl, f){
            msgEl.fixDisplay();
            msgEl.alignTo(f.el, 'tl-tr');
            msgEl.slideIn('l', {stopFx:true});
        },

        hide : function(msgEl, f){
            msgEl.slideOut('l', {stopFx:true,useDisplay:true});
        }
    }
};
L5.reg('field', L5.form.Field);
