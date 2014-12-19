function init() {
	L5.DatasetMgr.lookup("ds").load();
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	
	ds.setParameter("BPT_GLORIOUS_INSTITUTE.DOMICILE_CODE@like",getParam("domicileCode"));		
	ds.setParameter("BPT_GLORIOUS_INSTITUTE.UNIT_FULLNAME@=",getParam("unitFullname"));		
	ds.setParameter("BPT_GLORIOUS_INSTITUTE.PERSON_SECTION@=",getParam("personSection"));		
	ds.setParameter("BPT_GLORIOUS_INSTITUTE.PROPERTIES@=",getParam("properties"));		
	ds.load();
}

/**
* 选择属地行政区划窗口
*/
function func_ForDomicileSelect1(){
		var escapeorganName = escape(encodeURIComponent('山东省'));
		var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicCityCounty.jsp?organCode=370000000000&organName="+escapeorganName,"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue!=""&&revalue!=undefined){
			var list = revalue.split(";");
			var code = list[0].substring(4, 12);
			if(code!="00999000"){
				document.getElementById("domicileCode").value=list[0].substring(0, 6);
			}else {
				document.getElementById("domicileCode").value=list[0].substring(0, 4);
			}
			document.getElementById("domicileName").value=list[4];
		}
}
function insert() {
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/bpt/institution/gloriousInstitute/bptgloriousinstitute_insert.jsp';
	var text = '增加光荣院信息';
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
	data.put("dataBean",selected[0].get('gloriousId'));
	var url='jsp/cams/bpt/institution/gloriousInstitute/bptgloriousinstitute_edit.jsp';
	var text = '修改光荣院信息';
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
				delIds[i]=selected[i].get("gloriousId");
			}
			var command=new L5.Command("com.inspur.cams.bpt.bptinstitution.cmd.BptGloriousInstituteCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	ds.remove(selected[i]);
				}
				ds.commitChanges();
			}else{
				L5.Msg.alert('提示',"删除时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}
//重置
function reset(){
	document.getElementById("domicileCode").value = "";
	document.getElementById("unitFullname").value = "";
	document.getElementById("personSection").value = "";
	document.getElementById("properties").value = "";
}

/**
 * 事件处理：点击详细按钮,转向详细页面
 */
function Evt_butdetail_click() {
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("golriousId",selected[0].get('gloriousId'));
	var url='jsp/cams/bpt/institution/gloriousInstitute/bptgloriousinstitute_year_list.jsp';
	var text = '优抚医院信息';
	L5.forward(url,text,data);
}
function confirmValue() {
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	window.returnValue=selected[0].get("unitFullname");
	window.close();
}

function closew() {
	window.close();
}