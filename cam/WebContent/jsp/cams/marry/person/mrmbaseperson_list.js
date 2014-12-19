var deptId = "";
function init() {
	var infocommand = new L5.Command("com.inspur.cams.comm.informUtil.InformSessionCmd");
	infocommand.execute("getUserInfo");
	var userLoginId ="";
	if (!infocommand.error) {
		var info = infocommand.getReturn("userInfo");
		  userLoginId =info.userLoginName;//通过登录账号查找对应的婚姻登记处。
	}

	var commDeptId = new L5.Command("com.inspur.cams.marry.base.cmd.MrmBasePersonCommand");
	commDeptId.setParameter("loginId",userLoginId);
	commDeptId.execute("getDeptId");
	var deptId = commDeptId.getReturn("deptId");
	
	var ds = L5.DatasetMgr.lookup("ds");
	var excelDs = L5.DatasetMgr.lookup("excelDs");
	ds.setParameter("MRM_BASE_PERSON.NAME@not like","%婚姻%");
	ds.setParameter("sort", "DEPT_ID,WORKSTATE,CERTIFICATE_ID,PERSON_ID");
	
	ds.setParameter("dir", "asc");
	
	ds.on("load", function onDsLoad() {
	//	if (ds.getTotalCount() == 0) {
			//L5.Msg.alert("提示", "无符合条件的结果！");
	//	}else {
			var qrToolbar = L5.getCmp("qrToolbar");
			qrToolbar.setText("合计：共" + ds.getTotalCount() + "人");
	//	}
	});
	excelDs.setParameter("MRM_BASE_PERSON.NAME@not like","%婚姻%");
	excelDs.setParameter("sort", "DEPT_ID,WORKSTATE,CERTIFICATE_ID");
	excelDs.setParameter("dir", "asc");
	
//省级用户查看所有
	if(organType == 11){
		ds.load();
	}else{
		if(deptId.substring(4) == "0001") { //市级事务处或者管理处
			ds.baseParams["substr(DEPT_ID,1,4)"]=deptId.substring(0,4); 
			
			excelDs.baseParams["substr(DEPT_ID,1,4)"]=deptId.substring(0,4);
		} else {
			ds.baseParams["DEPT_ID@="]=deptId; 
			
			excelDs.baseParams["DEPT_ID@="]=deptId; 
		}
		
		
		ds.load();
	}
	
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	//ds.baseParams["MRM_BASE_PERSON.NAME@like@String"]=getParam("name"));	
	ds.setParameter("MRM_BASE_PERSON.NAME@not like","%婚姻%");	
	ds.setParameter("MRM_BASE_PERSON.NAME@like",getParam("name"));				
	ds.setParameter("MRM_BASE_PERSON.NATION@=",getParam("nation"));		
	ds.setParameter("MRM_BASE_PERSON.SEX@=",getParam("sex"));		
	ds.setParameter("MRM_BASE_PERSON.BIRTH_DATE@=",getParam("birthDate"));		
	ds.setParameter("MRM_BASE_PERSON.CARD_NO@=",getParam("cardNo"));		
	ds.setParameter("MRM_BASE_PERSON.DEPT_ID@=",getParam("deptId"));
	
	//excel条件
	excelDs.setParameter("MRM_BASE_PERSON.NAME@like",getParam("name"));				
	excelDs.setParameter("MRM_BASE_PERSON.NATION@=",getParam("nation"));		
	excelDs.setParameter("MRM_BASE_PERSON.SEX@=",getParam("sex"));		
	excelDs.setParameter("MRM_BASE_PERSON.BIRTH_DATE@=",getParam("birthDate"));		
	excelDs.setParameter("MRM_BASE_PERSON.CARD_NO@=",getParam("cardNo"));		
	excelDs.setParameter("MRM_BASE_PERSON.DEPT_ID@=",getParam("deptId"));
	
	var queryAge = document.getElementById("queryAge").value;
	if(queryAge != null && queryAge != "") {
		var reg = /^\d+$/;
		if(queryAge.match(reg) == null) {
			L5.Msg.alert("提示","年龄格式输入错误");
			return false;
		} else {
			ds.setParameter("GETAGE_CARD_NO(CARD_NO)@=",parseInt(queryAge));
		}
	}
	
	ds.setParameter("MRM_BASE_PERSON.WORKSTATE@=",getParam("queryWorkState"));
	ds.setParameter("MRM_BASE_PERSON.POLITICS@=",getParam("politics"));
	ds.setParameter("MRM_BASE_PERSON.KIND@=",getParam("kind"));
	ds.setParameter("MRM_BASE_PERSON.CULTURE@=",getParam("culture"));
	//ds.setParameter("MRM_BASE_PERSON.MARRY_START_DATE@=",getParam("startTime"));
	
	//excel导出
	excelDs.setParameter("MRM_BASE_PERSON.WORKSTATE@=",getParam("queryWorkState"));
	excelDs.setParameter("MRM_BASE_PERSON.POLITICS@=",getParam("politics"));
	excelDs.setParameter("MRM_BASE_PERSON.KIND@=",getParam("kind"));
	excelDs.setParameter("MRM_BASE_PERSON.CULTURE@=",getParam("culture"));
	
	ds.load();
}

