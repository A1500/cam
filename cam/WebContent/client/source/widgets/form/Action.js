/**
 * @class L5.form.Action
 * <p>The subclasses of this class provide actions to perform upon {@link L5.form.BasicForm Form}s.</p>
 * <p>Instances of this class are only created by a {@link L5.form.BasicForm Form} when
 * the Form needs to perform an action such as submit or load. The Configuration options
 * listed for this class are set through the Form's action methods: {@link L5.form.BasicForm#submit submit},
 * {@link L5.form.BasicForm#load load} and {@link L5.form.BasicForm#doAction doAction}</p>
 * <p>The instance of Action which performed the action is passed to the success
 * and failure callbacks of the Form's action methods ({@link L5.form.BasicForm#submit submit},
 * {@link L5.form.BasicForm#load load} and {@link L5.form.BasicForm#doAction doAction}),
 * and to the {@link L5.form.BasicForm#actioncomplete actioncomplete} and
 * {@link L5.form.BasicForm#actionfailed actionfailed} event handlers.</p>
 */
L5.form.Action = function(form, options){
    this.form = form;
    this.options = options || {};
};

/**
 * Failure type returned when client side validation of the Form fails
 * thus aborting a submit action.
 * @type {String}
 * @static
 */
L5.form.Action.CLIENT_INVALID = 'client';
/**
 * Failure type returned when server side validation of the Form fails
 * indicating that field-specific error messages have been returned in the
 * response's <tt style="font-weight:bold">errors</tt> property.
 * @type {String}
 * @static
 */
L5.form.Action.SERVER_INVALID = 'server';
/**
 * Failure type returned when a communication error happens when attempting
 * to send a request to the remote server.
 * @type {String}
 * @static
 */
L5.form.Action.CONNECT_FAILURE = 'connect';
/**
 * Failure type returned when no field values are returned in the response's
 * <tt style="font-weight:bold">data</tt> property.
 * @type {String}
 * @static
 */
L5.form.Action.LOAD_FAILURE = 'load';

L5.form.Action.prototype = {
/**
 * @cfg {String} url The URL that the Action is to invoke.
 */
/**
 * @cfg {Boolean} reset When set to <tt><b>true</b></tt>, causes the Form to be
 * {@link L5.form.BasicForm.reset reset} on Action success. If specified, this happens
 * <b>before</b> the {@link #success} callback is called and before the Form's
 * {@link L5.form.BasicForm.actioncomplete actioncomplete} event fires.
 */
/**
 * @cfg {String} method The HTTP method to use to access the requested URL. Defaults to the
 * {@link L5.form.BasicForm}'s method, or if that is not specified, the underlying DOM form's method.
 */
/**
 * @cfg {Mixed} params Extra parameter values to pass. These are added to the Form's
 * {@link L5.form.BasicForm#baseParams} and passed to the specified URL along with the Form's
 * input fields.
 */
/**
 * @cfg {Number} timeout The number of milliseconds to wait for a server response before
 * failing with the {@link #failureType} as {@link #Action.CONNECT_FAILURE}.
 */
/**
 * @cfg {Function} success The function to call when a valid success return packet is recieved.
 * The function is passed the following parameters:<ul class="mdetail-params">
 * <li><b>form</b> : L5.form.BasicForm<div class="sub-desc">The form that requested the action</div></li>
 * <li><b>action</b> : L5.form.Action<div class="sub-desc">The Action class. The {@link #result}
 * property of this object may be examined to perform custom postprocessing.</div></li>
 * </ul>
 */
/**
 * @cfg {Function} failure The function to call when a failure packet was recieved, or when an
 * error ocurred in the Ajax communication.
 * The function is passed the following parameters:<ul class="mdetail-params">
 * <li><b>form</b> : L5.form.BasicForm<div class="sub-desc">The form that requested the action</div></li>
 * <li><b>action</b> : L5.form.Action<div class="sub-desc">The Action class. If an Ajax
 * error ocurred, the failure type will be in {@link #failureType}. The {@link #result}
 * property of this object may be examined to perform custom postprocessing.</div></li>
 * </ul>
*/
/**
 * @cfg {Object} scope The scope in which to call the callback functions (The <tt>this</tt> reference
 * for the callback functions).
 */
/**
 * @cfg {String} waitMsg The message to be displayed by a call to {@link L5.MessageBox#wait}
 * during the time the action is being processed.
 */
/**
 * @cfg {String} waitTitle The title to be displayed by a call to {@link L5.MessageBox#wait}
 * during the time the action is being processed.
 */

/**
 * The type of action this Action instance performs.
 * Currently only "submit" and "load" are supported.
 * @type {String}
 */
    type : 'default',
/**
 * The type of failure detected. See {@link link L5.form.Action#Action.CLIENT_INVALID CLIENT_INVALID},
 * {@link link L5.form.Action#Action.SERVER_INVALID SERVER_INVALID},
 * {@link #link L5.form.ActionAction.CONNECT_FAILURE CONNECT_FAILURE}, {@link L5.form.Action#Action.LOAD_FAILURE LOAD_FAILURE}
 * @property failureType
 * @type {String}
 *//**
 * The XMLHttpRequest object used to perform the action.
 * @property response
 * @type {Object}
 *//**
 * The decoded response object containing a boolean <tt style="font-weight:bold">success</tt> property and
 * other, action-specific properties.
 * @property result
 * @type {Object}
 */

    // interface method
    run : function(options){

    },

    // interface method
    success : function(response){

    },

    // interface method
    handleResponse : function(response){

    },

    // default connection failure
    failure : function(response){
        this.response = response;
        this.failureType = L5.form.Action.CONNECT_FAILURE;
        this.form.afterAction(this, false);
    },

    // private
    processResponse : function(response){
        this.response = response;
        if(!response.responseText){
            return true;
        }
        this.result = this.handleResponse(response);
        return this.result;
    },

    // utility functions used internally
    getUrl : function(appendParams){
        var url = this.options.url || this.form.url || this.form.el.dom.action;
        if(appendParams){
            var p = this.getParams();
            if(p){
                url += (url.indexOf('?') != -1 ? '&' : '?') + p;
            }
        }
        return url;
    },

    // private
    getMethod : function(){
        return (this.options.method || this.form.method || this.form.el.dom.method || 'POST').toUpperCase();
    },

    // private
    getParams : function(){
        var bp = this.form.baseParams;
        var p = this.options.params;
        if(p){
            if(typeof p == "object"){
                p = L5.urlEncode(L5.applyIf(p, bp));
            }else if(typeof p == 'string' && bp){
                p += '&' + L5.urlEncode(bp);
            }
        }else if(bp){
            p = L5.urlEncode(bp);
        }
        return p;
    },

    // private
    createCallback : function(opts){
		var opts = opts || {};
        return {
            success: this.success,
            failure: this.failure,
            scope: this,
            timeout: (opts.timeout*1000) || (this.form.timeout*1000),
            upload: this.form.fileUpload ? this.success : undefined
        };
    }
};

