
/**
 * @class L5.form.RadioGroup
 * @extends L5.form.CheckboxGroup
 * A grouping container for {@link L5.form.Radio} controls.
 * @constructor
 * Creates a new RadioGroup
 * @param {Object} config Configuration options
 */
L5.form.RadioGroup = L5.extend(L5.form.CheckboxGroup, {
    /**
     * @cfg {Boolean} allowBlank True to allow every item in the group to be blank (defaults to false). If allowBlank = 
     * false and no items are selected at validation time, {@link @blankText} will be used as the error text.
     */
    allowBlank : true,
    /**
     * @cfg {String} blankText Error text to display if the {@link #allowBlank} validation fails (defaults to "You must 
     * select one item in this group")
     */
    blankText : "You must select one item in this group",
    
    // private
    defaultType : 'radio',
    
    // private
    groupCls: 'l-form-radio-group'
});

L5.reg('radiogroup', L5.form.RadioGroup);
