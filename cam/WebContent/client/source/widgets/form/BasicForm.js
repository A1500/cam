/**
 * @class L5.form.BasicForm
 * @extends L5.util.Observable
 * <p>Encapsulates the DOM &lt;form> element at the heart of the {@link L5.form.FormPanel FormPanel} class, and provides
 * input field management, validation, submission, and form loading services.</p>
 * <p>By default, L5 Forms are submitted through Ajax, using an instance of {@link L5.form.Action.Submit}.
 * To enable normal browser submission of an L5 Form, use the {@link #standardSubmit} config option.</p>
 * <p><h3>File Uploads</h3>{@link #fileUpload File uploads} are not performed using Ajax submission, that
 * is they are <b>not</b> performed using XMLHttpRequests. Instead the form is submitted in the standard
 * manner with the DOM <tt>&lt;form></tt> element temporarily modified to have its
 * <a href="http://www.w3.org/TR/REC-html40/present/frames.html#adef-target">target</a> set to refer
 * to a dynamically generated, hidden <tt>&lt;iframe></tt> which is inserted into the document
 * but removed after the return data has been gathered.</p>
 * <p>The server response is parsed by the browser to create the document for the IFRAME. If the
 * server is using JSON to send the return object, then the
 * <a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.17">Content-Type</a> header
 * must be set to "text/html" in order to tell the browser to insert the text unchanged into the document body.</p>
 * <p>Characters which are significant to an HTML parser must be sent as HTML entities, so encode
 * "&lt;" as "&amp;lt;", "&amp;" as "&amp;amp;" etc.</p>
 * <p>The response text is retrieved from the document, and a fake XMLHttpRequest object
 * is created containing a <tt>responseText</tt> property in order to conform to the
 * requirements of event handlers and callbacks.</p>
 * <p>Be aware that file upload packets are sent with the content type <a href="http://www.faqs.org/rfcs/rfc2388.html">multipart/form</a>
 * and some server technologies (notably JEE) may require some custom processing in order to
 * retrieve parameter names and parameter values from the packet content.</p>
 * @constructor
 * @param {Mixed} el The form element or its id
 * @param {Object} config Configuration options
 */
L5.form.BasicForm = function(el, config){
    L5.apply(this, config);
    /*
     * The L5.form.Field items in this form.
     * @type MixedCollection
     */
    this.items = new L5.util.MixedCollection(false, function(o){
        return o.id || (o.id = L5.id());
    });
    this.addEvents(
        /**
         * @event beforeaction
         * Fires before any action is performed. Return false to cancel the action.
         * @param {Form} this
         * @param {Action} action The {@link L5.form.Action} to be performed
         */
        'beforeaction',
        /**
         * @event actionfailed
         * Fires when an action fails.
         * @param {Form} this
         * @param {Action} action The {@link L5.form.Action} that failed
         */
        'actionfailed',
        /**
         * @event actioncomplete
         * Fires when an action is completed.
         * @param {Form} this
         * @param {Action} action The {@link L5.form.Action} that completed
         */
        'actioncomplete'
    );

    if(el){
        this.initEl(el);
    }
    L5.form.BasicForm.superclass.constructor.call(this);
};

