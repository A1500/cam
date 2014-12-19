function init() {
    dsOrgan.setParameter("organCode",organCode);
	dsOrgan.load();
}
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}

function query(){
	//dsOrgan.setParameter("domicileCode",getParam("domicileCode"));
	dsOrgan.setParameter("organCode",organCode);
	dsOrgan.load();
}

function reset(){
	document.getElementById("domicileCode").value = "";
	document.getElementById("domicileName").value = "";
	
}

function update(){
    if(dsOrgan.getCount() ==0){
       L5.Msg.alert('提示',"请先进行查询操作!");
	   return false;
    }
    var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录进行修改!");
		return false;
	}
	var id = selected[0].get("ORGAN_CODE");
	if(id=='370000000000'&&organCode!='370000000000'){
		L5.Msg.alert("提示","无修改权限！");
		return false;
	}
	var data = new L5.Map();
	data.put("organCode",selected[0].get('ORGAN_CODE'));
	var url='jsp/cams/bpt/edoc/bptcataloguearchives.jsp';
	var text = '修改伤残人员信息';
	L5.forward(url,text,data);
}

function detail(){
	if(dsOrgan.getCount() ==0){
       L5.Msg.alert('提示',"请先进行查询操作!");
	   return false;
    }
    var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录进行查看!");
		return false;
	}
	var data = new L5.Map();
	data.put("organCode",selected[0].get('ORGAN_CODE'));
	var url='jsp/cams/bpt/edoc/bptcataloguearchivesDetail.jsp';
	var text = '查看伤残人员信息';
	L5.forward(url,text,data);
}

function add(){
    var data = new L5.Map();
	data.put("organCode",document.getElementById("domicileCode").value);
	var url='jsp/cams/bpt/edoc/bptcataloguearchivesInfo.jsp';
	var text = '修改伤残人员信息';
	L5.forward(url,text,data);
}
/**
 * 所属机构窗口
 */
function forHelp(){
		//var struId='<%=struId%>';
		var revalue=window.showModalDialog("../../../../jsp/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=1&organType=1&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
		}
}