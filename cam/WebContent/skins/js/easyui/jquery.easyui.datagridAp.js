/**
 * easyui datagrid loader适配
 * @param param
 * @param success
 * @param error
 * @returns {Boolean}
 */
function dcLoader(param,success,error){
	var that = $(this);
	var opts = that.datagrid("options");
	if (!opts.url) {
		return false;
	}
	var cache = that.data().datagrid.cache;
	if (!cache) {
		var params="";
		if(opts.formId){
			params='dim:"'+opts.dim+'",'+getQueryContent(opts.formId);
		}else{
			params='dim:"'+opts.dim+'"';
		}
		$.inspur.jsonPostByParams(
				getProjectName()+opts.url,//项目根路径+方法url
				params, function(data) {
					that.data().datagrid['cache'] = data;
					success(bulidData(data));

		}, "json");
		
	} else {
		success(bulidData(cache));
	}

	function bulidData(data) {
		var temp = $.extend({},data);
		var tempRows = [];
		if(param.page&&param.rows){
			var start = (param.page - 1) * parseInt(param.rows);
			var end = start + parseInt(param.rows);
			var rows = data.rows;
			for (var i = start; i < end; i++) {
				if(rows[i]){
					tempRows.push(rows[i]);
				}else{
					break;
				}
			}
			temp.rows = tempRows;
		}else{
			var rows = data.rows;
			for (var i = 0; i < rows.length; i++) {
				if(rows[i]){
					tempRows.push(rows[i]);
				}else{
					break;
				}
			}
			temp.rows = tempRows;
		}
		
		return temp;
	}
}
