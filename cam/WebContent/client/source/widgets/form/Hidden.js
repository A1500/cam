/**
 * @class L5.form.Hidden
 * @extends L5.form.Field
 * A basic hidden field for storing hidden values in forms that need to be passed in the form submit.
 * @constructor
 * Create a new Hidden field.
 * @param {Object} config Configuration options
 */
L5.form.Hidden = L5.extend(L5.form.Field, {
    // private
    inputType : 'hidden',

    // private
    onRender : function(){
        L5.form.Hidden.superclass.onRender.apply(this, arguments);
    },

    // private
    initEvents : function(){
        this.originalValue = this.getValue();
    },

    // These are all private overrides
    setSize : L5.emptyFn,
    setWidth : L5.emptyFn,
    setHeight : L5.emptyFn,
    setPosition : L5.emptyFn,
    setPagePosition : L5.emptyFn,
    markInvalid : L5.emptyFn,
    clearInvalid : L5.emptyFn
});
L5.reg('hidden', L5.form.Hidden);