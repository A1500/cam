function init(){
	var dataset=L5.DatasetMgr.lookup('SamMedicalTopLineDS');
	dataset.baseParams["domicile_Code@like@String"]=organCode.substring(0,organCode.indexOf("000"));
	dataset.setParameter("year@=",getCurDate().substring(0,4));
	document.getElementById("year").value=getCurDate().substring(0,4);
	dataset.setParameter("domicile_Code@=",organCode);
	//dataset.load();
}
//点击添加按钮打开添加window
function addMedical(){
	var dataset=L5.DatasetMgr.lookup('SMTLForAdd');
	dataset.removeAll();
	dataset.newRecord();
	var win=L5.getCmp("addWin");
	win.show();
	document.getElementById("domicile").innerHTML=organName;
	document.getElementById("domicileCode").value=organCode;
}
//关闭添加window
function closeWin(){
	var win=L5.getCmp("addWin");
	win.hide();
}
//关闭添加window
function closeWin1(){
	var win=L5.getCmp("updateWin");
	win.hide();
}
//添加方法
function forAdd(){
	var dataset=L5.DatasetMgr.lookup('SMTLForAdd');
	dataset.set("domicileCode",organCode);
	var isValidate=dataset.isValidate(true);
	if(isValidate!=true){
		L5.Msg.alert("错误","无法通过校验！"+isValidate);
		isValidate="";
		return;
	}
	var record=dataset.getCurrent();	
	record.set("domicileCode",document.getElementById("domicileCode").value);
	checkRecord(record,"save");
	
}
//增加修改保存时验证（同一年相同救助类型相同档次的数据不能有两项）
function checkRecord(record,method){
	var querySamMedicalTopLineDS=L5.DatasetMgr.lookup('querySamMedicalTopLineDS');
	querySamMedicalTopLineDS.purgeListeners();
	querySamMedicalTopLineDS.setParameter("ID@<>",record.get("id"));
	querySamMedicalTopLineDS.setParameter("TYPE",record.get("type"));
	querySamMedicalTopLineDS.setParameter("DOMICILE_CODE",organCode);
	querySamMedicalTopLineDS.setParameter("YEAR",record.get("year"));
	querySamMedicalTopLineDS.on("load",function(){
		if(querySamMedicalTopLineDS.getCount()>0){
		  L5.Msg.alert("错误","重复设设置！");
		}else{
			if(method=="save"){
				saveRecord(record);
			}else if(method=="update"){
				updateRecord(record);
			}
		}
	});	
	querySamMedicalTopLineDS.load();
	
}
//保存
function saveRecord(record){
	var command = new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMedicalTopLineSaveCmd");
	command.setParameter("samMedicalTopLine", record.toBean("com.inspur.cams.drel.mbalance.data.SamMedicalTopLine"));
	command.execute("insert");
	if (!command.error) {	
		L5.Msg.alert("提示","保存成功！",function(){var win=L5.getCmp("addWin");win.hide();
		var dataset=L5.DatasetMgr.lookup('SamMedicalTopLineDS');
		dataset.baseParams["domicile_Code@like@String"]=organCode.substring(0,organCode.indexOf("000"));
		dataset.setParameter("domicile_Code@=",organCode);
		dataset.setParameter("year@=",document.getElementById('year').value);
		dataset.load();
		});
	}else{
		L5.Msg.alert("错误",command.error);
	}
}
//点击修改按钮
function updateMedical(){
	var grid = L5.getCmp('hlistPanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		if(records[0].get("domicileCode")!=organCode){
			L5.Msg.alert("提示","不能修改不属于本单位的记录！");
			return;
		}
		var id=records[0].get("id");
		var dataset=L5.DatasetMgr.lookup('SMTLForUpdate');
		dataset.setParameter("id@=",id);
		dataset.load();
		var win=L5.getCmp("updateWin");
		win.show();
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//修改方法
function forUpdate(){
	var dataset=L5.DatasetMgr.lookup('SMTLForUpdate');
	var isValidate=dataset.isValidate(true);
	if(isValidate!=true){
		L5.Msg.alert("错误","无法通过校验！"+isValidate);
		isValidate="";
		return;
	}
	var record=dataset.getCurrent();
	record.set("domicileCode",document.getElementById("updatedomicileCode").value);
	checkRecord(record,"update");
}
//修改更新
function updateRecord(record){
	L5.MessageBox.confirm('确定', '你确定要修改吗？',function(sta){
		if(sta=="yes"){
			var command = new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMedicalTopLineSaveCmd");
			command.setParameter("samMedicalTopLine", record.toBean("com.inspur.cams.drel.mbalance.data.SamMedicalTopLine"));
			command.execute("update");
			if (!command.error) {
				L5.Msg.alert("提示","修改成功！",function(){var win=L5.getCmp("updateWin");win.hide();
				
				var dataset=L5.DatasetMgr.lookup('SamMedicalTopLineDS');
				dataset.baseParams["domicile_Code@like@String"]=organCode.substring(0,organCode.indexOf("000"));
				dataset.setParameter("domicile_Code@=",organCode);
				dataset.setParameter("year@=",document.getElementById('year').value);
				dataset.load();});
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}
		else 
			return;
	}
	);		
	
}
//查询方法
function forQuery(){
	var apanage=document.getElementById('qdomicileCode').value;
	var type=document.getElementById('type').value;
	var year=document.getElementById('year').value;
	var topLineUP=document.getElementById('topLineUP').value;
	var topLineLOW=document.getElementById('topLineLOW').value;
	var dataset=L5.DatasetMgr.lookup('SamMedicalTopLineDS');
	if(apanage=="") apanage=undefined;	
		dataset.setParameter("domicile_Code@=",apanage);
	if(type=="") type=undefined;	
		dataset.setParameter("type@=",type);
	if(topLineUP=="") topLineUP=undefined;	
		dataset.setParameter("top_Line@>",topLineUP);	
	if(topLineLOW=="") topLineLOW=undefined;	
		dataset.setParameter("top_Line@<",topLineLOW);
	if(year=="") year=undefined;	
		dataset.setParameter("year@=",year);
		dataset.load();
}