L5.extend(L5.form.BasicForm, L5.util.Observable, {
    /**
     * @cfg {String} method
     * The request method to use (GET or POST) for form actions if one isn't supplied in the action options.
     */
    /**
     * @cfg {DataReader} reader
     * An L5.model.DataReader (e.g. {@link L5.model.XmlReader}) to be used to read data when executing "load" actions.
     * This is optional as there is built-in support for processing JSON.
     */
    /**
     * @cfg {DataReader} errorReader
     * <p>An L5.model.DataReader (e.g. {@link L5.model.XmlReader}) to be used to read field error messages returned from "submit" actions.
     * This is completely optional as there is built-in support for processing JSON.</p>
     * <p>The Records which provide messages for the invalid Fields must use the Field name (or id) as the Record ID,
     * and must contain a field called "msg" which contains the error message.</p>
     * <p>The errorReader does not have to be a full-blown implementation of a DataReader. It simply needs to implement a 
     * <tt>read(xhr)</tt> function which returns an Array of Records in an object with the following structure:<pre><code>
{
    records: recordArray
}
</code></pre>
     */
    /**
     * @cfg {String} url
     * The URL to use for form actions if one isn't supplied in the action options.
     */
    /**
     * @cfg {Boolean} fileUpload
     * Set to true if this form is a file upload.
     * <p>File uploads are not performed using normal "Ajax" techniques, that is they are <b>not</b>
     * performed using XMLHttpRequests. Instead the form is submitted in the standard manner with the
     * DOM <tt>&lt;form></tt> element temporarily modified to have its
     * <a href="http://www.w3.org/TR/REC-html40/present/frames.html#adef-target">target</a> set to refer
     * to a dynamically generated, hidden <tt>&lt;iframe></tt> which is inserted into the document
     * but removed after the return data has been gathered.</p>
     * <p>The server response is parsed by the browser to create the document for the IFRAME. If the
     * server is using JSON to send the return object, then the
     * <a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.17">Content-Type</a> header
     * must be set to "text/html" in order to tell the browser to insert the text unchanged into the document body.</p>
     * <p>Characters which are significant to an HTML parser must be sent as HTML entities, so encode
     * "&lt;" as "&amp;lt;", "&amp;" as "&amp;amp;" etc.</p>
     * <p>The response text is retrieved from the document, and a fake XMLHttpRequest object
     * is created containing a <tt>responseText</tt> property in order to conform to the
     * requirements of event handlers and callbacks.</p>
     * <p>Be aware that file upload packets are sent with the content type <a href="http://www.faqs.org/rfcs/rfc2388.html">multipart/form</a>
     * and some server technologies (notably JEE) may require some custom processing in order to
     * retrieve parameter names and parameter values from the packet content.</p>
     */
    /**
     * @cfg {Object} baseParams
     * Parameters to pass with all requests. e.g. baseParams: {id: '123', foo: 'bar'}.
     */
    /**
     * @cfg {Number} timeout Timeout for form actions in seconds (default is 30 seconds).
     */
    timeout: 30,

    // private
    activeAction : null,

    /**
     * @cfg {Boolean} trackResetOnLoad If set to true, form.reset() resets to the last loaded
     * or setValues() data instead of when the form was first created.
     */
    trackResetOnLoad : false,

    /**
     * @cfg {Boolean} standardSubmit If set to true, standard HTML form submits are used instead of XHR (Ajax) style
     * form submissions. (defaults to false)<br>
     * <p><b>Note:</b> When using standardSubmit, any the options to {@link #submit} are
     * ignored because L5's Ajax infrastracture is bypassed. To pass extra parameters, you will need to create
     * hidden fields within the form.</p>
     */
    /**
     * By default wait messages are displayed with L5.MessageBox.wait. You can target a specific
     * element by passing it or its id or mask the form itself by passing in true.
     * @type Mixed
     * @property waitMsgTarget
     */

    // private
    initEl : function(el){
        this.el = L5.get(el);
        this.id = this.el.id || L5.id();
        if(!this.standardSubmit){
            this.el.on('submit', this.onSubmit, this);
        }
        this.el.addClass('l-form');
    },

    /**
     * Get the HTML form Element
     * @return L5.Element
     */
    getEl: function(){
        return this.el;
    },

    // private
    onSubmit : function(e){
        e.stopEvent();
    },

    // private
    destroy: function() {
        this.items.each(function(f){
            L5.destroy(f);
        });
        if(this.el){
            this.el.removeAllListeners();
            this.el.remove();
        }
        this.purgeListeners();
    },

    /**
     * Returns true if client-side validation on the form is successful.
     * @return Boolean
     */
    isValid : function(){
        var valid = true;
        this.items.each(function(f){
           if(!f.validate()){
               valid = false;
           }
        });
        return valid;
    },

    /**
     * Returns true if any fields in this form have changed since their original load.
     * @return Boolean
     */
    isDirty : function(){
        var dirty = false;
        this.items.each(function(f){
           if(f.isDirty()){
               dirty = true;
               return false;
           }
        });
        return dirty;
    },

    /**
     * Performs a predefined action ({@link L5.form.Action.Submit} or
     * {@link L5.form.Action.Load}) or a custom extension of {@link L5.form.Action} 
     * to perform application-specific processing.
     * @param {String/Object} actionName The name of the predefined action type,
     * or instance of {@link L5.form.Action} to perform.
     * @param {Object} options (optional) The options to pass to the {@link L5.form.Action}. 
     * All of the config options listed below are supported by both the submit
     * and load actions unless otherwise noted (custom actions could also accept
     * other config options):<ul>
     * <li><b>url</b> : String<p style="margin-left:1em">The url for the action (defaults
     * to the form's url.)</p></li>
     * <li><b>method</b> : String<p style="margin-left:1em">The form method to use (defaults
     * to the form's method, or POST if not defined)</p></li>
     * <li><b>params</b> : String/Object<p style="margin-left:1em">The params to pass
     * (defaults to the form's baseParams, or none if not defined)</p></li>
     * <li><b>headers</b> : Object<p style="margin-left:1em">Request headers to set for the action
     * (defaults to the form's default headers)</p></li>
     * <li><b>success</b> : Function<p style="margin-left:1em">The callback that will
     * be invoked after a successful response.  The function is passed the following parameters:<ul>
     * <li><code>form</code> : L5.form.BasicForm<div class="sub-desc">The form that requested the action</div></li>
     * <li><code>action</code> : L5.form.Action<div class="sub-desc">The {@link L5.form.Action Action} object which performed the operation. The {@link L5.form.Action#result result}
     * property of this object may be examined to perform custom postprocessing.</div></li>
     * </ul></p></li>
     * <li><b>failure</b> : Function<p style="margin-left:1em">The callback that will
     * be invoked after a failed transaction attempt.  The function
     * is passed the following parameters:<ul>
     * <li><code>form</code> : L5.form.BasicForm<div class="sub-desc">The form that requested the action</div></li>
     * <li><code>action</code> : L5.form.Action<div class="sub-desc">The {@link L5.form.Action Action} object which performed the operation. If an Ajax
     * error ocurred, the failure type will be in {@link L5.form.Action#failureType failureType}. The {@link L5.form.Action#result result}
     * property of this object may be examined to perform custom postprocessing.</div></li>
     * </ul></p></li>
     * <li><b>scope</b> : Object<p style="margin-left:1em">The scope in which to call the
     * callback functions (The <tt>this</tt> reference for the callback functions).</p></li>
     * <li><b>clientValidation</b> : Boolean<p style="margin-left:1em">Submit Action only.
     * Determines whether a Form's fields are validated in a final call to
     * {@link L5.form.BasicForm#isValid isValid} prior to submission. Set to <tt>false</tt>
     * to prevent this. If undefined, pre-submission field validation is performed.</p></li></ul>
     * @return {BasicForm} this
     */
    doAction : function(action, options){
        if(typeof action == 'string'){
            action = new L5.form.Action.ACTION_TYPES[action](this, options);
        }
        if(this.fireEvent('beforeaction', this, action) !== false){
            this.beforeAction(action);
            action.run.defer(100, action);
        }
        return this;
    },

    /**
     * Shortcut to do a submit action.
     * @param {Object} options The options to pass to the action (see {@link #doAction} for details).<br>
     * <p><b>Note:</b> this is ignored when using the {@link #standardSubmit} option.</p>
     * <p>The following code:</p><pre><code>
myFormPanel.getForm().submit({
    clientValidation: true,
    url: 'updateConsignment.php',
    params: {
        newStatus: 'delivered'
    },
    success: function(form, action) {
       L5.Msg.alert("Success", action.result.msg);
    },
    failure: function(form, action) {
        switch (action.failureType) {
            case L5.form.Action.CLIENT_INVALID:
                L5.Msg.alert("Failure", "Form fields may not be submitted with invalid values");
                break;
            case L5.form.Action.CONNECT_FAILURE:
                L5.Msg.alert("Failure", "Ajax communication failed");
                break;
            case L5.form.Action.SERVER_INVALID:
               L5.Msg.alert("Failure", action.result.msg);
       }
    }
});
</code></pre>
     * would process the following server response for a successful submission:<pre><code>
{
    success: true,
    msg: 'Consignment updated'
}
</code></pre>
     * and the following server response for a failed submission:<pre><code>
{
    success: false,
    msg: 'You do not have permission to perform this operation'
}
</code></pre>
     * @return {BasicForm} this
     */
    submit : function(options){
        if(this.standardSubmit){
            var v = this.isValid();
            if(v){
                this.el.dom.submit();
            }
            return v;
        }
        this.doAction('submit', options);
        return this;
    },

    /**
     * Shortcut to do a load action.
     * @param {Object} options The options to pass to the action (see {@link #doAction} for details)
     * @return {BasicForm} this
     */
    load : function(options){
        this.doAction('load', options);
        return this;
    },

    /**
     * Persists the values in this form into the passed L5.model.Record object in a beginEdit/endEdit block.
     * @param {Record} record The record to edit
     * @return {BasicForm} this
     */
    updateRecord : function(record){
        record.beginEdit();
        var fs = record.fields;
        fs.each(function(f){
            var field = this.findField(f.name);
            if(field){
                record.set(f.name, field.getValue());
            }
        }, this);
        record.endEdit();
        return this;
    },

    /**
     * Loads an L5.model.Record into this form.
     * @param {Record} record The record to load
     * @return {BasicForm} this
     */
    loadRecord : function(record){
        this.setValues(record.data);
        return this;
    },

    // private
    beforeAction : function(action){
        var o = action.options;
        if(o.waitMsg){
            if(this.waitMsgTarget === true){
                this.el.mask(o.waitMsg, 'l-mask-loading');
            }else if(this.waitMsgTarget){
                this.waitMsgTarget = L5.get(this.waitMsgTarget);
                this.waitMsgTarget.mask(o.waitMsg, 'l-mask-loading');
            }else{
                L5.MessageBox.wait(o.waitMsg, o.waitTitle || this.waitTitle || 'Please Wait...');
            }
        }
    },

    // private
    afterAction : function(action, success){
        this.activeAction = null;
        var o = action.options;
        if(o.waitMsg){
            if(this.waitMsgTarget === true){
                this.el.unmask();
            }else if(this.waitMsgTarget){
                this.waitMsgTarget.unmask();
            }else{
                L5.MessageBox.updateProgress(1);
                L5.MessageBox.hide();
            }
        }
        if(success){
            if(o.reset){
                this.reset();
            }
            L5.callback(o.success, o.scope, [this, action]);
            this.fireEvent('actioncomplete', this, action);
        }else{
            L5.callback(o.failure, o.scope, [this, action]);
            this.fireEvent('actionfailed', this, action);
        }
    },

    /**
     * Find a L5.form.Field in this form by id, field, name or hiddenName.
     * @param {String} id The value to search for
     * @return Field
     */
    findField : function(id){
        var field = this.items.get(id);
        if(!field){
            this.items.each(function(f){
                if(f.isFormField && (f.field == id || f.id == id || f.getName() == id)){
                    field = f;
                    return false;
                }
            });
        }
        return field || null;
    },


    /**
     * Mark fields in this form invalid in bulk.
     * @param {Array/Object} errors Either an array in the form [{id:'fieldId', msg:'The message'},...] or an object hash of {id: msg, id2: msg2}
     * @return {BasicForm} this
     */
    markInvalid : function(errors){
        if(L5.isArray(errors)){
            for(var i = 0, len = errors.length; i < len; i++){
                var fieldError = errors[i];
                var f = this.findField(fieldError.id);
                if(f){
                    f.markInvalid(fieldError.msg);
                }
            }
        }else{
            var field, id;
            for(id in errors){
                if(typeof errors[id] != 'function' && (field = this.findField(id))){
                    field.markInvalid(errors[id]);
                }
            }
        }
        return this;
    },

    /**
     * Set values for fields in this form in bulk.
     * @param {Array/Object} values Either an array in the form:<br><br><code><pre>
[{id:'clientName', value:'Fred. Olsen Lines'},
 {id:'portOfLoading', value:'FXT'},
 {id:'portOfDischarge', value:'OSL'} ]</pre></code><br><br>
     * or an object hash of the form:<br><br><code><pre>
{
    clientName: 'Fred. Olsen Lines',
    portOfLoading: 'FXT',
    portOfDischarge: 'OSL'
}</pre></code><br>
     * @return {BasicForm} this
     */
    setValues : function(values){
        if(L5.isArray(values)){ // array of objects
            for(var i = 0, len = values.length; i < len; i++){
                var v = values[i];
                var f = this.findField(v.id);
                if(f){
                    f.setValue(v.value);
                    if(this.trackResetOnLoad){
                        f.originalValue = f.getValue();
                    }
                }
            }
        }else{ // object hash
            var field, id;
            for(id in values){
                if(typeof values[id] != 'function' && (field = this.findField(id))){
                    field.setValue(values[id]);
                    if(this.trackResetOnLoad){
                        field.originalValue = field.getValue();
                    }
                }
            }
        }
        return this;
    },

    /**
     * <p>Returns the fields in this form as an object with key/value pairs as they would be submitted using a standard form submit.
     * If multiple fields exist with the same name they are returned as an array.</p>
     *
     * <p><b>Note:</b> The values are collected from all enabled HTML input elements within the form, <u>not</u> from
     * the L5 Field objects. This means that all returned values are Strings (or Arrays of Strings) and that the the
     * value can potentionally be the emptyText of a field.</p>
     * @param {Boolean} asString (optional) false to return the values as an object (defaults to returning as a string)
     * @return {String/Object}
     */
    getValues : function(asString){
        var fs = L5.lib.Ajax.serializeForm(this.el.dom);
        if(asString === true){
            return fs;
        }
        return L5.urlDecode(fs);
    },

    /**
     * Clears all invalid messages in this form.
     * @return {BasicForm} this
     */
    clearInvalid : function(){
        this.items.each(function(f){
           f.clearInvalid();
        });
        return this;
    },

    /**
     * Resets this form.
     * @return {BasicForm} this
     */
    reset : function(){
        this.items.each(function(f){
            f.reset();
        });
        return this;
    },

    /**
     * Add L5.form Components to this form's Collection. This does not result in rendering of
     * the passed Component, it just enables the form to validate Fields, and distribute values to
     * Fields.
     * <p><b>You will not usually call this function. In order to be rendered, a Field must be added
     * to a {@link L5.Container Container}, usually an {@link L5.form.FormPanel FormPanel}.
     * The FormPanel to which the field is added takes care of adding the Field to the BasicForm's
     * collection.</b></p>
     * @param {Field} field1
     * @param {Field} field2 (optional)
     * @param {Field} etc (optional)
     * @return {BasicForm} this
     */
    add : function(){
        this.items.addAll(Array.prototype.slice.call(arguments, 0));
        return this;
    },


    /**
     * Removes a field from the items collection (does NOT remove its markup).
     * @param {Field} field
     * @return {BasicForm} this
     */
    remove : function(field){
        this.items.remove(field);
        return this;
    },

    /**
     * Iterates through the {@link L5.form.Field Field}s which have been {@link #add add}ed to this BasicForm,
     * checks them for an id attribute, and calls {@link L5.form.Field#applyToMarkup} on the existing dom element with that id.
     * @return {BasicForm} this
     */
    render : function(){
        this.items.each(function(f){
            if(f.isFormField && !f.rendered && document.getElementById(f.id)){ // if the element exists
                f.applyToMarkup(f.id);
            }
        });
        return this;
    },

    /**
     * Calls {@link L5#apply} for all fields in this form with the passed object.
     * @param {Object} values
     * @return {BasicForm} this
     */
    applyToFields : function(o){
        this.items.each(function(f){
           L5.apply(f, o);
        });
        return this;
    },

    /**
     * Calls {@link L5#applyIf} for all field in this form with the passed object.
     * @param {Object} values
     * @return {BasicForm} this
     */
    applyIfToFields : function(o){
        this.items.each(function(f){
           L5.applyIf(f, o);
        });
        return this;
    }
});

// back compat
L5.BasicForm = L5.form.BasicForm;