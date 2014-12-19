/**
 * L5.model.DataProxy的实现类，从L5.model.Connection对象配置URL读取数据对象。这个类不能读取跨域的应用。
 * 如果想让浏览器能够解析XML文档，服务器端必须设置HTTP响应的Content-Type头为"text/xml"
 * @class L5.model.HttpProxy
 * @extends L5.model.DataProxy
 * @constructor
 * @param {Object} conn L5.model.Connection对象，或者是L5.Ajax的request方法的参数，如果传递了参数，单例的L5.Ajax对象会发出请求。 
 */
L5.model.HttpProxy = function(conn){
    L5.model.HttpProxy.superclass.constructor.call(this);
    /**
     * 发送HTTP请求的对象，为了变换请求的数据，对象的属性是动态变化的。
     * @property conn
     */
    this.conn = conn;
    this.useAjax = !conn || !conn.events;

    /**
     * @event loadexception
     * 加载数据时Proxy有异常时触发。引起该事件可能有两个原因： 
     * <ul><li><b>load返回success：false。</b>  这意味着服务端返回失败的状态，没有数据可读。这种情况下会触发事件并且第四个参数(error)是null</li>
     * <li><b>load成功但是reader不能获得响应。</b>这意味着服务端返回了数据，但是配置的reader在读取数据时出现错误。
     * 这种情况下会触发事件，并把错误信息放在第四个参数error中抛出。</li></ul>
     * 事件可以直接通过Dataset实例监听。
     * @param {Object} this 当前对象
     * @param {Object} options load选项参数
     * @param {Object} response 包含响应数据的XMLHttpRequest对象
     * @param {Error} e 如果配置的Reader不能读取数据产生的JavaScript Error对象，如果load返回false，值为null
     */
};

L5.extend(L5.model.HttpProxy, L5.model.DataProxy, {
    /**
     * 返回Proxy的L5.model.Connection对象
     * @method getConnection
     * @return {Connection} Connection对象
     */
    getConnection : function(){
        return this.useAjax ? L5.Ajax : this.conn;
    },

    /**
     * 从配置的Connection对象加载数据，通过传入的DataReader实现类读取Record对象并把它传给callback函数
     * @method load
     * @param {Object} params 定义请求远程服务器的HTTP参数
     * @param {L5.model.DataReader} reader 转换数据的reader
     * @param {Function} callback 回调函数，必须传入
     * <ul>
     * <li>record块对象</li>
     * <li>load函数的arg参数</li>
     * <li>boolean类型的是否成功标记</li>
     * </ul>
     * @param {Object} scope 回调函数的作用域
     * @param {Object} arg 可选参数，传给callback的第二个参数
     */
    load : function(params, reader, callback, scope, arg){
        if(this.fireEvent("beforeload", this, params) !== false){
            var  o = {
                params : params || {},
                request: {
                    callback : callback,
                    scope : scope,
                    arg : arg
                },
                reader: reader,
                callback : this.loadResponse,
                scope: this
            };
            if(params.sync){
            	o.sync=true;
            }
            if(this.useAjax){
                L5.applyIf(o, this.conn);
                if(this.activeRequest){
                    L5.Ajax.abort(this.activeRequest);
                }
                this.activeRequest = L5.Ajax.request(o);
            }else{
                this.conn.request(o);
            }
        }else{
            callback.call(scope||this, null, arg, false);
        }
    },

    /**
     * 读取信息创建dataset记录集
     * @method loadResponse
     * @param {Object} o          请求参数对象
     * @param {Boolean} success   加载数据是否成功
     * @param {Object} response   包含数据信息的对象
     */
    loadResponse : function(o, success, response){
        delete this.activeRequest;
        if(!success){
            this.fireEvent("loadexception", this, o, response);
            o.request.callback.call(o.request.scope, null, o.request.arg, false);
            return;
        }
        var result;
        try {
            result = o.reader.read(response);
        }catch(e){
            this.fireEvent("loadexception", this, o, response, e);
            o.request.callback.call(o.request.scope, null, o.request.arg, false);
            return;
        }
        this.fireEvent("load", this, o, o.request.arg);
        o.request.callback.call(o.request.scope, result, o.request.arg, true);
    },
    
    /**
     * 修改dataset记录集
     * @method update
     * @private
     * @param {L5.model.Dataset} dataSet     记录集对象
     */
    update : function(dataSet){
        
    },
    
    /**
     * 修改dataset记录集
     * @method updateResponse
     * @private
     * @param {L5.model.Dataset} dataSet     记录集对象
     */
    updateResponse : function(dataSet){
        
    }
});