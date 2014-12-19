/**
 * @class L5.form.Label
 * @extends L5.BoxComponent
 * Basic Label field.
 * @constructor
 * Creates a new Label
 * @param {L5.Element/String/Object} config The configuration options.  If an element is passed, it is set as the internal
 * element and its id used as the component id.  If a string is passed, it is assumed to be the id of an existing element
 * and is used as the component id.  Otherwise, it is assumed to be a standard config object and is applied to the component.
 */
L5.form.Label = L5.extend(L5.BoxComponent, {
    /**
     * @cfg {String} text The plain text to display within the label (defaults to ''). If you need to include HTML 
     * tags within the label's innerHTML, use the {@link #html} config instead.
     */
    /**
     * @cfg {String} forId The id of the input element to which this label will be bound via the standard HTML 'for'
     * attribute. If not specified, the attribute will not be added to the label.
     */
    /**
     * @cfg {String} html An HTML fragment that will be used as the label's innerHTML (defaults to ''). 
     * Note that if {@link #text} is specified it will take precedence and this value will be ignored.
     */

    // private
    onRender : function(ct, position){
        if(!this.el){
            this.el = document.createElement('label');
            this.el.id = this.getId();
            this.el.innerHTML = this.text ? L5.util.Format.htmlEncode(this.text) : (this.html || '');
            if(this.forId){
                this.el.setAttribute('for', this.forId);
            }
        }
        L5.form.Label.superclass.onRender.call(this, ct, position);
    },
    
    /**
     * Updates the label's innerHTML with the specified string.
     * @param {String} text The new label text
     * @param {Boolean} encode (optional) False to skip HTML-encoding the text when rendering it
     * to the label (defaults to true which encodes the value). This might be useful if you want to include 
     * tags in the label's innerHTML rather than rendering them as string literals per the default logic.
     * @return {Label} this
     */
    setText: function(t, encode){
        this.text = t;
        if(this.rendered){
            this.el.dom.innerHTML = encode !== false ? L5.util.Format.htmlEncode(t) : t;
        }
        return this;
    }
});

L5.reg('label', L5.form.Label);