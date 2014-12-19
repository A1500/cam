/**
 * 从数据源读取结构化数据并把它转换为包含Record对象集合和元数据的对象的抽象基类。
 * 该类只能被继承，不能直接创建。当前的实现类可参考L5.model.ArrayReader、L5.model.JsonReader和
 * L5.model.XmlReader
 * @class L5.model.DataReader
 * @constructor
 * 创建DataReader对象
 * @param {Object} meta 配置参数的元数据
 * @param {Object} recordType 或者是L5.model.Record的create方法中指定的域定义对象数组，或者是用L5.model.Record的create方法创建的对象
 */
L5.model.DataReader = function(meta, recordType){
    /**
     * 传给构造器的DataReader的配置元数据
     * @property meta
     * @type Mixed
     */
    this.meta = meta;
    this.recordType = L5.isArray(recordType) ? 
        L5.model.Record.create(recordType) : recordType;
};

L5.model.DataReader.prototype = {
    
};