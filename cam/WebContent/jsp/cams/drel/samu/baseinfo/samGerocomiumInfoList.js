function init(){
	var samGerocomiumInfoDataSet=L5.DatasetMgr.lookup("samGerocomiumInfoDataSet");
	samGerocomiumInfoDataSet.setParameter("IF_CURRENT@=","1");	
	samGerocomiumInfoDataSet.setParameter("AREA_LEVEL_ID@like",organCode+"%" );
	samGerocomiumInfoDataSet.setParameter("sort","YEAR","MANA_LEVEL","GEROCOMIUM_NAME");
	samGerocomiumInfoDataSet.load();
}
function query(){
	var samGerocomiumInfoDataSet=L5.DatasetMgr.lookup("samGerocomiumInfoDataSet");
	var gerocomiumName=document.getElementById("gerocomiumName").value;
	var gerocomiumLevel=document.getElementById("gerocomiumLevel").value;
	var legelPeople=document.getElementById("legelPeople").value;
	var heatingWay=document.getElementById("heatingWay").value;
	var startMonth=document.getElementById("startMonth").value;
	var endMonth=document.getElementById("endMonth").value;
	var manaLevel=document.getElementById("manaLevel").value;
	samGerocomiumInfoDataSet.setParameter("IF_CURRENT@=","1");	
	samGerocomiumInfoDataSet.setParameter("GEROCOMIUM_NAME@=",gerocomiumName);
	samGerocomiumInfoDataSet.setParameter("ESTABLISH_DATE>",startMonth);
	samGerocomiumInfoDataSet.setParameter("ESTABLISH_DATE<",endMonth);
	samGerocomiumInfoDataSet.setParameter("MANA_LEVEL@=",manaLevel);
	samGerocomiumInfoDataSet.setParameter("GEROCOMIUM_LEVEL@=",gerocomiumLevel);
	samGerocomiumInfoDataSet.setParameter("HEATING_WAY@=",heatingWay);
	samGerocomiumInfoDataSet.setParameter("LEGEL_PEOPLE@=",legelPeople);
	samGerocomiumInfoDataSet.setParameter("sort","YEAR","MANA_LEVEL","GEROCOMIUM_NAME");
	samGerocomiumInfoDataSet.setParameter("AREA_LEVEL_ID@like", organCode+"%");
	samGerocomiumInfoDataSet.load();
}
function insert(){
	var data=new L5.Map();
	data.put("method","insert");
	var url="jsp/cams/drel/samu/baseinfo/samGerocomiumInfoInsert.jsp";
	L5.forward(url,'',data);
}
function newYearInsert(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var date = L5.server.getSysDate();
	if(records[0].get("year")==date.getYear()){
		L5.Msg.alert("提示","当前年份与系统年份相同，不能追加！");
		return;
	}
	var data=new L5.Map();
	data.put("method","newYearInsert");
	data.put("recordId",records[0].get("recordId"));
	data.put("gerocomiumId",records[0].get("gerocomiumId"));
	var url="jsp/cams/drel/samu/baseinfo/samGerocomiumInfoInsert.jsp";
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
	data.put("recordId",records[0].get("recordId"));
	data.put("gerocomiumId",records[0].get("gerocomiumId"));
	var url="jsp/cams/drel/samu/baseinfo/samGerocomiumInfoInsert.jsp";
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
	data.put("gerocomiumId",records[0].get("gerocomiumId"));
	var url="jsp/cams/drel/samu/baseinfo/samGerocomiumInfoDetail_list.jsp";
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
			var command=new L5.Command("com.inspur.cams.drel.samu.cmd.SamGerocomiumInfoCmd");
			command.setParameter("gerocomiumId",records[0].get("gerocomiumId"));
			command.execute("deleteAll");
			if (!command.error){
				init();
			}else{
				L5.Msg.alert("提示","删除出错！");
			}
		}
	});
}
// 弹出主管
function func_ForManaSelect() {
	var samGerocomiumInfoDataSet=L5.DatasetMgr.lookup("samGerocomiumInfoDataSet");
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("manaLevelId").value = list[0];
		document.getElementById("manaLevel").value = list[1];
	}
}
//弹出敬老院
function func_ForGeroSelect(){
	var samGerocomiumInfoDataSet=L5.DatasetMgr.lookup("samGerocomiumInfoDataSet");
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/drel/samu/geroTree/geroTree.jsp?radioMaxlevel=0&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("gerocomiumId").value = list[0];
		document.getElementById("gerocomiumName").value = list[1];
	}
}