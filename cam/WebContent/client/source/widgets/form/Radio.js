/**
 * @class L5.form.Radio
 * @extends L5.form.Checkbox
 * Single radio field.  Same as Checkbox, but provided as a convenience for automatically setting the input type.
 * Radio grouping is handled automatically by the browser if you give each radio in a group the same name.
 * @constructor
 * Creates a new Radio
 * @param {Object} config Configuration options
 */
L5.form.Radio = L5.extend(L5.form.Checkbox, {
    // private
    inputType: 'radio',
    // private
    baseCls: 'l-form-radio',
    
    /**
     * If this radio is part of a group, it will return the selected value
     * @return {String}
     */
    getGroupValue : function(){
        var c = this.getParent().child('input[name='+this.el.dom.name+']:checked', true);
        return c ? c.value : null;
    },
    
    // private
    getParent : function(){
        return this.el.up('form') || L5.getBody();
    },

    // private
    toggleValue : function() {
        if(!this.checked){
            var els = this.getParent().select('input[name='+this.el.dom.name+']');
            els.each(function(el){
                if(el.dom.id == this.id){
                    this.setValue(true);
                }else{
                    L5.getCmp(el.dom.id).setValue(false);
                }
            }, this);
        }
    },
    
    /**
     * Sets either the checked/unchecked status of this Radio, or, if a string value
     * is passed, checks a sibling Radio of the same name whose value is the value specified.
     * @param value {String/Boolean} Checked value, or the value of the sibling radio button to check.
     */
    setValue : function(v){
        if(typeof v=='boolean') {
            L5.form.Radio.superclass.setValue.call(this, v);
        }else{
            var r = this.getParent().child('input[name='+this.el.dom.name+'][value='+v+']', true);
            if(r && !r.checked){
                L5.getCmp(r.id).toggleValue();
            };
        }
    },
    
    /**
     * Overridden and disabled. The editor element does not support standard valid/invalid marking. @hide
     * @method
     */
    markInvalid : L5.emptyFn,
    /**
     * Overridden and disabled. The editor element does not support standard valid/invalid marking. @hide
     * @method
     */
    clearInvalid : L5.emptyFn
    
});
L5.reg('radio', L5.form.Radio);
