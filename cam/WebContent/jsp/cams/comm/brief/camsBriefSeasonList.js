var status = "";
function init(){
	var camsSeasonDataSet=L5.DatasetMgr.lookup("camsSeasonDataSet");
	camsSeasonDataSet.setParameter("sort", "REPORT_SEASON");
	camsSeasonDataSet.setParameter("dir", "DESC");
	camsSeasonDataSet.load();
	var workDataSet=L5.DatasetMgr.lookup("workDataSet");
	workDataSet.setParameter("filterSql", "STATUS='1'");
	workDataSet.setParameter("sort", "WORK_ID DESC");
	workDataSet.load();
}
function getParam(name){
	return document.getElementById(name).value;
}

function insert(){
	var ds=L5.DatasetMgr.lookup("SeasonDs");
	var command=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
	command.setParameter("IdHelp", "Id32");
	command.execute();
	var seasonId=command.getReturn("id");
	ds.newRecord({"seasonId":seasonId});
	status= "insert";
	L5.getCmp("SeasonWin").show();
}
function update(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var ds=L5.DatasetMgr.lookup("SeasonDs");
	ds.setParameter("SEASON_ID@=",records[0].get("seasonId"));
	ds.load(true);
	status= "update";
	L5.getCmp("SeasonWin").show();
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
			var command=new L5.Command("com.inspur.cams.comm.brief.cmd.CamsBriefSeasonCmd");
			command.setParameter("seasonId",records[0].get("seasonId"));
			command.execute("delete");
			if (!command.error){
				var camsBriefDataSet=L5.DatasetMgr.lookup("camsSeasonDataSet");
				camsBriefDataSet.load();
			}else{
				L5.Msg.alert("提示","删除出错！");
			}
		}
	});
}
function confirm(){
	var ds=L5.DatasetMgr.lookup("SeasonDs");
	
	var record = ds.getCurrent();
	record.set("organArea",document.getElementById("organCode").value);
	record.set("organName",document.getElementById("organName").value);
	var command=new L5.Command("com.inspur.cams.comm.brief.cmd.CamsBriefSeasonCmd");
	command.setParameter("record",record);
	if(status=="update"){
		command.execute("update");
	}else{
		command.execute("insert");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功");
		closeWin();
		init();
	}else{
		L5.Msg.alert("提示","保存出错！"+command.error);
	}
}

function closeWin(){
	L5.getCmp("SeasonWin").hide();
}

function func_ForDomicileSelect() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=-2&level=1&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("organCode").value = list[0];
		document.getElementById("organName").value = list[1];
	}
}

function toReport() {
    var editGrid = L5.getCmp('grid');
    var selected = editGrid.getSelectionModel().getSelections();
    if (selected.length != 1) {
        L5.Msg.alert('提示', "请选择一条记录修改!");
        return false;
    }
    var data = new L5.Map();
    data.put("organArea", selected[0].get('organArea'));
    data.put("reportSeason", selected[0].get('reportSeason'));
    var url = 'jsp/cams/comm/brief/camsBriefInsert.jsp';
    var text = '简报填报页面';
    L5.forward(url, text, data);
}