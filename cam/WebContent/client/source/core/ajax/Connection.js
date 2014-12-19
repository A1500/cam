/** 
 * <p>这个类封装了到页面所在主机的连接，允许通过一个配置好的URL来请求数据，也可以临时在请求时传递一个URL。</p>
 * <p>通过这个类获得的请求都是异步的，并且马上返回，调用request后，它并不马上返回数据，要处理数据，要在调用request时传入的 options对象中，
 * 配置callback或者是success、failure。这三个是回调函数。其区别将在下文具体交待。当然，你也可以使用 Connection的事件处理来做一些事情。</p>
 * <p>注意：如果你是要上传文件，你的回调、事件处理函数将不会获得通常意义上的response对象。上传通过IFrame来捕获，所以就没有 XMLHttpRequest了。
 * 这时，response还是被创建，不过，它的responseText等于IFrame的 document.innerHTML，responseXML等于IFrame的document中的xml数据。
 * 当然，这个前提是它们存在的时候。这意味着必面回一个合法的XML或HTML document。如果返回的是JSON数据，那么建议你把数据放到<textarea>
 * 标记中，返回时通过正则表达式从 responseText中取出来了。如果返回的是XML数据，建议放到CDATA里面，通过标准DOM方法从responseXMl中取得数据。</p>
 * @class L5.model.Connection
 * @extends L5.util.Observable
 * @param {Object} config 配置参数
 */
L5.model.Connection = function(config){
    L5.apply(this, config);
    this.addEvents(
        /**
         * 在请求发生之前触发
         * @event beforerequest
         * @param {Connection} conn Connection对象
         * @param {Object} options 传给request方法的配置参数
         */
        "beforerequest",
        /**
         * 请求结束时触发
         * @event requestcomplete
         * @param {Connection} conn Connection对象
         * @param {Object} response XMLHttpRequest对象，包含响应数据
         * @param {Object} options 传给request方法的配置参数
         */
        "requestcomplete",
        /**
         * 当http请求处于错误状态时触发
         * @event requestexception
         * @param {Connection} conn Connection对象
         * @param {Object} response XMLHttpRequest对象，包含响应数据
         * @param {Object} options 传给request方法的配置参数
         */
        "requestexception"
    );
    L5.model.Connection.superclass.constructor.call(this);
};

