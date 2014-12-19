function init() {
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
		ds.newRecord();
	}
	else if (method=="UPDATE"){
		ds.baseParams["ID@="]=idField;
		ds.load();
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
	L5.QuickTips.init(); 
}

function save(){
	var records = ds.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	//校验年度
	
	var years = ds.getCurrent().get("years");
	if(years==null || years==""){
		alert("年度不能为空");
		return false;
	}
	//校验行政区划
	var domicilename = ds.getCurrent().get("domicilename");
	if(domicilename==null || domicilename==""){
		alert("行政区划不能为空");
		return false;
	}
	//校验行政区划
	var domicilecode = ds.getCurrent().get("domicilecode");
	if(domicilecode==null || domicilecode==""){
		alert("行政区划不能为空");
		return false;
	}
	//校验年份
	var years = ds.getCurrent().get("years");
	if(years==null || years==""){
		alert("年度不能为空");
		return false;
	}
	//校验单位名称
	
	var area = ds.getCurrent().get("area");
	if(area==null || area==""){
		alert("单位名称不能为空");
		return false;
	}
	//校验
	var valid = ds.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		return false;
	}	
    var records = ds.getAllChangedRecords();
	var command=new L5.Command("com.inspur.cams.bpt.bptinstitution.cmd.BptOtherprovideCommand"); 
	command.setParameter("records",records);
	command.execute("save");	
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!",function(){
			back();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
 function back()
 {	 	var url='jsp/cams/bpt/institution/otherprovide/bptotherprovide_list.jsp';
		var text = 'BPT_OTHERPROVIDE';
		L5.forward(url,text);	 
 }
/**
 * 选择属地行政区划窗口
 */
function func_ForDomicileSelect1() {

	queryOrganName();
	var escapeorganName = escape(encodeURIComponent('山东省'));
	var revalue = window.showModalDialog(L5.webPath + "/jsp/cams/comm/diccity/dicCityCounty.jsp?organCode=370000000000&organName="+escapeorganName, "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		ds.getCurrent().set("domicilecode", list[0]);
		ds.getCurrent().set("domicilename", list[4]);
	}
}

function getArea() {
	var width = screen.width-200;
	var height =  screen.width-220
	var revalue =  window.showModalDialog("bptgloriousinstitute_list.jsp","","dialogHeight:"+height+"px;dialogWidth:"+width+"px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
			ds.getCurrent().set("area",revalue);
	}
}
