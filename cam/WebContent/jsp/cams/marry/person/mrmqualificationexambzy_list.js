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
	deptId = commDeptId.getReturn("deptId");
	
	var ds = L5.DatasetMgr.lookup("ds");
//	ds.baseParams["bzyCode"] = "02";//02:颁证员
	ds.baseParams["ksSign"] = "1";//颁证员
		//省级用户查看所有
	if(organType == 11){
		ds.load();
	}else{
		ds.setParameter("deptId",deptId);
		L5.getCmp("editGridPanel").setVisible(false);
		L5.getCmp("gridPanel").setVisible(true);
	}
	ds.load();
	if(organType == 11){
	ds.on("load",function(){
//		var record=L5.DatasetMgr.lookup("ds").newRecord();
		var records = ds.getAllRecords();
		for(var i=0;i<records.length;i++){
			if(records[i].get("KSJG") != "01" && records[i].get("KSJG") != "02"){
				records[i].set("KSJG","01");
			}
			if(records[i].get("ZGZZT") != "01" && records[i].get("ZGZZT") != "02"){
				records[i].set("ZGZZT","01");
			}
		}
	});
	}
//	var ksTimeDataset = L5.DatasetMgr.lookup("ksTimeDataset");
//	ksTimeDataset.baseParams["filterSql"] = " ks_sign = '0'";
//	ksTimeDataset.load();
	
	L5.DatasetMgr.lookup("ndYearDataset").load();
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	ds.setParameter("name",getParam("name"));
	ds.setParameter("ndYear",getParam("ndYear"));
	ds.setParameter("ksqs",getParam("ksqs"));		
	ds.setParameter("deptId",getParam("deptId"));
	ds.setParameter("ksjg",getParam("ksjg"));		
	ds.setParameter("bkjg",getParam("bkjg"));		
	ds.setParameter("bzyzgzh",getParam("bzyzgzh"));		
	ds.setParameter("fillCardTime",getParam("fillCardTime"));	
	if(organType != 11 && getParam("deptId") == undefined){
		ds.setParameter("deptId",deptId);
	}	
	ds.load();
	dsExcel.setParameter("name",getParam("name"));
	dsExcel.setParameter("ndYear",getParam("ndYear"));
	dsExcel.setParameter("ksqs",getParam("ksqs"));		
	dsExcel.setParameter("deptId",getParam("deptId"));
	dsExcel.setParameter("ksjg",getParam("ksjg"));		
	dsExcel.setParameter("bkjg",getParam("bkjg"));		
	dsExcel.setParameter("bzyzgzh",getParam("bzyzgzh"));		
	dsExcel.setParameter("fillCardTime",getParam("fillCardTime"));
	if(organType != 11 && getParam("deptId") == undefined){
		dsExcel.setParameter("deptId",deptId);
	}
}
function rest(){
	document.getElementById("name").value = ''; 
	document.getElementById("ndYear").value = ''; 
	document.getElementById("ksqs").value = ''; 
	document.getElementById("deptId").value = ''; 
	document.getElementById("deptName").value = '';
	document.getElementById("ksjg").value = ''; 
	document.getElementById("bkjg").value = ''; 
	document.getElementById("certificateId").value = ''; 
	document.getElementById("fillCardTime").value = ''; 
}
function insert() {
	var records = ds.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	var command = new L5.Command("com.inspur.cams.marry.base.cmd.MrmQualificationExamCommand");
	command.setParameter("records", records);
	command.execute("update");
	if (!command.error) {

		ds.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',command.error);
	}
}

