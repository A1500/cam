function init() {
	var infocommand = new L5.Command("com.inspur.cams.comm.informUtil.InformSessionCmd");
		infocommand.execute("getUserInfo");
		var userLoginName ="";
		if (!infocommand.error) {
			var info = infocommand.getReturn("userInfo");
			  userLoginName =info.userLoginName;//通过登录账号查找对应的婚姻登记处。
			}
			
	var mrmBasePersonCommand = new L5.Command("com.inspur.cams.marry.base.cmd.MrmBasePersonCommand");
		mrmBasePersonCommand.setParameter("loginId",userLoginName);
		mrmBasePersonCommand.execute("getDeptId");
		if (!mrmBasePersonCommand.error) {
			 deptId = mrmBasePersonCommand.getReturn("deptId");
			 deptName= mrmBasePersonCommand.getReturn("deptName");
			}
			if(deptId=="" || deptId==null){
				ds.newRecord();
				alert("没有对应的婚姻登记处！");
				return false;
			
			}
    	ds.setParameter("DEPT_ID@=",deptId);
    	ds.on("load",function(){
    		var records=ds.getAllRecords();
    		var areaRecords=L5.DatasetMgr.lookup("areaNameDs").getAllRecords();
			for(var i=0;i<areaRecords.length;i++){
				var value= areaRecords[i].get("value");
				for(var j=0;j<records.length;j++){
	    			if(records[j].get("functionName")==value){
	    				flg1=false;
	    			}
	    		}
	    		if(flg1){
					var record=L5.DatasetMgr.lookup("ds").newRecord();
					record.set("deptId",deptId);
					record.set("deptName",deptName);
					record.set("functionName",value); 
	    		}
			}
    	})
   	ds.setParameter("sort", "FUNCTION_NAME");
	ds.setParameter("dir", "ASC");
	L5.DatasetMgr.lookup("ds").load();
	
	
	
	resourceDs.setParameter("DEPT_ID@=",deptId);
	resourceDs.on("load",function(){
    		var resourceRecords=resourceDs.getAllRecords();
    		var resRecords=L5.DatasetMgr.lookup("resourceNameDs").getAllRecords();
			for(var i=0;i<resRecords.length;i++){
				var value= resRecords[i].get("value");
				for(var j=0;j<resourceRecords.length;j++){
	    			if(resourceRecords[j].get("resourceName")==value){
	    				flg2=false;
	    			}
	    		}
	    		if(flg2){
					var record=L5.DatasetMgr.lookup("resourceDs").newRecord();
					record.set("deptId",deptId);
					record.set("deptName",deptName);
					record.set("resourceName",value); 
	    		}
			}
    	})
   
	L5.DatasetMgr.lookup("resourceDs").load();
	
	
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	ds.setParameter("MRM_REGIS_AREA.DEPT_ID@=",deptId);
	ds.setParameter("MRM_REGIS_AREA.FUNCTION_NAME@=",getParam("functionName"));		
	ds.load();
}


function insert() {
	var Grid = L5.getCmp('editGridPanel');
	Grid.stopEditing();
	var record1=ds.newRecord();
	    record1.set("deptId",deptId);
	    record1.set("deptName",deptName);
}

function del() {
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  delIds=[];
			for(var i=0;i<selected.length;i++){
				delIds[i]=selected[i].get("functionId");
			}
			var command=new L5.Command("com.inspur.cams.marry.base.cmd.MrmRegisAreaCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	ds.remove(selected[i]);
				}
				ds.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
	
}
function save() {
	var records = ds.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	for(var i=0;i<records.length;i++){
		 if(isNaN(records[i].get("functionArea"))){
		 	alert("请输入数字！");
		 	return false;
		 }
		 if(records[i].get("functionName")=="05"){
		 	if(records[i].get("functionArea")>0 && records[i].get("jianNum")<=0){
			 	alert("咨询辅导区的面积大于0，咨询辅导区间数不得小于等于0");
			 	return false;
			 }
		 	if(records[i].get("functionArea")<=0 &&  records[i].get("jianNum")>0){
			 	alert("咨询辅导区的间数大于0，咨询辅导区的面积不得小于等于0");
			 	return false;
			 }
		 }
		 if(records[i].get("functionName")=="02"||records[i].get("functionName")=="03"){
			 if(records[i].get("cardreaderNum")!=records[i].get("windowNum")){
				 L5.Msg.alert('提示',"读卡器个数与窗口数不符，不能保存");
				 return false;
			 }
		 }
	}
	var isValidate = ds.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	
	var command = new L5.Command("com.inspur.cams.marry.base.cmd.MrmRegisAreaCommand");
	command.setParameter("records", records);
	command.execute("save");
	if (!command.error) {
		ds.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function reset() {
	ds.rejectChanges();
}


function insertXX() {
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/marry/dept/area/mrmregisarea_edit.jsp';
	var text = '增加登记机关功能区面积表';
	L5.forward(url,text,data);

}

function updateXX(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("dataBean",selected[0].get('functionId'));
	var url='jsp/cams/marry/dept/area/mrmregisarea_edit.jsp';
	var text = '修改登记机关功能区面积表';
	L5.forward(url,text,data);
}

function query1(){
	resourceDs.setParameter("RESOURCE_NAME@=",getParam("resourceName"));	
	resourceDs.setParameter("DEPT_ID@=",deptId);	
	resourceDs.load();
}

function insert1() {
	var Grid = L5.getCmp('editGridPanel1');
	Grid.stopEditing();
	var souRecord=resourceDs.newRecord();	
		souRecord.set("deptId",deptId);
	    souRecord.set("deptName",deptName);

}

function del1() {
	var editGrid=L5.getCmp('editGridPanel1');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  delIds=[];
			for(var i=0;i<selected.length;i++){
				delIds[i]=selected[i].get("resourceId");
			}
			var command=new L5.Command("com.inspur.cams.marry.base.cmd.MrmResourcesInfoCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	resourceDs.remove(selected[i]);
				}
				resourceDs.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
	
}
function save1() {
	var records = resourceDs.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	var isValidate = resourceDs.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	
	var command = new L5.Command("com.inspur.cams.marry.base.cmd.MrmResourcesInfoCommand");
	command.setParameter("records", records);
	command.execute("save");
	if (!command.error) {
		resourceDs.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function reset1() {
	resourceDs.rejectChanges();
}
function countRender(value){
	return "记录数:"+value;
}
function arRender(value){
	return "总面积:"+value;
}
function wiRender(value){
	return "窗口:"+value;
}
function chRender(value){
	return "座椅:"+value;
}
function coRender(value){
	return "计算机:"+value;
}
function prRender(value){
	return "打印机:"+value;
}
function caRender(value){
	return "读卡器:"+value;
}
 