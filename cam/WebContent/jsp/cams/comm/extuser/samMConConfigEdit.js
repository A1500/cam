function init() {
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
		ds.newRecord();
	}
	else if (method=="UPDATE"){
		ds.baseParams["CON_AREA@="]=idField;
		ds.baseParams["CON_TYPE@="]=conType;
		ds.load();
		document.getElementById("conAreaName").disabled=true;
		document.getElementById("conType").disabled=true;
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
	L5.QuickTips.init(); 
}

function save(){
	var records = ds.getAllChangedRecords();
	//校验
	var valid = ds.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		return false;
	}	
    var record = ds.getCurrent();
	var command=new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMedicalConConfigCmd"); 
	command.setParameter("record",record);
	if(method=="INSERT"){
		var checkDs=L5.DatasetMgr.lookup("checkDs");
		checkDs.setParameter("con_area",document.getElementById("conArea").value);
		checkDs.setParameter("con_Type",document.getElementById("conType").value);
		checkDs.purgeListeners();
		checkDs.on('load',function(){
			if(checkDs.getCount()>0){
				L5.Msg.alert('提示',"已有本单位的数据!");
			}else{
				command.execute("insert");
				if (!command.error) {
					L5.Msg.alert('提示',"保存成功!");
					back();
				}else{
					L5.Msg.alert('提示',"保存时出现错误！"+command.error);
				}
			}
		
		});
		checkDs.load();
	}else if(method=="UPDATE"){
		command.execute("update");
		if (!command.error) {
			L5.Msg.alert('提示',"保存成功!");
			back();
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	
	}
}
 function back()
 {	 	var url='jsp/cams/comm/extuser/samMConConfigList.jsp';
		var text = '一站结算_医保系统连接配置';
		L5.forward(url,text);	 
 }
//医院选择窗口
var win;
//显示医院选择窗口并加载医院
function backHos(){
	extOrganDs.baseParams["organ_type"]="30";
	//extOrganDs.baseParams["area_code@like@String"]=organCode.substring(0,organCode.indexOf("000"));
	extOrganDs.load();
	if(win==undefined){
		win=L5.getCmp("selectHosWin");
	}
	win.show();
	
}

//医院查询
function selectHos(){
	extOrganDs.setParameter("organ_Name",document.getElementById("qhosName").value);
	extOrganDs.load();
}
//医院选择，并回填
function pickHos(){
	var hosGrid=L5.getCmp("hosGrid");
	var cell=hosGrid.getSelectionModel().getSelections();
	if(cell.length!=1){
		L5.Msg.alert("提示","请选择一条要查看的记录！");
		return;
	}
	document.getElementById("hosId").value=cell[0].get("organId");
	document.getElementById("hosName").value=cell[0].get("organName");
	colseWin();
}
//医院选择窗口关闭
function colseWin(){
	if(win==undefined){
		win=L5.getCmp("selectHosWin");
	}
	win.hide();
}
//医院选择窗口清除按钮
function removeName(){
	document.getElementById("hosId").value="";
	document.getElementById("hosName").value="";
	colseWin();
}
function changeArea(conCityValue){
	conAreaDs.setParameter("filterSql", "leve='2' and ups ='"+conCityValue+"' ");
	conAreaDs.load();
}
function forHelp(){
	var revalue = window.showModalDialog(
    		L5.webPath+"/jsp/cams/comm/diccity/dicCityCounty.jsp?organCode="+organCode+"&organName=请选择", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
    if(revalue!=""&&revalue!=undefined){
       var list = revalue.split(";");
       ds.set("conArea",list[0]);
       ds.set("conAreaName",list[1]);
    }
    
	
}