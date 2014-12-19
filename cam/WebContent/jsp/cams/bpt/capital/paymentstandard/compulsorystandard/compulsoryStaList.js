function init() {
	if(organCode!=currentOrganCode){
		   document.getElementById("insert").disabled=true;
		   document.getElementById("update").disabled=true;
		   document.getElementById("delete").disabled=true;
	}
	ds.setParameter("counties",organCode);
    ds.load();
	L5.QuickTips.init();
};

function getParam(ElementId){
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}

function insert() {
	var data = new L5.Map();
	data.put("method","INSERT");
    var url='jsp/cams/bpt/capital/paymentstandard/compulsorystandard/compulsoryStaAdd.jsp';
	var text = '添加义务兵优待金标准';
	L5.forward(url,text,data);
}

function del() {
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  counties=[];
			var  startDates=[];
			var  endDates=[];
			for(var i=0;i<selected.length;i++){
				counties[i]=selected[i].get("STANDARDS_CODE");
				startDates[i]=selected[i].get("START_DATE");
				endDates[i]=selected[i].get("END_DATE");
			}
			var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCapitalstaCommand");
			command.setParameter("counties", counties);
			command.setParameter("startDates", startDates);
			command.setParameter("endDates", endDates);
			command.setParameter("type", "4");
			command.execute("deleteStandardData");
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
function save() {
	var records = ds.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	var isValidate = ds.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.cmd.BptCapitalstaGeneraCommand");
	command.setParameter("records", records);
	command.execute("save");
	if (!command.error) {
		ds.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function detail(){
   var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
     }
	var data = new L5.Map();
	data.put("method","DETAIL");
	data.put("STANDARDS_COUNTIES",selected[0].get('STANDARDS_CODE'));
	data.put("START_DATE",selected[0].get('START_DATE'));
	data.put("END_DATE",selected[0].get('END_DATE'));
	var url='jsp/cams/bpt/capital/paymentstandard/compulsorystandard/compulsoryStaDetail.jsp';
	var text = '查看义务兵优待金标准';
	L5.forward(url,text,data);
}
function update(){
    var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("STANDARDS_COUNTIES",selected[0].get('STANDARDS_CODE'));
	data.put("START_DATE",selected[0].get('START_DATE'));
	data.put("END_DATE",selected[0].get('END_DATE'));
	var url='jsp/cams/bpt/capital/paymentstandard/compulsorystandard/compulsoryStaUpdate.jsp';
	var text = '修改义务兵优待金标准';
	L5.forward(url,text,data);
}
function reset(){
	ds.rejectChanges();
}