L5.extend(L5.model.Connection, L5.util.Observable, {
    /**
     * @cfg {String} url (可选)发送请求执行的url(默认值undefined)
     */
	
    /**
     * @cfg {Object} extraParams (可选) 一般情况下，加在encodeURL(params)后面。(默认值undefined)
     */
	
    /**
     * @cfg {Object} defaultHeaders (可选) 默认头部，头部包含了请求的一些基本属性，此对象定义了用当前connection对象发起的请求的默认头部(默认值undefined)
     */
	
    /**
     * @cfg {String} method (可选) 就是http请求的method属性。默认情况下是未定义的(undefined)；如果没有设置，但是调用request时设了params，那么将使用POST方式，否则使用GET。
     */
	
    /**
     * @cfg {Number} timeout (可选) 请求的超时时间，单位毫秒(默认30秒)
     */
    timeout : 30000,
    /**
     * @cfg {Boolean} autoAbort (可选) 是否取消所有的待处理的请求(默认值false)
     * @type Boolean
     */
    autoAbort:false,

    /**
     * @cfg {Boolean} disableCaching (可选) 如果是true的话，添加一个唯一的缓存标识到GET请求(默认值true)
     * @type Boolean
     */
    disableCaching: true,
    
    /**
     * @cfg {String} disableCachingParam (可选) 使缓存失效的参数，默认值'_dc'
     * @type String
     */
    disableCachingParam: '_dc',
    

    /**
     * <p>发送一个HTTP请求到远程主机上。Ajax服务请求都是异步的，并且这个请求将在response(响应)返回之前返回，也就是说，你绝对无法通过此函数来直接返回数据，你得通过定义回调函数来处理返回的数据。</p>
     * @method request
     * @private
     * @param {Object} o 一个可能包含下面属性的对象:
     * <ul>
     * <li><b>url</b> : String/Function (可选)<div>请求对应的URL，默认值是connection的options配置的那个url。</div></li>
     * <li><b>params</b> : Object/String/Function (可选)<div>用于提供url后面的请求参数(俗称查询字符串)，可以是json对象，可以是直接的字符串，可以是一个函数。</div></li>
     * <li><b>method</b> : String (可选)<div>此http请求的method。默认值为connection的options中配置的method。
     * 如果没有设置它，那么就要看params是否设了，如果设了就以POST方式请求，如果没有就以GET方式请求。
     * 注意：method名是大小敏感的，必须全部大写。</div></li>
     * <li><b>callback</b> : Function (可选)<div>无论请求成功还是失败它都被执行。可能包含以下几个参数：<ul>
     * <li><b>options</b> : Object<div>request的参数</div></li>
     * <li><b>success</b> : Boolean<div>是否请求成功了</div></li>
     * <li><b>response</b> : Object<div>包含响应数据的XMLHttpRequest对象</div></li>
     * </ul></div></li>
     * <li><b>success</b> : Function (可选)<div>请求成功时执行的回调。它的参数：<ul>
     * <li><b>response</b> : Object<div>包含响应数据的XMLHttpRequest对象</div></li>
     * <li><b>options</b> : Object<div>request的参数</div></li>
     * </ul></div></li>
     * <li><b>failure</b> : Function (可选)<div>请求失败时执行的回调。它的参数：<ul>
     * <li><b>response</b> : Object<div>包含响应数据的XMLHttpRequest对象</div></li>
     * <li><b>options</b> : Object<div>request的参数</div></li>
     * </ul></div></li>
     * <li><b>scope</b> : Object (可选)<div>回调函数执行时的作用域</div></li>
     * <li><b>form</b> : Element/HTMLElement/String (可选)<div>将用于构造查询字符串的form的引用或id。</div></li>
     * <li><b>isUpload</b> : Boolean (可选)<div><b>当前请求是否是在上传文件(通常是自动检测的)。form的属性enctype值为"multipart/form-data"</b>
     * <p>文件上传不是通过通常的Ajax技术实现，它们通过在form提交时动态插入一个iframe，返回时又移除这个iframe来实现。如果返回结果是json，那么头部要设一下content-type:text/html。</p>
     * </div></li>
     * <li><b>headers</b> : Object (可选)<div>请求的头部</div></li>
     * <li><b>xmlData</b> : Object (可选)<div>提交的XML数据，如果是POST，使用该参数，而不是params。params参数会添加到URL后面。</div></li>
     * <li><b>jsonData</b> : Object/String (可选)<div>提交的JSON数据，如果是POST，使用该参数，而不是params。params参数会添加到URL后面。</div></li>
     * <li><b>disableCaching</b> : Boolean (可选)<div>为true时为Get请求创建一个param缓存。</div></li>
     * </ul></p>
     * <p>这个options对象也可以包含其他你需要用于回调的属性。</p>
     * @return {Number} transactionId，一个请求的id，它用于取消请求
     */
    request : function(o){
        if(this.fireEvent("beforerequest", this, o) !== false){
            var p = o.params;

            if(typeof p == "function"){
                p = p.call(o.scope||window, o);
            }
            if(typeof p == "object"){
                p = L5.urlEncode(p);
            }
            if(this.extraParams){
                var extras = L5.urlEncode(this.extraParams);
                p = p ? (p + '&' + extras) : extras;
            }

            var url = o.url || this.url;
            if(typeof url == 'function'){
                url = url.call(o.scope||window, o);
            }

            if(o.form){
                var form = L5.getDom(o.form);
                url = url || form.action;

                var enctype = form.getAttribute("enctype");
                if(o.isUpload || (enctype && enctype.toLowerCase() == 'multipart/form-data')){
                    return this.doFormUpload(o, p, url);
                }
                var f = L5.lib.Ajax.serializeForm(form);
                p = p ? (p + '&' + f) : f;
            }
            var hs = o.headers;
            if(this.defaultHeaders){
                hs = L5.apply(hs || {}, this.defaultHeaders);
                if(!o.headers){
                    o.headers = hs;
                }
            }

            var cb = {
                success: this.handleResponse,
                failure: this.handleFailure,
                scope: this,
                argument: {options: o},
                timeout : o.timeout || this.timeout
            };

            var method = o.method||this.method||((p || o.xmlData || o.jsonData) ? "POST" : "GET");

            if(method == 'GET' && (this.disableCaching && o.disableCaching !== false) || o.disableCaching === true){
                var dcp = o.disableCachingParam || this.disableCachingParam;
                url += (url.indexOf('?') != -1 ? '&' : '?') + dcp + '=' + (new Date().getTime());
            }

            if(typeof o.autoAbort == 'boolean'){ // options gets top priority
                if(o.autoAbort){
                    this.abort();
                }
            }else if(this.autoAbort !== false){
                this.abort();
            }
            if((method == 'GET' || o.xmlData || o.jsonData) && p){
                url += (url.indexOf('?') != -1 ? '&' : '?') + p;
                p = '';
            }
            this.transId = L5.lib.Ajax.request(method, url, cb, p, o);
            return this.transId;
        }else{
            L5.callback(o.callback, o.scope, [o, null, null]);
            return null;
        }
    },

    /**
     * 判断对象是否有未处理的请求
     * @method isLoading
     * @param {Number} transactionId (可选) 默认最后一次通信
     * @return {Boolean} 如果有请求是true
     */
    isLoading : function(transId){
        if(transId){
            return L5.lib.Ajax.isCallInProgress(transId);
        }else{
            return this.transId ? true : false;
        }
    },

    /**
     * 取消所有未处理的请求
     * @method abort
     * @param {Number} transactionId (可选)默认最后一次通信
     */
    abort : function(transId){
        if(transId || this.isLoading()){
            L5.lib.Ajax.abort(transId || this.transId);
        }
    },

    /**
     * 处理响应对象
     * @method handleResponse
     * @private
     * @param {Object} response 响应对象
     */
    handleResponse : function(response){
        this.transId = false;
        var options = response.argument.options;
        response.argument = options ? options.argument : null;
        this.fireEvent("requestcomplete", this, response, options);
        L5.callback(options.success, options.scope, [response, options]);
        L5.callback(options.callback, options.scope, [options, true, response]);
    },

    /**
     * 处理响应失败信息
     * @method handleFailure
     * @private
     * @param {Object} response 响应对象
     * @param {Object} e 响应异常对象
     */
    handleFailure : function(response, e){
        this.transId = false;
        var options = response.argument.options;
        response.argument = options ? options.argument : null;
        this.fireEvent("requestexception", this, response, options, e);
        L5.callback(options.failure, options.scope, [response, options]);
        L5.callback(options.callback, options.scope, [options, false, response]);
    },

    /**
     * 处理文件上传
     * @method doFormUpload
     * @private
     * @param {Object} o 请求对象
     * @param {Object} ps 参数对象
     * @param {Object} url 文件上传路径
     */
    doFormUpload : function(o, ps, url){
        var id = L5.id();
        var frame = document.createElement('iframe');
        frame.id = id;
        frame.name = id;
        frame.className = 'l-hidden';
        if(L5.isIE){
            frame.src = L5.SSL_SECURE_URL;
        }
        document.body.appendChild(frame);

        if(L5.isIE){
           document.frames[id].name = id;
        }
        var form = L5.getDom(o.form);
        form.target = id;
        form.method = 'POST';
        form.enctype = form.encoding = 'multipart/form-data';
        if(url){
            form.action = url;
        }

        var hiddens, hd;
        if(ps||o.jsonData){ //增加动态参数
            hiddens = [];
            ps = L5.urlDecode(ps, false);
            for(var k in ps){
                if(ps.hasOwnProperty(k)){
                    hd = document.createElement('input');
                    hd.type = 'hidden';
                    hd.name = k;
                    hd.value = ps[k];
                    form.appendChild(hd);
                    hiddens.push(hd);
                }
            }
            hd = document.createElement('input');
            hd.type = 'hidden';
            hd.name = 'jsonData';
            hd.value =o.jsonData;
            form.appendChild(hd);
            hiddens.push(hd);
        }

        function cb(){
        	//初始化响应对象
            var r = {
                responseText : '',
                responseXML : null
            };

            r.argument = o ? o.argument : null;

            try { 
                var doc;
                if(L5.isIE){
                    doc = frame.contentWindow.document;
                }else {
                    doc = (frame.contentDocument || window.frames[id].document);
                }
                if(doc && doc.body){
                	if(doc.body.textContent)
                		r.responseText=doc.body.textContent;
                	if(doc.body.innerText)
                		r.responseText = doc.body.innerText;
                }
                if(doc && doc.XMLDocument){
                    r.responseXML = doc.XMLDocument;
                }else {
                    r.responseXML = doc;
                }
            }
            catch(e) {
                // ignore
            }

            L5.EventManager.removeListener(frame, 'load', cb, this);

            this.fireEvent("requestcomplete", this, r, o);

            L5.callback(o.success, o.scope, [r, o]);
            L5.callback(o.callback, o.scope, [o, true, r]);

            setTimeout(function(){L5.removeNode(frame);}, 100);
        }

        L5.EventManager.on(frame, 'load', cb, this);
        form.submit();

        if(hiddens){ // remove dynamic params
            for(var i = 0, len = hiddens.length; i < len; i++){
                L5.removeNode(hiddens[i]);
            }
        }
    }
});

