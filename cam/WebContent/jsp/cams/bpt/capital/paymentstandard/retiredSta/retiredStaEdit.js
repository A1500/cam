/**
 * 初始化页面定义
 */
function init() {
	if(method==null||method==""){
		L5.Msg.alert('提示',"未知的界面命令！");
		back;
	}else if(method=="insert"){
		queryDs.setParameter("STANDARDS_COUNTIES",'370000000000');
		queryDs.setParameter("OBJECT_TYPE","81");
		queryDs.setParameter("method","insert");
		queryDs.load();
		queryDs.on("load",function(){
			
			if(queryDs.getCount()>0){
				var proStaMon =  queryDs.get("proStaMon");
				var note = queryDs.get("note");
				var records= queryDs.newRecord();
				records.set("proStaMon",parseFloat((proStaMon=='')?'0':proStaMon));
				records.set("note",note);
			}else{
				var records= queryDs.newRecord();
			}
		});
		
	}else if(method=="update"){
		queryDs.baseParams["ID"]=id;//初始化数据的查询条件
		document.getElementById("startDate").disabled = true;//修改生效日期起输入框失效
		document.getElementById("startDateImg").disabled = true;//修改生效日期起图片失效
		queryDs.load();//初始化数据
	}
	if(organType!=11){
		document.getElementById("proStaMon").disabled = true;
	}
};
/**
 * 返回功能
 */
function reset() {
	window.history.go(-1);
}
/**
 * 保存功能
 */
function save() {
	var record = queryDs.getCurrent();
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCapitalRetStaCommand");
   	command.setParameter("standardsCounties",organCode);
   	command.setParameter("objectType","81");
	if(record.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	if(method=="insert"){
		//生效日期起非空验证
		var startDate = document.getElementById("startDate").value;
		if(startDate==null||startDate==""){
			L5.Msg.alert('提示','生效日期起不能为空！');
			return false;
		}
		//生效日期起长度验证
		else if(startDate.length!="10"){
			L5.Msg.alert('提示','生效日期起长度不正确!');
			return false;
		}
		//校验生效日期起是否有效
		command.execute("getMaxDate");
		var maxDate = command.getReturn("startDate");
		if(maxDate!=null||maxDate!=""){
			var newDate =new Date(document.getElementById("startDate").value.replace("-","/"));
		    if(maxDate!=undefined){
		       var oldMax =new Date(maxDate.replace("-","/"));
		       if(newDate<=oldMax){
		          L5.Msg.alert('提示','生效日期必须大于'+oldMax+' !');
			      return false;
		       }
		    }
		}
	}
	//省标准非空验证
	var proStaMon = document.getElementById("proStaMon").value;
	if(proStaMon==null||proStaMon==""){
		L5.Msg.alert('提示','省标准不能为空！');
		return false;
	}
   	command.setParameter("record",record);
	command.execute("save");
	if (!command.error) {
		queryDs.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!");
		var url = 'jsp/cams/bpt/capital/paymentstandard/retiredSta/retiredStaList.jsp';
		var text = '农村退役士兵补助标准';
		var data = new L5.Map();
		data.put("organCode",organCode);
		L5.forward(url,text,data);
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
