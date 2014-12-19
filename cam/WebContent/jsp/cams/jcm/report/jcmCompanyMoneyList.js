function init(){
	var jcmCompanyMoneyDataSet=L5.DatasetMgr.lookup("jcmCompanyMoneyDataSet");
	jcmCompanyMoneyDataSet.load();
}
function query(){
//	var jcmCompanyMoneyDataSet=L5.DatasetMgr.lookup("jcmCompanyMoneyDataSet");
//	jcmCompanyMoneyDataSet.load();
	L5.getCmp("pan").show();
	var frame=document.getElementById("nodeFrame");
	var companyId=document.getElementById("companyId");
	var url="summary.jsp?companyId="+document.getElementById("companyId").value;
	frame.setAttribute("src", url);
}
function query1(){
//	var jcmCompanyMoneyDataSet=L5.DatasetMgr.lookup("jcmCompanyMoneyDataSet");
//	jcmCompanyMoneyDataSet.load();
	var frame1=document.getElementById("nodeFrame1");
	var year=document.getElementById("year").value;
	if(year == ""){
		L5.Msg.alert('提示',"请输入年度");
		return ;
	}
	L5.getCmp("pan1").show();
	
	//var companyType=document.getElementById("companyType").value;
	
	//var url="summary1.jsp?year="+year+"&organCode="+organCode+"&companyType="+companyType;
	var url="summary1.jsp?year="+year+"&organCode="+organCode;
	frame1.setAttribute("src", url);
}
function insert(){
	var data=new L5.Map();
	data.put("method","insert");
	var url="jsp/cams/jcm/jcmCompanyMoneyEdit.jsp";
	L5.forward(url,'',data);
}
function update(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","update");
	data.put("companyMoneyId",records[0].get("companyMoneyId"));
	var url="jsp/cams/jcm/jcmCompanyMoneyEdit.jsp";
	L5.forward(url,'',data);
}
function detail(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("companyMoneyId",records[0].get("companyMoneyId"));
	var url="jsp/cams/jcm/jcmCompanyMoneyDetail.jsp";
	L5.forward(url,'',data);
}
function del(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	L5.MessageBox.confirm("提示", "是否删除该数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.jcm.cmd.JcmCompanyMoneyCmd");
			command.setParameter("companyMoneyId",records[0].get("companyMoneyId"));
			command.execute("delete");
			if (!command.error){
				var jcmCompanyMoneyDataSet=L5.DatasetMgr.lookup("jcmCompanyMoneyDataSet");
				jcmCompanyMoneyDataSet.load();
			}else{
				L5.Msg.alert("提示","删除出错！");
			}
		}
	});
}
//选择单位信息 回填
function selectPep(){
	var reValue = openCemeChoose();
	if (reValue != "" && reValue != undefined) {
		var arrs = reValue.split(",");
		document.getElementById("companyName").value=arrs[1];
		document.getElementById("companyId").value=arrs[0];
	}
}
function openCemeChoose(){
	return window.showModalDialog("jcmCompanyList.jsp?organCode="+organCode, "","dialogHeight:400px;dialogWidth:480px;resizable:yes;scroll:yes;status:no;");
}
function returnBack(){
	history.go(-1);
}