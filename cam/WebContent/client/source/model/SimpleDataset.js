/**
 * 根据数组数据构建Dataset
 * @class L5.model.SimpleDataset
 * @extends L5.model.Dataset
 * @cfg {Number} id record的id的数组索引，如果不设置可以自动生成
 * @cfg {Array} fields 定义域对象的数组，或者是在L5.model.Record的create方法中指定的域名称字符串
 * @cfg {Array} data 多维数组
 * @constructor
 * 构建SimpleDataset
 * @param {Object} config 配置参数
 */
L5.model.SimpleDataset = function(config){
    L5.model.SimpleDataset.superclass.constructor.call(this, L5.apply(config, {
        reader: new L5.model.ArrayReader({
                id: config.id
            },
            L5.model.Record.create(config.fields)
        )
    }));
};
L5.extend(L5.model.SimpleDataset, L5.model.Dataset, {
	/**
	 * 加载数据
	 *  @method loadData
	 *  @param {Object} data 读取Records的数据来源，数据格式取决于Reader的类型并且与Reader的readRecords参数一致
	 *  @param {Boolean} append (可选的) 如果是true，追加新的记录而不是覆盖现在的数据，否则会清空Dataset中的数据再增加
     * <b>需要注意的是，增加的Record的id必须是唯一的，否则会覆盖原来有相同id的Record对象</b>
	 */
    loadData : function(data, append){
        if(this.expandData === true){
            var r = [];
            for(var i = 0, len = data.length; i < len; i++){
                r[r.length] = [data[i]];
            }
            data = r;
        }
        L5.model.SimpleDataset.superclass.loadData.call(this, data, append);
    }
});