/**
 * Ajax请求类，单例，不需要用new创建实例，可以直接调用。给用户提供了一种简单的ajax请求方式。 
 * 使用方法：
 * <pre><code>
	// 基本请求
	L5.Ajax.request({
	   url: 'foo.jsp',
	   success: someFn,
	   failure: otherFn,
	   headers: {
	       'my-header': 'foo'
	   },
	   params: { foo: 'bar' }
	});
	
	// 简单的ajax form提交
	L5.Ajax.request({
	    form: 'some-form',
	    params: 'foo=bar'
	});
	
	// 每次发送请求时默认的请求头
	L5.Ajax.defaultHeaders = {
	    'Powered-By': 'L5'
	};
	
	// 全局的ajax事件，每次请求都要处理。
	L5.Ajax.on('beforerequest', this.showSpinner, this);
	</code></pre>
 * @class L5.Ajax
 * @extends L5.model.Connection
 */
L5.Ajax = new L5.model.Connection({
    /**
     * @cfg {String} url 要访问的后台网址
     */
	
    /**
     * @cfg {Object} extraParams (可选)
     * @private
     */
	
    /**
     * @cfg {Object} defaultHeaders (可选)
     * @private
     */
	
    /**
     * @cfg {String} method (可选)
     * @private
     */
	
    /**
     * @cfg {Number} timeout (可选)
     * @private
     */
	
    /**
     * @cfg {Boolean} autoAbort (可选)
     * @private
     */

    /**
     * @cfg {Boolean} disableCaching (可选)
     * @private
     */

    /**
     * 如果是true的话，添加一个唯一的缓存标识到GET请求(默认值true)
     * @property disableCaching
     * @type Boolean
     */
	
    /**
     * 默认的请求URL(默认值undefined)
     * @property url
     * @type String
     */
	
    /**
     * 传递其它参数的对象(默认值undefined)
     * @property extraParams
     * @type Object
     */
	
    /**
     * 默认的请求头对象(默认值undefined)
     * @property defaultHeaders
     * @type Object
     */
	
    /**
     * 发送请求的默认HTTP方法。大小写敏感，必须要大写。(默认是undefined，如果没有设置但是参数是"POST"或者"GET")
     * @property method
     * @type String
     */
	
    /**
     * 请求的超时时间，单位毫秒(默认30秒)
     * @property timeout
     * @type Number
     */

    /**
     * 新的请求是否要取消任意的待定请求，默认是false
     * @property autoAbort
     * @type Boolean
     */
    autoAbort : false,

    /**
     * 序列化form
     * @param {String/HTMLElement} form 表单
     * @return {String} 序列化表单
     */
    serializeForm : function(form){
        return L5.lib.Ajax.serializeForm(form);
    }
});