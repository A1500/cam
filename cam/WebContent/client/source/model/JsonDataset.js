/**
 * 读取远程的JSON格式的数据构造Dataset对象，需要由L5.model.HttpProxy和L5.model.JsonReader配合使用。
	<pre><code>
	var dataset = new L5.model.JsonDataset({
	    url: 'jsp/getData.jsp',
	    root: 'images',
	    fields: ['name', 'url', {name:'size', type: 'float'}, {name:'lastmod', type:'date'}]
	});
	</code></pre>
  * 返回的数据格式：
	<pre><code>
	{
	    images: [
	        {name: 'Image one', url:'/GetImage.php?id=1', size:46.5, lastmod: new Date(2007, 10, 29)},
	        {name: 'Image Two', url:'/GetImage.php?id=2', size:43.2, lastmod: new Date(2007, 10, 30)}
	    ]
	}
	</code></pre>
 * @class L5.model.JsonDataset
 * @extends L5.model.Dataset
 * @constructor
 * 创建JsonDataset对象
 * @cfg {String} url HttpProxy加载数据的来源
 * @cfg {Object} data JsonReader能够读取的数据对象
 * @cfg {Array} fields 包含域定义的数据
 * @param {Object} config 配置参数
 */
L5.model.JsonDataset = function(c){
    /**
     * @cfg {L5.model.DataReader} reader 解析器
     */
	
    /**
     * @cfg {L5.model.DataProxy} proxy 数据代理
     */
    L5.model.JsonDataset.superclass.constructor.call(this, L5.apply(c, {
        proxy: c.proxy || (!c.data ? new L5.model.HttpProxy({url: c.url}) : undefined),
        reader: new L5.model.JsonReader(c, c.fields)
    }));
};
L5.extend(L5.model.JsonDataset, L5.model.Dataset);