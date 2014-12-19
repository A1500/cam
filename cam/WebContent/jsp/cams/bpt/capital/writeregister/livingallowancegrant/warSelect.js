function init() {
	document.getElementById("objectState").value = "2";
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	BaseinfoPeopleDataSet.setParameter("domicileCode",getParam("domicileCode"));
	BaseinfoPeopleDataSet.setParameter("name",getParam("name"));
	BaseinfoPeopleDataSet.setParameter("idCard",getParam("idCard"));
	BaseinfoPeopleDataSet.setParameter("objectState",getParam("objectState"));
	BaseinfoPeopleDataSet.setParameter("domicileType",getParam("domicileType"));
	BaseinfoPeopleDataSet.setParameter("asdpNo","");
	BaseinfoPeopleDataSet.setParameter("forcesNo","");
	BaseinfoPeopleDataSet.setParameter("warTypeCode",getParam("warTypeCode"));
	BaseinfoPeopleDataSet.setParameter("organCode",organCode);
	BaseinfoPeopleDataSet.setParameter("note",getParam("note"));
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
	document.getElementById("note").value = "";
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
			var command=new L5.Command("bpt.com.inspur.cams.bpt.manage.cmd.BptPeopleWarCommand");
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

/*
 * 通用帮助
 */
function forHelp(){
	var revalue=window.showModalDialog(L5.webPath+"/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=11,12,13&organType=0&isExact=1&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];

	}
}

function detailWar(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	 
	var familyId = selected[0].get('FAMILY_ID');
	var peopleId = selected[0].get('PEOPLE_ID');
	
	var width = screen.width-200;
    var height = screen.height-150;
	var url= L5.webPath+'/jsp/cams/bpt/dataCollection/war/bptwarDetailMain.jsp?familyId='+familyId+'&peopleId='+peopleId;
	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	if (win==null) {
		return;
	}
}

function  confirmValue(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var peopleId = selected[0].get('PEOPLE_ID');
	var objectType = '51';
	var idCard = selected[0].get('ID_CARD');
	var name = selected[0].get("NAME");
	window.returnValue=peopleId+";"+objectType+";"+idCard+";"+name;
	window.close();
}

function closew(){
	window.returnValue="";
	window.close();
}