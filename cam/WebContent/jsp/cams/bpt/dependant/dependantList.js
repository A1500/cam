function init() {
	//L5.DatasetMgr.lookup("BaseinfoPeopleDataSet").load();
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	
	BaseinfoPeopleDataSet.setParameter("BASEINFO_PEOPLE.DOMICILE_CODE@=",getParam("domicileCode"));		
	BaseinfoPeopleDataSet.setParameter("BASEINFO_PEOPLE.NAME@=",getParam("name"));		
	BaseinfoPeopleDataSet.setParameter("BASEINFO_PEOPLE.ID_CARD@=",getParam("idCard"));		
	BaseinfoPeopleDataSet.setParameter("BASEINFO_PEOPLE.NATION@=",getParam("nation"));		
	BaseinfoPeopleDataSet.setParameter("BASEINFO_PEOPLE.MARRIAGE_CODE@=",getParam("marriageCode"));		
	BaseinfoPeopleDataSet.setParameter("BASEINFO_PEOPLE.CAREER_CODE@=",getParam("careerCode"));		
	BaseinfoPeopleDataSet.setParameter("BASEINFO_PEOPLE.POLITICAL_CODE@=",getParam("politicalCode"));		
	BaseinfoPeopleDataSet.setParameter("BASEINFO_PEOPLE.DOMICILE_TYPE@=",getParam("domicileType"));		
	BaseinfoPeopleDataSet.setParameter("BASEINFO_PEOPLE.PERSONAL_STATS_TAG@=",getParam("personalStatsTag"));		
	BaseinfoPeopleDataSet.load();
}

function reset(){
	document.getElementById("domicileCode").value = "";
	document.getElementById("name").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("nation").value = "";
	document.getElementById("marriageCode").value = "";
	document.getElementById("careerCode").value = "";
	document.getElementById("politicalCode").value = "";
	document.getElementById("domicileType").value = "";
	document.getElementById("personalStatsTag").value = "";
}
function insert() {
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/bpt/dependant/dependantInsert.jsp';
	var text = '增加基础信息_人员信息';
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
	data.put("dataBean",selected[0].get('peopleId'));
	var url='jsp/bpt/disability/baseinfopeople_edit.jsp';
	var text = '修改基础信息_人员信息';
	L5.forward(url,text,data);
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
			var  delIds=[];
			for(var i=0;i<selected.length;i++){
				delIds[i]=selected[i].get("peopleId");
			}
			var command=new L5.Command("bpt.com.inspur.cams.bpt.disability.cmd.BptBaseinfoPeopleCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	BaseinfoPeopleDataSet.remove(selected[i]);
				}
				BaseinfoPeopleDataSet.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}