/**
 * @class L5.form.Action.Submit
 * @extends L5.form.Action
 * <p>A class which handles submission of data from {@link L5.form.BasicForm Form}s
 * and processes the returned response.</p>
 * <p>Instances of this class are only created by a {@link L5.form.BasicForm Form} when
 * {@link L5.form.BasicForm#submit submit}ting.</p>
 * <p>A response packet must contain a boolean <tt style="font-weight:bold">success</tt> property, and, optionally
 * an <tt style="font-weight:bold">errors</tt> property. The <tt style="font-weight:bold">errors</tt> property contains error
 * messages for invalid fields.</p>
 * <p>By default, response packets are assumed to be JSON, so a typical response
 * packet may look like this:</p><pre><code>
{
    success: false,
    errors: {
        clientCode: "Client not found",
        portOfLoading: "This field must not be null"
    }
}</code></pre>
 * <p>Other data may be placed into the response for processing by the {@link L5.form.BasicForm}'s callback
 * or event handler methods. The object decoded from this JSON is available in the {@link #result} property.</p>
 * <p>Alternatively, if an {@link #errorReader} is specified as an {@link L5.model.XmlReader XmlReader}:</p><pre><code>
    errorReader: new L5.model.XmlReader({
            record : 'field',
            success: '@success'
        }, [
            'id', 'msg'
        ]
    )
</code></pre>
 * <p>then the results may be sent back in XML format:</p><pre><code>
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;message success="false"&gt;
&lt;errors&gt;
    &lt;field&gt;
        &lt;id&gt;clientCode&lt;/id&gt;
        &lt;msg&gt;&lt;![CDATA[Code not found. &lt;br /&gt;&lt;i&gt;This is a test validation message from the server &lt;/i&gt;]]&gt;&lt;/msg&gt;
    &lt;/field&gt;
    &lt;field&gt;
        &lt;id&gt;portOfLoading&lt;/id&gt;
        &lt;msg&gt;&lt;![CDATA[Port not found. &lt;br /&gt;&lt;i&gt;This is a test validation message from the server &lt;/i&gt;]]&gt;&lt;/msg&gt;
    &lt;/field&gt;
&lt;/errors&gt;
&lt;/message&gt;
</code></pre>
 * <p>Other elements may be placed into the response XML for processing by the {@link L5.form.BasicForm}'s callback
 * or event handler methods. The XML document is available in the {@link #errorReader}'s {@link L5.model.XmlReader#xmlData xmlData} property.</p>
 */