function detail(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	ndYear = selected[0].get('ND_YEAR');
	var ksqsDataset = L5.DatasetMgr.lookup("ksqsDataset");
	ksqsDataset.setParameter('filterSql', " ND_YEAR = '" + ndYear + "' and KS_SIGN = '1'  and ks_yn = '01'");
	ksqsDataset.load();
	var ksTimeDataset = L5.DatasetMgr.lookup("ksTimeDataset");
	ksTimeDataset.setParameter('filterSql', " ND_YEAR = '" + ndYear + "' and KS_SIGN = '1'  and ks_yn = '01'");
	ksTimeDataset.load();
	L5.getCmp("detailWin").setVisible(true);
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
				delIds+=selected[i].get("KSXX_ID");
				if(i!=selected.length-1){
					delIds += ',';
				}
			}
			var command=new L5.Command("com.inspur.cams.marry.base.cmd.MrmQualificationExamCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	ds.remove(selected[i]);
				}
				ds.commitChanges();
			}else{
				L5.Msg.alert('提示',"删除时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}

//所属部门
function forHelp(){
	var dept = window.showModalDialog(L5.webPath+"/jsp/cams/marry/dept/mrmRadioTree.jsp","","dialogHeight:500px;dialogWidth:350px;resizable:no;scroll:yes;");
	if(dept == ''){
		document.getElementById("deptName").value = '';
		document.getElementById("deptId").value = '';
	}else{
		var list = dept.split(';');
		document.getElementById("deptName").value = list[1] ;
		document.getElementById("deptId").value = list[2];
	}
	
}
//打印
function commonQuery(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要打印的记录!");
		return false;
	}
	var ksxxId = selected[0].get('KSXX_ID');
	document.getElementById("docpath").value = "jsp/cams/marry/person/print/mrmqualificationexambzy.doc";
	document.getElementById("ksxxId").value = ksxxId; 
	
	var url="../../comm/print/jspcommonprint.jsp?";
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	window.close();
}

function backTime(value, cellmeta, record, rowindex, colindex, dataset) {
	if (record.get("KSQS")) {
		record.set("KSSJ_TIME", record.get("KSQS"));
		var records = ksTimeDataset.query("value", record.get("KSQS"));
		if(records.items[0]){
			return records.items[0].get("text");
		}else{
			return "";
		}
	} else
		return "";
}
function confirm(){
	if(document.getElementById('ksqs1').value == ''){
	 	L5.Msg.alert("提示","考试期次不能为空!");
	 	return false;
	}
	var record = ds.getCurrent();
	record.set("KSSJ_TIME",document.getElementById("kssjTime1").innerHTML);
	record.set("KSAP_ID",document.getElementById("ksapId_hidden").value);
	var command=new L5.Command("com.inspur.cams.marry.base.cmd.MrmQualificationExamCommand"); 
	command.setParameter("record",record);
	command.execute("updateQualification");
	if (!command.error) {
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"数据保存成功!"+command.error);
	}
	L5.getCmp("detailWin").setVisible(false);
}
function closeWin(){
	L5.getCmp("detailWin").setVisible(false);
}
function tochange(){
	var record = ds.getCurrent();
	var ndYear = record.get("ND_YEAR");
	var ksqs = document.getElementById('ksqs1').value;//alert(ndYear+" "+ksqs);
	var apds = L5.DatasetMgr.lookup("apds");
	apds.baseParams["ND_YEAR"] = ndYear;
	apds.baseParams["KS_SIGN"] = "1";
	apds.baseParams["KSQS"] = ksqs;
	apds.baseParams["KS_YN"] = "01";
//	apds.load();
	var innerString = "";
	apds.on('load',function(){
		var records = apds.getAllRecords();
		//if(apds.getCurrent()){
			
		//	for(var i = 0; i<records.length; i++){
				innerString=(records[0].get("ksbeginTime"));
				ksapIdInner=(records[0].get("ksapId"));
		//	}
			document.getElementById("kssjTime1").innerHTML=innerString;
			document.getElementById("ksapId_hidden").value=ksapIdInner;
			
		//}
		
	});
	apds.load();
}
//批量设置考试合格
function plszhg(){
	
	
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert('提示', "请选择要设置合格的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要设置合格的记录吗?', function(state) {
				if (state == "yes") {
					var delIds = "'";
					for (var i = 0; i < selected.length; i++) {
						selected[i].set("KSJG","01");
					}
				} else {
					return false;
				}
			});
}
//导出
function emportExcel(){
//	var dsExcel = L5.DatasetMgr.lookup("dsExcel");
	dsExcel.baseParams["ksSign"] = "1";//颁证员
	dsExcel.load();
	dsExcel.on("load", function() {
				L5.dataset2excel(dsExcel,
						"/jsp/cams/marry/person/excel/mrmqualificationbzyExcel.jsp");
			});
}