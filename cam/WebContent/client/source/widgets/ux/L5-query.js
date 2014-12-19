/**
 * 查询窗口，查询域可以是文本、下拉框和日期。
 * 文本定义：var namecfg = {name:"NAME",desc:"名称",type:"text",operator:"like"};
 * 下拉框：var factcfg = {name:"FACT_ID",desc:"厂家",type:"combox",operator:"=",dataset:"factDataset",key:"id",label:"name"};
 * 日期：var datecfg={name:"BIRTHDAY",desc:"出生日期",type:"date",operator:"=@Date",format:"Y-m-d"}; 
 * 几个属性的含义：name：对应数据库字段的名称；desc：对域的描述；type：类型，当前的类型就是text、combox、date。operator：操作符；dataset：数据集，用于下拉框的情况。
 * key：下拉框的key；label：下拉框的显示值；format：日期域的格式。
 * 定义窗口：
 * 		var config = {dataset:"custDataset",title:"查询客户信息",conditions:[namecfg,factcfg,datecfg]};
 * 		win=new L5.QueryWindow(config);
 * 		win.show();
 * @class L5.QueryWindow
 * @extends L5.Window
 * @constructor
 * 创建查询窗口
 * @param config
 */

L5.QueryWindow = function(config) {
	this.data = [];
	this.params = [];
	this.width = 300;
	this.height = 150 + config.conditions.length * 20;
	this.title = "查询窗口";
	if (config) {
		this.config = config;
		if (this.config.title)
			this.title = this.config.title;
		if (this.config.width)
			this.width = this.config.width;
		if (this.config.height)
			this.height = this.config.height;
		if (this.config.dataset)
			this.dataset = L5.DatasetMgr.lookup(this.config.dataset);
		if (this.config.conditions)
			this.data = eval(this.config.conditions);
	}

	this.renderTo = document.body;

	this.resizable = true;
	this.layout = 'fit';
	this.closeAction = 'hide';
	this.plain = true;

	this.htmls = "<form onsubmit='return false'><fieldset><legend>请在下面输入查询条件</legend>";
	this.getFormContent();
	this.items = new L5.Panel({
				html : this.htmls
			});
	this.buttons = [{
				text : '查询',				
				handler : this.query.createDelegate(this)
			}, {
				text : '关闭',
				handler : this.exit.createDelegate(this)
			}];
	this.keys = [{
				key : L5.EventObject.ENTER,
				fn : this.query.createDelegate(this)
			}];
			
	L5.QueryWindow.superclass.constructor.call(this);

};

L5.extend(L5.QueryWindow, L5.Window, {
	obj : null,
	/**
	 * 添加文本域
	 */
	addTextField : function(name, desc,operator) {
		this.htmls += "<label>" + desc + ":</label>";
		this.htmls += "<input type=\"text\" id=\"" + name + "\"/><br>";
		obj = new Object();
		obj.name = name;
		obj.operator = operator;
		this.params[this.params.length] = obj;
	},
	
	/**
	 * 添加日期
	 */
	addDateField : function(name, desc,operator,format) {
		// Todo:<input type="text" id="createTime" format="Y-m-d" />
		this.htmls += "<label>" + desc + ":</label>";
		this.htmls +="<input id='"+name+"' type='text' format='"+format+"' onclick='LoushangDate(this)'/><br>";
		obj = new Object();
		obj.name = name;
		obj.operator = operator;
		this.params[this.params.length] = obj;
	},
	
	/**
	 * 添加下拉框
	 */
	addComboField : function(name, desc,operator,dataset,key,label) {
		this.htmls += "<label>" + desc + ":</label>";
		this.htmls += "<select id=\"" + name + "\" >";
		this.htmls += "<option value=\"\">请选择</option>";
		//如何绑定？
		// Todo：如果是数组

		// 如果dataset
		
		var dataset = L5.DatasetMgr.lookup(dataset);
		var options = "";
		dataset.each(function(record, index) {
				options += "<option value=\""
						+ record.get(key) + "\">"
						+ record.get(label) + "</option>";
			});		
		this.htmls += options;
		this.htmls += "</select><br>";		
		obj = new Object();
		obj.name = name;
		obj.operator = operator;
		this.params[this.params.length] = obj;
	},

	/**
	 * 组装查询域
	 */
	getFormContent : function() {
		if (this.data) {
			var arr = this.data;
			for (var i = 0; i < arr.length; i++) {
				switch (arr[i].type) {
					case null :
					case '' :
					case undefined :
					case 'text' :
						this.addTextField(arr[i].name, arr[i].desc,arr[i].operator);
						break;
					case 'date' :
						this.addDateField(arr[i].name, arr[i].desc,arr[i].operator,arr[i].format);
						break;
					case 'combox' :
						this.addComboField(arr[i].name, arr[i].desc,arr[i].operator,
								arr[i].dataset,arr[i].key,arr[i].label);
						break;
				}
			}
		}
		this.htmls += "</fieldset></form>";
	},

	/**
	 * 组装查询条件
	 */
	setBaseParams : function() {
		var fieldValue;	
		for (var i = 0; i < this.params.length; i++) {
			fieldValue = L5.fly(this.params[i].name).getValue();		
			if (fieldValue != ""){
				this.dataset.setParameter(this.params[i].name + "@" + this.params[i].operator, fieldValue);
			}
		}		
	},
	
	/**
	 * 查询
	 */
	query : function(evt) {
		this.setBaseParams();
		this.dataset.load();
	},
	
	/**
	 * 关闭查询窗口
	 */
	exit : function() {
		this.hide();
	}

});
