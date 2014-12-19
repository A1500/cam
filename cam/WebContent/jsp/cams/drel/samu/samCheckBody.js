function init(){
	var samListDataSet=L5.DatasetMgr.lookup("samListDataSet");
	samListDataSet.load();
	var samGeroDataSet=L5.DatasetMgr.lookup("samGeroDataSet");
	//samGeroDataSet.setParameter("filterSql","AREA_LEVEL_ID like '"+getOrganArea()+"%'");
	samGeroDataSet.load();
}
function query(){
	var samListDataSet=L5.DatasetMgr.lookup("samListDataSet");
	samListDataSet.setParameter("checkDate",document.getElementById("checkDateQuery").value);
	samListDataSet.setParameter("gerocomiumName@=",document.getElementById("gerocomiumNameQuery").value);
	samListDataSet.load();
}
function saveList(){
	var samListDataSet=L5.DatasetMgr.lookup("samListDataSet");
	var records=samListDataSet.getAllRecords();
	var gerocomiumName=document.getElementById("gerocomiumName").value;
	var checkDate=document.getElementById("checkDate").value;
	var checkResult=document.getElementById("checkResult").value;
	if(records.length!=0){
		for(var i=0;i<records.length;i++){
			if(records[i].get("GEROCOMIUM_ID")==gerocomiumName && records[i].get("CHECK_DATE")==checkDate){
				L5.Msg.alert("提示","名册已登记！");
				return;
			}
		}
	}
	var command=new L5.Command("com.inspur.cams.drel.samu.cmd.SamGeroApplyCmd");
	command.setParameter("gerocomiumName",gerocomiumName);
	command.setParameter("checkDate",checkDate);
	command.setParameter("checkResult",checkResult);
	command.execute("insertCheck");
	if (!command.error){
		L5.Msg.alert("提示","名册保存成功！",function(){
			closeListWin();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function insert(){
	var win=L5.getCmp("addListWin");
	win.show(this);
	document.getElementById("gerocomiumName").value='';
	document.getElementById("checkDate").value='';
	document.getElementById("checkResult").value='';
	var samGeroDataSet=L5.DatasetMgr.lookup("samGeroDataSet");
	//samGeroDataSet.setParameter("filterSql","AREA_LEVEL_ID like '"+getOrganArea()+"%'");
	samGeroDataSet.load();
	//var supportOrgDataset = L5.DatasetMgr.lookup("supportOrgDataset");
	//supportOrgDataset.setParameter("filterSql", "SUBSTR(ORGAN_AREA_CODE,1,6)= '" + organArea.substring(0, 6) + "' AND ORGAN_STATUS='1'");
	//supportOrgDataset.load();
}
function editDetail(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var gerocomiumId=records[0].get('GEROCOMIUM_ID');
	var checkDate=records[0].get('CHECK_DATE');
	var width = 900;
	var height = 600;
	var url="samCheckInsert.jsp?gerocomiumId="+gerocomiumId+"&checkDate="+checkDate;
	window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
function closeListWin(){
	L5.getCmp("addListWin").setVisible(false);
	query();
}
function getOrganArea(){
	if(organArea.endsWith("0000000000")){//省370000000000
			return organArea.substring(0,2);
		} else if (organArea.endsWith("00000000")){//市370100000000
			return organArea.substring(0,4);
		} else if (organArea.endsWith("000000")){//县370104000000
			return organArea.substring(0,6);
		} else if (organArea.endsWith("000")){//乡370104003000
			return organArea.substring(0,9);
		}
        return organArea;
}