function init(){
	var samGerocomiumInfoDataSet=L5.DatasetMgr.lookup("samGerocomiumInfoDataSet");
	samGerocomiumInfoDataSet.setParameter("IF_CURRENT@=","1");	
	samGerocomiumInfoDataSet.load();
}
function query(){
	var samGerocomiumInfoDataSet=L5.DatasetMgr.lookup("samGerocomiumInfoDataSet");
	var gerocomiumName=document.getElementById("gerocomiumName").value;
	var establishDate=document.getElementById("establishDate").value;
	var legelPeople=document.getElementById("legelPeople").value;
	samGerocomiumInfoDataSet.setParameter("IF_CURRENT@=","1");	
	samGerocomiumInfoDataSet.setParameter("GEROCOMIUM_NAME@=",gerocomiumName);
	samGerocomiumInfoDataSet.setParameter("ESTABLISH_DATE@=",establishDate);
	samGerocomiumInfoDataSet.setParameter("LEGEL_PEOPLE@=",legelPeople);
	samGerocomiumInfoDataSet.load();
}
function insert(){
	var data=new L5.Map();
	data.put("method","insert");
	var url="jsp/cams/drel/samu/samGerocomiumInfoInsert1.jsp";
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
	var url="jsp/cams/drel/samu/samGerocomiumInfoInsert1.jsp";
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
	var url="jsp/cams/drel/samu/samGerocomiumInfoInsert1.jsp";
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
	var url="jsp/cams/drel/samu/samGerocomiumInfoDetail_list.jsp";
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
				var samGerocomiumInfoDataSet=L5.DatasetMgr.lookup("samGerocomiumInfoDataSet");
				samGerocomiumInfoDataSet.load();
			}else{
				L5.Msg.alert("提示","删除出错！");
			}
		}
	});
}