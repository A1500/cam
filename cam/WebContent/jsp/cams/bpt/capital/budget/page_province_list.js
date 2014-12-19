function init() {
	var ds = L5.DatasetMgr.lookup("ds");
	ds.load();
	ds.on("load",function(){
		var centralTotal = [];
		var provinceTotal = [];
		var records = ds.getAllRecords();
		for(var i=0;i<ds.getCount();i++){
			centralTotal[i] = parseFloat((records[i].get("COMPENSATION_SUBSIDY")=='')?'0.00':records[i].get("COMPENSATION_SUBSIDY"))+
							  parseFloat((records[i].get("INSTITUTION_SUBSIDY")=='')?'0.00':records[i].get("INSTITUTION_SUBSIDY"))+
							  parseFloat((records[i].get("MEDICAL_SUBSIDY")=='')?'0.00':records[i].get("MEDICAL_SUBSIDY"))+
							  parseFloat((records[i].get("HOUSE_SUBSIDY")=='')?'0.00':records[i].get("HOUSE_SUBSIDY"));
			records[i].set("CENTRAL_TOTAL",centralTotal[i]);					  
			provinceTotal[i] = parseFloat((records[i].get("COMPENSATION_SUBSIDY1")=='')?'0.00':records[i].get("COMPENSATION_SUBSIDY1"))+
							  parseFloat((records[i].get("INSTITUTION_SUBSIDY1")=='')?'0.00':records[i].get("INSTITUTION_SUBSIDY1"))+
							  parseFloat((records[i].get("MEDICAL_SUBSIDY1")=='')?'0.00':records[i].get("MEDICAL_SUBSIDY1"))+
							  parseFloat((records[i].get("HOUSE_SUBSIDY1")=='')?'0.00':records[i].get("HOUSE_SUBSIDY1"));
			records[i].set("PROVINCE_TOTAL",provinceTotal[i]);		
			records[i].set("TOTAL",centralTotal[i]+provinceTotal[i]);	
		}
	});
	if(organCode!='370000000000'){
		document.getElementById("add").style.visibility="hidden";
		document.getElementById("edit").style.visibility="hidden";
		document.getElementById("del").style.visibility="hidden";
		return ;
	}
	L5.QuickTips.init();
}

function insert(){
	var url='province_edit.jsp?method=INSERT';
	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:900px;dialogHeight:300px;resizable:no");
	ds.reload();
}

function update(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var inputId = selected[0].get("INPUT_ID");
	var inputId1 = selected[0].get("INPUT_ID1");
	var url='province_edit.jsp?method=UPDATE&inputId='+inputId+'&inputId1='+inputId1;
	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:900px;dialogHeight:330px;resizable:no");
	ds.reload();
}

function del(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  inputId=[];
			var  inputId1=[];
			for(var i=0;i<selected.length;i++){
				inputId[i]=selected[i].get("INPUT_ID");
				inputId1[i]=selected[i].get("INPUT_ID1");
			}
			var ds=L5.DatasetMgr.lookup("ds");
			var command = new L5.Command("com.inspur.cams.bpt.capital.cmd.BPTCapitalBudgetCmd");
			command.setParameter("inputId", inputId);
			command.setParameter("inputId1", inputId1);
			command.execute("deleteProvinceBudget");
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