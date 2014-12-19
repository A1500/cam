function init(){
	var dataset=L5.DatasetMgr.lookup('SamMedicalPerDS');
	dataset.setParameter("domicile_Code@=",organCode);
	dataset.setParameter("year@=",getCurDate().substring(0,4));
	document.getElementById("year").value=getCurDate().substring(0,4);
	//dataset.load();
}
//批量设定明年补助比例
function setAsLastYear(){
	var SamMedicalLastCheckPerDS=L5.DatasetMgr.lookup('SamMedicalLastCheckPerDS');
	SamMedicalLastCheckPerDS.setParameter("domicile_Code@=",organCode);
	SamMedicalLastCheckPerDS.setParameter("year@=",getCurDate().substring(0,4)*1+1);
	SamMedicalLastCheckPerDS.load();
	SamMedicalLastCheckPerDS.on('load',getThisYear);
}
//校验明年是否已设补助比例
function getThisYear(SamMedicalLastCheckPerDS){
	if(SamMedicalLastCheckPerDS.getCount()!=0){
		L5.Msg.alert("提示","已经设定部分明年补助比例，请手动调整！");
	}else{
		L5.MessageBox.confirm('确定', '确定要批量设定明年补助比例？',function(sta){
			if(sta=="yes"){
				var SamMedicalLastPerDS=L5.DatasetMgr.lookup('SamMedicalLastPerDS');
				SamMedicalLastPerDS.setParameter("domicile_Code@=",organCode);
				SamMedicalLastPerDS.setParameter("year@=",getCurDate().substring(0,4));
				SamMedicalLastPerDS.load();
				SamMedicalLastPerDS.on('load',getper);
			}else{
				return false;
			}
		});
	}
}
//调用批量设定方法
function getper(SamMedicalLastPerDS){
	if(SamMedicalLastPerDS.getCount()!=0){
		var lastCmd = new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMedicalSpPerSaveCmd");
		var dataset=L5.DatasetMgr.lookup('SamMedicalPerDS');
		setPerTopLine(SamMedicalLastPerDS,dataset,lastCmd)
	}
}
//点击添加按钮打开添加window
function addMedical(){
	var dataset=L5.DatasetMgr.lookup('SMTLForAdd');
	dataset.removeAll();
	dataset.newRecord();
	//获取优抚对象属地
	var command = new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMedicalSpPerSaveCmd");
	command.execute('getOnLineInf');
	var organCode=command.getReturn('organCode');
	var win=L5.getCmp("addWin");
	win.show();
	document.getElementById("domicile").innerHTML=organName;
	document.getElementById("domicileCode").value=organCode;
	document.getElementById('disabilityLevelAdd').disabled=true;
	
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
	var record=dataset.getCurrent();
	dataset.set('domicileCode',organCode);
	var isValidate=dataset.isValidate(true);
	if(isValidate!=true){
		L5.Msg.alert("错误","无法通过校验！"+isValidate);
		return;
	}
	//根据已知条件得到省级救助比例的要求
	var checkDataset=L5.DatasetMgr.lookup('checkDataset');
	var type=document.getElementById('TypeAdd').value;
	checkDataset.setParameter("type@=",type);
	checkDataset.setParameter("domicile_Code@=",document.getElementById('domicileCode').innerHTML);
	checkDataset.setParameter("safeguard_Type@=",document.getElementById('safeguardTypeAdd').value);
	var disabilityLevel=document.getElementById('disabilityLevelAdd').value;
	if(disabilityLevel=="") disabilityLevel=undefined;	
	checkDataset.setParameter("disability_Level@=",disabilityLevel);
	checkDataset.load();
	checkRecord(record,"save");
	
	
}
//增加修改保存时验证（同一年相同救助类型相同档次的数据不能有两项）
function checkRecord(record,method){
	var querySMTLDS=L5.DatasetMgr.lookup('querySMTLDS');
	querySMTLDS.purgeListeners();
	querySMTLDS.setParameter("ID@<>",record.get("id"));
	querySMTLDS.setParameter("TYPE",record.get("type"));
	querySMTLDS.setParameter("DOMICILE_CODE",organCode);
	querySMTLDS.setParameter("YEAR",record.get("year"));
	querySMTLDS.setParameter("DISABILITY_LEVEL",record.get("disabilityLevel"));
	querySMTLDS.setParameter("SAFEGUARD_TYPE",record.get("safeguardType"));
	querySMTLDS.on("load",function(){
		if(querySMTLDS.getCount()>0){
		  L5.Msg.alert("错误","重复设设置！");
		}else{
			if(method=="save"){
				saveRecord(record);
			}else if(method=="update"){
				updateRecord(record);
			}
		}
	});	
	querySMTLDS.load();
	
}
//保存
function saveRecord(record){
	var command = new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMedicalSpPerSaveCmd");
	command.setParameter("samMedicalSpPer", record.toBean("com.inspur.cams.drel.mbalance.data.SamMedicalSpPer"));
	command.execute("insert");
	if (!command.error) {	
		L5.Msg.alert("提示","保存成功！",function(){var win=L5.getCmp("addWin");win.hide();
			
		var dataset=L5.DatasetMgr.lookup('SamMedicalPerDS');
		dataset.setParameter("domicile_Code@=",organCode);
		dataset.setParameter("year@=",document.getElementById('year').value);
		dataset.load();
		});
	}else{
		L5.Msg.alert("错误",command.error);
	}
}
//更新
function updateRecord(record){
	L5.MessageBox.confirm('确定', '你确定要修改吗？',function(sta){
		if(sta=="yes"){
			var command = new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMedicalSpPerSaveCmd");
			
			command.setParameter("samMedicalSpPer", record.toBean("com.inspur.cams.drel.mbalance.data.SamMedicalSpPer"));
			command.execute("update");
			if (!command.error) {
				var url="jsp/cams/drel/mbalance/samMedicalSpPer.jsp";
				var text="";
				L5.Msg.alert("提示","修改成功！",function(){var win=L5.getCmp("updateWin");win.hide();var dataset=L5.DatasetMgr.lookup('SamMedicalPerDS');
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
		return;
	}
	var record=dataset.getCurrent();
	record.set("domicileCode",document.getElementById("updatedomicileCode").value);
	checkRecord(record,"update");
}
//查询方法
function forQuery(){
	var apanage=document.getElementById('qdomicileCode').value;
	if((document.getElementById("qdomicile").value==organName)||(document.getElementById("qdomicile").value=="")){
		apanage=organCode;
	}
	var type=document.getElementById('type').value;
	var year=document.getElementById('year').value;
	var disabilityLevel=document.getElementById('disabilityLevel').value;
	var safeguardType=document.getElementById('safeguardType').value;
	var percentage=document.getElementById('percentage').value;
	
	var dataset=L5.DatasetMgr.lookup('SamMedicalPerDS');
	if(apanage=="") apanage=undefined;	
		dataset.setParameter("domicile_Code@like",apanage);
	if(type=="") type=undefined;	
		dataset.setParameter("type@=",type);
	if(year=="") year=undefined;	
		dataset.setParameter("year@=",year);
		
	if(disabilityLevel=="") disabilityLevel=undefined;	
		dataset.setParameter("disability_Level@=",disabilityLevel);
	if(safeguardType=="") safeguardType=undefined;	
		dataset.setParameter("safeguard_Type@=",safeguardType);
	if(percentage=="") percentage=undefined;	
		dataset.setParameter("percentage@=",percentage);
	dataset.load();
}
//选择优抚对象类别为伤残调用方法使伤残等级可填
function forType(value,domId){
	if(value==0){
		document.getElementById(domId).disabled=false;
		document.getElementById(domId).value="";
	}else if(value!=0){
		document.getElementById(domId).disabled=true;
		document.getElementById(domId).value="";
	}
}