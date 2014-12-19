/**
 * 提供获取未格式化的数据对象的抽象基类，DataProxy的实现通常和L5.model.DataReader的实现类
 * 配合使用，以获得构造Dataset对象的Record数据集合。实现类必须实现L5.model.HttpProxy中的
 * load方法。
 * @class L5.model.DataProxy
 * @extends L5.util.Observable
 */
L5.model.DataProxy = function(){
    this.addEvents(
        /**
         * 发送网络请求获取数据对象时触发
         * @event beforeload
         * @param {Object} this
         * @param {Object} params 传给load函数的参数
         */
        'beforeload',
        /**
         * 在load方法的callback调用之前触发
         * @event load
         * @param {Object} this
         * @param {Object} o 数据对象
         * @param {Object} arg 传给load函数的callback的arg对象
         */
        'load'
    );
    L5.model.DataProxy.superclass.constructor.call(this);
};

L5.extend(L5.model.DataProxy, L5.util.Observable);