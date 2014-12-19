/**
 * L5.model.DataProxy的实现类，load方法调用时，直接通过构造函数给Reader指定数据。
 * @class L5.model.MemoryProxy
 * @extends L5.model.DataProxy
 * @constructor
 * @param {Object} data 给Reader的构造L5.model.Record对象的数据对象
 */
L5.model.MemoryProxy = function(data){
    L5.model.MemoryProxy.superclass.constructor.call(this);
    this.data = data;
};

L5.extend(L5.model.MemoryProxy, L5.model.DataProxy, {
    /**
	 * @event loadexception
	 * 加载数据时，Proxy出现异常时触发，也可以直接在Dataset中监听。
	 * @param {Object} this 当前对象
	 * @param {Object} arg callback的arg对象，传给load函数
	 * @param {Object} null 在MemoryProxy中这个参数用不到，值为null
	 * @param {Error} e 如果reader不能读取数据，捕捉到的JavaScript Error对象
	 */
	
    /**
	 * 加载数据，请求源是缓存中的数据对象，传给构造器，将数据组织为Record对象，传入的callback函数处理数据
	 * @method load
	 * @param {Object} params MemoryProxy用不到这个参数
	 * @param {L5.model.DataReader} reader reader对象，将数据对象转换为L5.model.Record
	 * @param {Function}
	 *            callback 传入L5.model.record的函数，必须传入这个函数。函数的参数有：
	 *            <ul>
	 *            <li>record对象</li>
	 *            <li>load函数中的arg参数</li>
	 *            <li>布尔类型的success指示器</li>
	 *            </ul>
	 * @param {Object} scope callback的作用域
	 * @param {Object} arg (可选)传给callback的第二个参数
	 */
    load : function(params, reader, callback, scope, arg){
        params = params || {};
        var result;
        try {
            result = reader.readRecords(this.data);
        }catch(e){
            this.fireEvent("loadexception", this, arg, null, e);
            callback.call(scope, null, arg, false);
            return;
        }
        callback.call(scope, result, arg, true);
    },
    
    /**
     * 修改Record对象
     * @method update
     * @private
	 * @param {Object} params 请求参数对象
	 * @param {Object} records Record对象
     */
    update : function(params, records){
        
    }
});