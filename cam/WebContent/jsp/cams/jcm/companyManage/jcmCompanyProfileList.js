function init(){
	//var typeDS=L5.DatasetMgr.lookup("typeDS");
	//JcmCompanyProfileDataSet.setParameter("organCode",organCode);
	//typeDS.load(true);
	queryCompany();
}
//重置
function resetClick() {
	document.getElementById("companyName").value = '';
	document.getElementById("companyNature").value = '';
	document.getElementById("companyPeopleName").value = '';
	document.getElementById("companyNo").value = '';
	document.getElementById("companyBorgName").value = '';
}
function queryCompany(){
	var jcmCompanyProfileDataSet=L5.DatasetMgr.lookup("jcmCompanyProfileDataSet");
	var companyName = document.getElementById("companyName").value;
	var companyNature = document.getElementById("companyNature").value;
	var companyPeopleName = document.getElementById("companyPeopleName").value;
	var companyNo = document.getElementById("companyNo").value;
	var companyBorgName = document.getElementById("companyBorgName").value;
	
	jcmCompanyProfileDataSet.setParameter("companyName",'%'+companyName+'%');
	jcmCompanyProfileDataSet.setParameter("companyNature",companyNature);
	jcmCompanyProfileDataSet.setParameter("companyPeopleName",companyPeopleName);
	jcmCompanyProfileDataSet.setParameter("companyNo",companyNo);
	jcmCompanyProfileDataSet.setParameter("companyBorgName",companyBorgName);
	jcmCompanyProfileDataSet.load();
}
function insert(){
	var data=new L5.Map();
	data.put("method","insert");
	var url="jsp/cams/jcm/companyManage/jcmCompanyProfileEdit.jsp";
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
	data.put("companyId",records[0].get("COMPANY_ID"));
	var url="jsp/cams/jcm/companyManage/jcmCompanyProfileEdit.jsp";
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
	data.put("companyId",records[0].get("COMPANY_ID"));
	data.put("method","detail");
	var url="jsp/cams/jcm/companyManage/jcmCompanyProfileDetail.jsp";
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
			var command=new L5.Command("com.inspur.cams.jcm.cmd.JcmCompanyProfileCmd");
			command.setParameter("companyId",records[0].get("COMPANY_ID"));
			command.execute("deleteAll");
			if (!command.error){
				L5.Msg.alert('提示',"删除成功");
				init();
			}else{
				L5.Msg.alert("提示","删除出错！");
			}
		}
	});
}
function select(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
}
/**
 * 选择属地行政区划窗口
*/
function func_ForDomicileSelect() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("lrdwmc").value = list[1];
		//jcmCompanyProfileDataSet.set('organName',list[1]);
		//jcmCompanyProfileDataSet.set('organCode',list[0]);
	}
}