L5.form.Action.Submit = function(form, options){
    L5.form.Action.Submit.superclass.constructor.call(this, form, options);
};

L5.extend(L5.form.Action.Submit, L5.form.Action, {
    /**
    * @cfg {L5.model.DataReader} errorReader <b>Optional. JSON is interpreted with no need for an errorReader.</b>
    * <p>A Reader which reads a single record from the returned data. The DataReader's <b>success</b> property specifies
    * how submission success is determined. The Record's data provides the error messages to apply to any invalid form Fields.</p>.
    */
    /**
    * @cfg {boolean} clientValidation Determines whether a Form's fields are validated
    * in a final call to {@link L5.form.BasicForm#isValid isValid} prior to submission.
    * Pass <tt>false</tt> in the Form's submit options to prevent this. If not defined, pre-submission field validation
    * is performed.
    */
    type : 'submit',

    // private
    run : function(){
        var o = this.options;
        var method = this.getMethod();
        var isGet = method == 'GET';
        if(o.clientValidation === false || this.form.isValid()){
            L5.Ajax.request(L5.apply(this.createCallback(o), {
                form:this.form.el.dom,
                url:this.getUrl(isGet),
                method: method,
                headers: o.headers,
                params:!isGet ? this.getParams() : null,
                isUpload: this.form.fileUpload
            }));
        }else if (o.clientValidation !== false){ // client validation failed
            this.failureType = L5.form.Action.CLIENT_INVALID;
            this.form.afterAction(this, false);
        }
    },

    // private
    success : function(response){
        var result = this.processResponse(response);
        if(result === true || result.success){
            this.form.afterAction(this, true);
            return;
        }
        if(result.errors){
            this.form.markInvalid(result.errors);
            this.failureType = L5.form.Action.SERVER_INVALID;
        }
        this.form.afterAction(this, false);
    },

    // private
    handleResponse : function(response){
        if(this.form.errorReader){
            var rs = this.form.errorReader.read(response);
            var errors = [];
            if(rs.records){
                for(var i = 0, len = rs.records.length; i < len; i++) {
                    var r = rs.records[i];
                    errors[i] = r.data;
                }
            }
            if(errors.length < 1){
                errors = null;
            }
            return {
                success : rs.success,
                errors : errors
            };
        }
        return L5.decode(response.responseText);
    }
});


/**
 * @class L5.form.Action.Load
 * @extends L5.form.Action
 * <p>A class which handles loading of data from a server into the Fields of an {@link L5.form.BasicForm}.</p>
 * <p>Instances of this class are only created by a {@link L5.form.BasicForm Form} when
 * {@link L5.form.BasicForm#load load}ing.</p>
 * <p>A response packet <b>must</b> contain a boolean <tt style="font-weight:bold">success</tt> property, and
 * a <tt style="font-weight:bold">data</tt> property. The <tt style="font-weight:bold">data</tt> property
 * contains the values of Fields to load. The individual value object for each Field
 * is passed to the Field's {@link L5.form.Field#setValue setValue} method.</p>
 * <p>By default, response packets are assumed to be JSON, so a typical response
 * packet may look like this:</p><pre><code>
{
    success: true,
    data: {
        clientName: "Fred. Olsen Lines",
        portOfLoading: "FXT",
        portOfDischarge: "OSL"
    }
}</code></pre>
 * <p>Other data may be placed into the response for processing the {@link L5.form.BasicForm Form}'s callback
 * or event handler methods. The object decoded from this JSON is available in the {@link #result} property.</p>
 */
L5.form.Action.Load = function(form, options){
    L5.form.Action.Load.superclass.constructor.call(this, form, options);
    this.reader = this.form.reader;
};

L5.extend(L5.form.Action.Load, L5.form.Action, {
    // private
    type : 'load',

    // private
    run : function(){
        L5.Ajax.request(L5.apply(
                this.createCallback(this.options), {
                    method:this.getMethod(),
                    url:this.getUrl(false),
                    headers: this.options.headers,
                    params:this.getParams()
        }));
    },

    // private
    success : function(response){
        var result = this.processResponse(response);
        if(result === true || !result.success || !result.data){
            this.failureType = L5.form.Action.LOAD_FAILURE;
            this.form.afterAction(this, false);
            return;
        }
        this.form.clearInvalid();
        this.form.setValues(result.data);
        this.form.afterAction(this, true);
    },

    // private
    handleResponse : function(response){
        if(this.form.reader){
            var rs = this.form.reader.read(response);
            var data = rs.records && rs.records[0] ? rs.records[0].data : null;
            return {
                success : rs.success,
                data : data
            };
        }
        return L5.decode(response.responseText);
    }
});

L5.form.Action.ACTION_TYPES = {
    'load' : L5.form.Action.Load,
    'submit' : L5.form.Action.Submit
};
