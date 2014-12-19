jQuery.inspur = {          
		jsonPost:function( url, data, callback, type ) {  
			// shift arguments if data argument was omitted
			if ( jQuery.isFunction( data ) ) {
				type = type || callback;
				callback = data;
				data = undefined;
			}
			url += url.match(/\?/) ? "&" : "?";
			url += "_dc="+new Date().getTime(); 
			return jQuery.ajax({
			    contentType:"application/json",
				type: "POST",
				url: url,
				data: data,
				success: callback,
				dataType: type
			});      
		},
		jsonPostByParams:function( url, jsonParams, callback, type ) {  
			var data = '{"params":{"javaClass":"org.loushang.next.data.ParameterSet","map":{'	+ jsonParams+ ',"start":0,"limit":10,"defaultSort":{"javaClass":"ArrayList","list":[]},"dir":"ASC"},"length":12},"context":{"javaClass":"HashMap","map":{},"length":0}}';
			// shift arguments if data argument was omitted
			if ( jQuery.isFunction( data ) ) {
				type = type || callback;
				callback = data;
				data = undefined;
			}
			url += url.match(/\?/) ? "&" : "?";
			url += "_dc="+new Date().getTime(); 
			return jQuery.ajax({
			    contentType:"application/json",
				type: "POST",
				url: url,
				data: data,
				success: callback,
				dataType: type
			});      
		} 
};  
//json串拼装
function getJsonParams(dim,formId) {
	var jsonParams = '{"params":{'
			+ '"javaClass":"org.loushang.next.data.ParameterSet",'
			+ '"map":{'
			+ '"dim":'+dim+','
			+ getQueryContent(formId)
			+ ',"start":0,"limit":10,"defaultSort":{"javaClass":"ArrayList","list":[]},"dir":"ASC"'
			+ '},' + '"length":12' + '},'
			+ '"context":{"javaClass":"HashMap","map":{},"length":0}}';
	return jsonParams;
}
//查询条件拼装--CONTENT
function getQueryContent(formId) {
	var _str = '';
	$.each($("#"+formId).find("[name]"),function(i,o){
				if($(o).attr('type')=="text"){
					if (_str == "") {
						_str+= '"'+$(o).attr("name")+'":"'+$(o).val()+'"';
					} else {
						_str+=',"' + $(o).attr("name")+'":"'+$(o).val()+'"';
					}
				}else if($(o).attr('type')=="select-one"){
					var selectText="";
					if($(o).find("option:selected").text()!='请选择'){
						selectText=$(o).find("option:selected").text();
					}
					if (_str == "") {
						_str+= '"'+$(o).attr("name")+'":"'+selectText+'"';
					} else {
						_str+=',"' + $(o).attr("name")+'":"'+selectText+'"';
					}
				}else{
					if (_str == "") {
						_str+= '"'+$(o).attr("name")+'":"'+$(o).val()+'"';
					} else {
						_str+=',"' + $(o).attr("name")+'":"'+$(o).val()+'"';
					}
				}
		});
	return _str;
}
//查询条件拼装--CODE
function getQueryCode(formId) {
	var _str = '';
	var id = '';
	$.each($("#"+formId).find("[id]"),function(i,o){
		$o = $(o);
		id = $o.attr("id");
		if(id.indexOf("Txt")==-1){
			if (_str == "") {
				_str+= '"'+ id +'":"'+$o.val()+'"';
			} else {
				_str+=',"' + id +'":"'+$o.val()+'"';
			}
		}
	});
	return _str;
}