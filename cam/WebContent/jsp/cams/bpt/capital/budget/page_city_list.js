function init() {
	var ds = L5.DatasetMgr.lookup("ds");
	ds.setParameter("DOMICILE_CODE", selectOrganCode);
	ds.load();
	ds.on("load",function(){
		var upperTotal = [];
		var currentTotal = [];
		var records = ds.getAllRecords();
		for(var i=0;i<ds.getCount();i++){
			upperTotal[i] = parseFloat((records[i].get("compensationSubsidyUp")=='')?'0.00':records[i].get("compensationSubsidyUp"))+
							  parseFloat((records[i].get("institutionSubsidyUp")=='')?'0.00':records[i].get("institutionSubsidyUp"))+
							  parseFloat((records[i].get("medicalSubsidyUp")=='')?'0.00':records[i].get("medicalSubsidyUp"))+
							  parseFloat((records[i].get("houseSubsidyUp")=='')?'0.00':records[i].get("houseSubsidyUp"));
			records[i].set("upperTotal",upperTotal[i]);					  
			currentTotal[i] = parseFloat((records[i].get("compensationSubsidy")=='')?'0.00':records[i].get("compensationSubsidy"))+
							  parseFloat((records[i].get("institutionSubsidy")=='')?'0.00':records[i].get("institutionSubsidy"))+
							  parseFloat((records[i].get("medicalSubsidy")=='')?'0.00':records[i].get("medicalSubsidy"))+
							  parseFloat((records[i].get("houseSubsidy")=='')?'0.00':records[i].get("houseSubsidy"));
			records[i].set("currentTotal",currentTotal[i]);		
			records[i].set("total",upperTotal[i]+currentTotal[i]);	
		}
	});
	if(organCode!=selectOrganCode){
		document.getElementById("insert").style.visibility="hidden";
		document.getElementById("update").style.visibility="hidden";
		document.getElementById("del").style.visibility="hidden";
		return;
	}
	L5.QuickTips.init();
}

function insert(){
	var url='city_edit.jsp?method=INSERT&organCode='+organCode+"&level="+level;
	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:850px;dialogHeight:330px;resizable:no");
	ds.reload();
	
}

function update(){
	var editGrid=L5.getCmp('GridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var inputId = selected[0].get("inputId");
	var url='city_edit.jsp?method=UPDATE&inputId='+inputId;
	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:850px;dialogHeight:330px;resizable:no");
	ds.reload();
}

function del(){
	var editGrid=L5.getCmp('GridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  dels=[];
			for(var i=0;i<selected.length;i++){
				dels[i]=selected[i].get("inputId");
			}
			var ds=L5.DatasetMgr.lookup("ds");
			var command = new L5.Command("com.inspur.cams.bpt.capital.cmd.BPTCapitalBudgetCmd");
			command.setParameter("dels", dels);
			command.execute("deleteCityBudget");
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