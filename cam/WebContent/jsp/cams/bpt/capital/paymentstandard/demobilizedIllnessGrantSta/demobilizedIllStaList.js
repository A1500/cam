function init() {
		if(organCode!= currentOrganCode){
			document.getElementById("insert").style.visibility="hidden";
			document.getElementById("update").style.visibility="hidden";
			document.getElementById("delete").style.visibility="hidden";
		}
	   ds.setParameter("counties",organCode);
	   ds.setParameter("type","42");
   	   ds.load();
	   L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}

function insert() {
    var url='jsp/cams/bpt/capital/paymentstandard/demobilizedIllnessGrantSta/demobilizedIllStaEdit.jsp';
	var text = '增加带病回乡退伍军人生活补助标准';
	var data = new L5.Map();
	data.put("method","insert");
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
			for(var i=0;i<selected.length;i++){
				counties[i]=selected[i].get("STANDARDS_CODE");
				startDates[i]=selected[i].get("START_DATE");
			}
			var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCapitalstaCommand");
			command.setParameter("counties", counties);
			command.setParameter("startDates", startDates);
			command.setParameter("type", "42");
			command.execute("deleteList");
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

function reset() {
	ds.rejectChanges();
}

function detail(){
    var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	var data = new L5.Map();
	data.put("startDate",selected[0].get('START_DATE'));
	data.put("organCode",organCode);
	var url='jsp/cams/bpt/capital/paymentstandard/demobilizedIllnessGrantSta/demobilizedIllStaDetail.jsp';
	var text = '查看带病回乡退伍军人生活补助标准';
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
	data.put("method","update");
	data.put("startDate",selected[0].get('START_DATE'));
	var url='jsp/cams/bpt/capital/paymentstandard/demobilizedIllnessGrantSta/demobilizedIllStaEdit.jsp';
	var text = '修改带病回乡退伍军人生活补助标准';
	L5.forward(url,text,data);
}