//doc
/**
 * @class L5.ComponentMgr
 * @singleton
 * 提供一个包含一个页面上所有组件的注册表，可以很方便的通过id获取注册过的组件（用id为key注册的）。
 * 此对象还提供一个可用组件的注册表，以助记码xtype为索引。当创建一个完整组件的时候，xtype提供了一种避免创建子组件实例的方式
 * 来实例化子组件，我们可以为一个L5页面直接嵌套一个配置对象就能实现子组件的实例化。
 * 一个子组件可以是一个简单的配置对象，只要提供正确的xtype我们就能创建并渲染。正确的xtype是实例化的依据。我们可以在L5.Component
 * 这个类里面查看所有可用的xtypes列表。
 */
 
L5.ComponentMgr = function(){
    var all = new L5.util.MixedCollection();
    var types = {};

    return {
        /**
         * 注册一个组件
         * @private
         * @param {L5.Component} c 被注册的组件
         */
        register : function(c){
            all.add(c);//L5.util.MixedCollection会去c的id作为key
        },

        /**
         * 注销一个组件.
         * @private
         * @param {L5.Component} c 被注销的组件
         */
        unregister : function(c){
            all.remove(c);
        },

        /**
         * 通过ID获取组件
         * @param {String} id 组件的ID
         * @return L5.Component 返回获取的组件
         */
        get : function(id){
            return all.get(id);
        },

        /**
         * 注册一个方法，当特定的组件（id与实现设定的id相同时候）被注册到ComponentMgr的时候触发方法，并且值触发一次。
         * @private
         * @param {String} id 特定的组件id
         * @param {Function} fn 当特定的组件被注册的时候触发的方法
         * @param {Object} scope 被触发方法的作用域
         */
        onAvailable : function(id, fn, scope){
            all.on("add", function(index, o){
                if(o.id == id){
                    fn.call(scope || o, o);
                    all.un("add", fn, scope);
                }
            });
        },

        /**
         * ComponentMgr内部使用的缓存（缓存被注册的组件实际上这是一个L5.util.MixedCollection的实例），我们可以通过监听
         * 这个缓存的事件判断组件的增加和移除。但是不建议修改这个缓存。
         * @private
         * @type {MixedCollection}
         */
        all : all,

        /**
         * 注册一个可用的组件的构造器。key值是xtype。用这个方法可以注册一个L5.Component的子类，
         * 当实例化指定的子组件的时候可以通过create方法实例化。
         * @private
         * @param {String} xtype 一个组件类的助记码
         * @param {Constructor} cls 组件类
         */
        registerType : function(xtype, cls){
            types[xtype] = cls;
            cls.xtype = xtype;
        },

        /**
         * 通过配置项和xtype创建一个新的组件实例
         * @private
         * @param {Object} config 一个配置对象，包含我们需要的组件的属性
         * @param {Constructor} defaultType 假如config里面没有提供xtype属性，我们就通过defaultType创建指定类型的组件
         * @return {L5.Component} 返回新的组件的实例
         */
        create : function(config, defaultType){
            return new types[config.xtype || defaultType](config);
        }
    };
}();

/**
 * L5.ComponentMgr.registerType的简写模式
 * @private
 * @param {String} xtype 一个组件类的助记码
 * @param {Constructor} cls 组件类
 * @member L5
 * @method reg
 */
L5.reg = L5.ComponentMgr.registerType;//为了减少字节下载量使用简称 