function insert() {
/*	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/marry/person/mrmbaseperson_edit.jsp';
	var text = '增加人员基本信息表';
	L5.forward(url,text,data);*/
	var url="mrmbaseperson_edit.jsp?method=INSERT";
	var width = 1024;
	var height = 500;
    var re = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
    if(re=="true"){
    	L5.Msg.alert('提示', "保存成功!");
			ds.reload();
    }
}
//所属部门
function forHelp(){
	var dept = window.showModalDialog(L5.webPath+"/jsp/cams/marry/dept/mrmRadioTree.jsp","","dialogHeight:500px;dialogWidth:350px;resizable:no;scroll:yes;");
	if(dept == ''){
		document.getElementById("deptName").value = '';
		document.getElementById("deptId").value = '';
	}else if (dept != "" && dept != undefined) {
		var list = dept.split(";");
		document.getElementById("deptName").value = list[1];
		document.getElementById("deptId").value = list[2];
	}
}

function update(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
/*	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("dataBean",selected[0].get('personId'));
	var url='jsp/cams/marry/person/mrmbaseperson_edit.jsp';
	var text = '修改人员基本信息表';
	L5.forward(url,text,data);
	*/
	var url="mrmbaseperson_edit.jsp?dataBean="+selected[0].get('personId')+"&flag=1&method=UPDATE"+"&deptId="+selected[0].get('deptId');
	var width = 1024;
	var height = 500;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
}

function detail(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("dataBean",selected[0].get('personId'));
	var url='jsp/cams/marry/person/mrmbaseperson_detail.jsp';
	var text = '查看人员基本信息表';
	L5.forward(url,text,data);
}

function del(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  delIds='';
			for(var i=0;i<selected.length;i++){
				delIds+=selected[i].get("personId");
				if(i!=selected.length-1){
					delIds += ',';
				}
			}
			var command=new L5.Command("com.inspur.cams.marry.base.cmd.MrmBasePersonCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	ds.remove(selected[i]);
				}
				ds.commitChanges();
				L5.Msg.alert('提示',"删除成功！");
			}else{
				L5.Msg.alert('提示',"删除时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}
//打印资格证书
function dyzgzs(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var personId = selected[0].get('personId');
	document.getElementById("docpath").value = "jsp/cams/marry/person/print/rymrmqualificationexam.doc";
	document.getElementById("personId").value = personId; 
	
	var url="../../comm/print/jspcommonprint.jsp";
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");

}
//创建用户
function insertUser(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要创建的用户!");
		return false;
	}else if(selected.length>1){
		L5.Msg.alert('提示',"请选择一个要创建的用户!");
		return false;
	}
	
	var personId = selected[0].get("personId");
//	var organId = selected[0].get("organId");
	var deptId = selected[0].get("deptId");
	var loginid = selected[0].get("loginid");
	if(loginid!=""){
		alert("已经创建登陆用户,用户名:"+loginid+"密码:"+selected[0].get("pwd")+".");
	}else{
		var url='jsp/cams/marry/person/mrmBasePersonTreeEdit.jsp?personId='+personId+'&deptId='+deptId;
		L5.forward(url);
	}
}

//打印
function commonQuery(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var personId = selected[0].get('personId');
	document.getElementById("docpath").value = "jsp/cams/marry/person/print/mrmPerson.doc";
	document.getElementById("personId").value = personId; 
	
	var url="../../comm/print/jspcommonprint.jsp";
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
}

//重置
function reset(){
	document.getElementById("name").value = "";
	document.getElementById("loginid").value = "";
	document.getElementById("nation").value = "";
	document.getElementById("sex").value = "";
	document.getElementById("birthDate").value = "";
	document.getElementById("cardNo").value = "";
	document.getElementById("nativePlace").value = "";

}
//明细
function detailHref(value,cellmeta,record,rowindex,colindex,dataset){
	return 	'<a href="javascript:detail(\''+record.get("personId")+'\')">'+value+'</a>';
}

function detail(personId){
//	var data = new L5.Map();
//	data.put("dataBean",personId);
//	data.put("method","UPDATE");
//	data.put("flag","1");
//	var url='jsp/cams/marry/person/mrmbaseperson_detail.jsp';
//	var text = '人员信息';
//	L5.forward(url,text,data);
	
	var url="mrmbaseperson_detail.jsp?dataBean="+personId;
	var width = 1024;
	var height = 450;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
}
//判断逾期
function getStatus(value,cellmeta,record,rowindex,colindex,dataset){
	if(record.get("partyTime")){
		var date=new Date();
		var year=""+date.getFullYear();
		var partyYear=record.get("partyTime").split("-")[0];
		if(year-partyYear<3){
			return "正常";
		}else{
			return "逾期";
		}
	}else{
		return "未取得证书";
	}
}

//设置为颁证员
function bzySet(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择登记人员的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要设置为颁证员吗?',function(state){
		if(state=="yes"){
			var  delIds='';
			for(var i=0;i<selected.length;i++){
				delIds+=selected[i].get("personId");
				if(i!=selected.length-1){
					delIds += ',';
				}
			}
			var command=new L5.Command("com.inspur.cams.marry.base.cmd.MrmBasePersonCommand");
			command.setParameter("delIds", delIds);
			command.execute("bzySet");
			if (!command.error) {
				
				L5.Msg.alert('提示',"设置颁证员成功！");
				ds.reload();
			}else{
				L5.Msg.alert('提示',"设置颁证员失败！"+command.error);
			}
		}else{
			return false;
		}
	});
}


function  emportExcel() {
	excelDs.load();
	excelDs.on("load",function() {
		L5.dataset2excel(excelDs,"/jsp/cams/marry/person/excel/mrmBasePersonExcel.jsp?type=01");
	});
}

function show(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var personId = selected[0].get('personId');
	var url="mrm_baseperson_print.jsp?personId="+personId;
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
}
