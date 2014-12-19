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
	var domicileCode = getParam("domicileCode");
	var name = getParam("name");
	var idCard = getParam("idCard");
	var ageBegin = getParam("ageBegin");
	var ageEnd = getParam("ageEnd");
	var objectState = getParam("objectState");
	var objectType = getParam("objectType");
	
	BaseinfoPeopleDataSet.setParameter("domicileCode",domicileCode);
	BaseinfoPeopleDataSet.setParameter("name",name);
	BaseinfoPeopleDataSet.setParameter("idCard",idCard);	
	BaseinfoPeopleDataSet.setParameter("ageBegin",ageBegin);	
	BaseinfoPeopleDataSet.setParameter("ageEnd",ageEnd);	
	BaseinfoPeopleDataSet.setParameter("objectState",objectState);	
	BaseinfoPeopleDataSet.setParameter("objectType",objectType);	
	BaseinfoPeopleDataSet.load();
}

function reset(){
	document.getElementById("domicileCode").value = "";
	document.getElementById("domicileName").value = "";
	document.getElementById("name").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("ageBegin").value = "";
	document.getElementById("ageEnd").value = "";
	document.getElementById("objectState").value = "";
	document.getElementById("objectType").value = "";
}
function insert() {
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/bpt/demobilized/demobilizedInsert.jsp';
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
	data.put("peopleId",selected[0].get('PEOPLE_ID'));
	var url='jsp/cams/bpt/demobilized/demobilizedEdit.jsp';
	var text = '修改基础信息_人员信息';
	L5.forward(url,text,data);
}
function detail(){
    var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","DETAIL");
	data.put("peopleId",selected[0].get('PEOPLE_ID'));
	var url='jsp/cams/bpt/demobilized/demobilizedDetail.jsp';
	var text = '修改基础信息_人员信息';
	L5.forward(url,text,data);
}
function del(){
	/*var editGrid=L5.getCmp('editGridPanel');
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
	});*/
}
function forHelp(){
var struId='<%=struId%>';
var revalue=window.showModalDialog("../../../../jsp/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=1&organType=1&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
if(revalue!=""&&revalue!=undefined){
var list = revalue.split(";");
document.getElementById("domicileCode").value = list[0];
document.getElementById("domicileName").value = list[1];
}
}