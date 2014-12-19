function init(){
	var dataset=L5.DatasetMgr.lookup('SamMedicalPerDS');
	dataset.setParameter("domicile_Code@=",organCode);
	dataset.setParameter("year@=",getCurDate().substring(0,4));
	document.getElementById("year").value=getCurDate().substring(0,4);
	//dataset.load();
}
//批量设定明年救助比例
function setAsLastYear(){
			var SamMedicalLastCheckPerDS=L5.DatasetMgr.lookup('SamMedicalLastCheckPerDS');
			SamMedicalLastCheckPerDS.setParameter("domicile_Code@=",organCode);
			SamMedicalLastCheckPerDS.setParameter("year@=",getCurDate().substring(0,4)*1+1);
			SamMedicalLastCheckPerDS.load();
			SamMedicalLastCheckPerDS.on('load',getThisYear);
}
//校验明年是否已设救助比例
function getThisYear(SamMedicalLastCheckPerDS){
	if(SamMedicalLastCheckPerDS.getCount()!=0){
		L5.Msg.alert("提示","已经设定部分明年救助比例，请手动调整！");
	}else{
		L5.MessageBox.confirm('确定', '确定要批量设定明年救助比例？',function(sta){
				if(sta=="yes"){
				var SamMedicalLastPerDS=L5.DatasetMgr.lookup('SamMedicalLastPerDS');
				SamMedicalLastPerDS.setParameter("domicile_Code@=",organCode);
				//加载今年救助比例
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
		var lastCmd = new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMedicalPerSaveCmd");
		var dataset=L5.DatasetMgr.lookup('SamMedicalPerDS');
		setPerTopLine(SamMedicalLastPerDS,dataset,lastCmd)
	}
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
	dataset.set("domicileCode",document.getElementById("domicileCode").value);
	var record=dataset.getCurrent();	
	var isValidate=dataset.isValidate(true);
	if(isValidate!=true){
		L5.Msg.alert("错误","无法通过校验！"+isValidate);
		return;
	}
	checkRecord(record,"save");
		
}
//保存
function saveRecord(record){
			var command = new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMedicalPerSaveCmd");
			command.setParameter("samMedicalPer", record.toBean("com.inspur.cams.drel.mbalance.data.SamMedicalPer"));
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
//修改更新方法
function updateRecord(record){
	L5.MessageBox.confirm('确定', '你确定要修改吗？',function(sta){
		if(sta=="yes"){
			var command = new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMedicalPerSaveCmd");
			command.setParameter("samMedicalPer", record.toBean("com.inspur.cams.drel.mbalance.data.SamMedicalPer"));
			command.execute("update");
			if (!command.error) {
				L5.Msg.alert("提示","修改成功！",function(){var win=L5.getCmp("updateWin");win.hide();
				var dataset=L5.DatasetMgr.lookup('SamMedicalPerDS');
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
//增加修改保存时验证（同一年相同救助类型相同档次的数据不能有两项）
function checkRecord(record,method){
	var querySamMedicalPerDS=L5.DatasetMgr.lookup('querySamMedicalPerDS');
	querySamMedicalPerDS.purgeListeners();
	querySamMedicalPerDS.setParameter("ID@<>",record.get("id"));
	querySamMedicalPerDS.setParameter("TYPE",record.get("type"));
	querySamMedicalPerDS.setParameter("DOMICILE_CODE",organCode);
	querySamMedicalPerDS.setParameter("YEAR",record.get("year"));
	querySamMedicalPerDS.setParameter("ASSITANCE_LEVEL",record.get("assitanceLevel"));
	querySamMedicalPerDS.on("load",function(){
		if(querySamMedicalPerDS.getCount()>0){
		  L5.Msg.alert("错误","重复设设置！");
		}else{
			if( parseInt(record.get("lowerLimit")) >  parseInt(record.get("upperLimit")) ){
			  L5.Msg.alert("错误","上限金额"+record.get("upperLimit")+"不能小于下限金额"+record.get("lowerLimit")+"！");
				return;
			}
			if(method=="save"){
				saveRecord(record);
			}else if(method=="update"){
				updateRecord(record);
			}
		}
	});	
	querySamMedicalPerDS.load();
	
}
//点击查询的查询方法
function forQuery(){
	var qdomicileCode=document.getElementById('qdomicileCode').value;
	if((document.getElementById("qdomicile").value==organName)||(document.getElementById("qdomicile").value=="")){
		qdomicileCode=organCode;
	}
	var type=document.getElementById('type').value;
	var year=document.getElementById('year').value;
	var assitanceLevel=document.getElementById('assitanceLevel').value;
	var upperLimit=document.getElementById('upperLimit').value;
	var lowerLimit=document.getElementById('lowerLimit').value;
	var percentage=document.getElementById('percentage').value;
	
	var dataset=L5.DatasetMgr.lookup('SamMedicalPerDS');
		dataset.setParameter("domicile_Code@=",qdomicileCode);
		dataset.setParameter("type@=",type);
		dataset.setParameter("year@=",year);
		dataset.setParameter("assitance_Level@=",assitanceLevel);
		dataset.setParameter("upper_Limit@=",upperLimit);
		dataset.setParameter("lower_Limit@=",lowerLimit);
		dataset.setParameter("percentage@=",percentage);
	dataset.load();
}
//弹出上限数值window
function forUpperLimit(){
	var win=L5.getCmp("upperLimitWin");
	win.show();
}
//上限数值window的返回按钮
function closeWinLimit(){
	var win=L5.getCmp("upperLimitWin");
	win.hide();
}
function forAddUpperLimit(){
	
}
//
function checkLine(domId){
	checkAssMon(domId);
	if(getParam(domId)){
	
	}
}