
/**
 * 组装查询区域的HTML，以及设置查询条件参数
 * 
 * 使用注意
 * 在调用add方法如addTextField时，name的值格式必须为“表名.字段”的形式，
 * 此外，使用通用帮助的快捷方式声明查询条件名称，要add方法声明的名称大小写完全一致，
 * 
 */
L5.SearchArea=function(config){
	this.count=0;
	this.htmls = "";
	this.params=new Array();
	this.dataset;
	this.data;
	this.help;//查询区所关联的通用帮助HelpWindow
	L5.apply(this, config);
};

/**
 * 添加文本域
 */
L5.SearchArea.prototype.addTextField = function(name, desc,sqlName) {
	this.count++;
	
	this.htmls += "<td><label>" + desc + ":</label></td>";
	this.htmls += "<td><input type=\"text\" id=\"" + name + "\" /></td>";
	this.setLayOut();
	if(typeof sqlName== 'undefined'||sqlName==null){
		sqlName=name;
	}
	this.setParameter(name,sqlName);
};
/**
 * 通过添加<tr>控制查询元素的布局
 */
L5.SearchArea.prototype.setLayOut=function(){
	if(this.count!=1){
		if(this.count%2==1){
			this.htmls +="<tr>"
		}else{
			this.htmls +="</tr><tr>";
			this.count=0;
		}
	}
}

/**
 * 添加日期
 */
L5.SearchArea.prototype.addDateField = function(name, desc,config,sqlName) {
	// Todo:
	this.htmls += "<td><label>" + desc + ":</label></td>";
	this.htmls +="<td><input id='"+name+"' type='text' onclick='LoushangDate("+config+",this)'></td>";
	this.setLayOut();
	if(typeof sqlName== 'undefined'||sqlName==null){
		sqlName=name;
	}
	this.setParameter(name,sqlName);
};

/**
 * 添加下拉框
 */
L5.SearchArea.prototype.addComboField = function(name, desc, ds,sqlName) {
	this.htmls += "<td><label>" + desc + ":</label></td>";
	this.htmls += "<td><select id=\"" + name + "\" >";
	var options = "<option dataset=\"" + ds + "\">" + "</option>";
	this.htmls += options;
	this.htmls += "</select></td>";	
	this.setLayOut();
	if(typeof sqlName== 'undefined'||sqlName==null){
		sqlName=name;
	}
	this.setParameter(name,sqlName);
};

/**
 * 方便用户自己组织查询HTML，并调用该方法设置查询参数
 */
L5.SearchArea.prototype.setParameter=function(name,sqlName){
	var obj=new Object();
	obj.name=name;
	obj.sqlName=sqlName;
	this.params[this.params.length] = obj;
}

/**
 * 组装查询域
 */
L5.SearchArea.prototype.getFormContent = function() {
	if (this.data) {
		var arr = this.data;
		for (var i = 0; i < arr.length; i++) {
			switch (arr[i].type) {
				case null :
				case '' :
				case undefined :
				case 'text' :
					this.addTextField(arr[i].name, arr[i].desc);
					break;
				case 'date' :
					this.addDateField(arr[i].name, arr[i].desc,arr[i].cfg);
					break;
				case 'combox' :
					this.addComboField(arr[i].name, arr[i].desc,
							arr[i].data);
					break;
			}
		}
	}
};

/**
 * 组装查询条件
 */
L5.SearchArea.prototype.setBaseParams = function() {
	var fieldValue;
	for (var i = 0; i < this.params.length; i++) {
		fieldValue = L5.fly(this.params[i].name).getValue();
		if (fieldValue != ""){
			this.dataset.baseParams[this.params[i].sqlName] = fieldValue;
		}
		else
			this.dataset.baseParams[this.params[i].sqlName] = undefined;
	}
};

/**
 * 查询
 */
L5.SearchArea.prototype.search = function() {
	this.setBaseParams();
	this.dataset.load();
};

/**
 * 未弹出帮助框之前进行查询
 */
L5.SearchArea.prototype.bgSearch = function(condition) {
	if(condition){
		this.dataset.baseParams[condition.name]=condition.value;
		this.dataset.load({callback:respondSearch,help:this.help,search:condition});
	}
}

/**
 * 响应通用帮助的快速查询功能 直接回填数据或弹出帮助窗口重新选择记录
 */
function respondSearch(records,options,success){
	if(success){
		var length=records.length;
		if(length==1){
			options.help.returns=records[0];
			options.help.isClear=false;
			//标识数据已脏，下次show时需重新加载数据
			options.help._dirty=true;
			/**
			 * (开发人员需要重写该函数，为某个域赋值)
			 */
			if(options.help.afterExecute){
				options.help.afterExecute();
			}			
			
		}else{
			//不用再进行load数据
			options.help.show(null,null,null,true);
			//设置通用帮助的查询框的查询条件，
			var condition=options.search;
			L5.fly(condition.name).dom.value=condition.value;
		}
	}
};

/**
 * 清除查询输入框的中的值
 */
L5.SearchArea.prototype.clearSearchValue=function(){
	for (var i = 0; i < this.params.length; i++) {
		L5.fly(this.params[i].name).dom.value="";
		this.dataset.baseParams[this.params[i].name] = undefined;
	}
};
L5.SearchArea.prototype.getHtmls=function(){
	return "<form onsubmit='return false'><table><tr>"+this.htmls+"</tr></table></form>";
}