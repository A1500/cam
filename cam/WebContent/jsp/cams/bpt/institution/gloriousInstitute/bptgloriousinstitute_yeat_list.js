
var width = screen.width-200;
var height = screen.height-240;
function init() {
	ds.setParameter("GLORIOUS_ID@=",golriousId);
	GloriousDs = L5.DatasetMgr.lookup("ds").load();
	L5.QuickTips.init();
}
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
		var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicCityCounty.jsp?organCode=370000000000&organName=山东省","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
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
	var url=L5.webPath+"/jsp/cams/bpt/institution/gloriousInstitute/bptgloriousinstitute_insert.jsp?method=INSERT";
	var text = '增加光荣院信息';
	var reValue =window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	
	
}

function update(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	
	var url=L5.webPath+"/jsp/cams/bpt/institution/gloriousInstitute/bptgloriousinstitute_edit.jsp?years="+selected[0].get('years')+"&method=UPDATE"+"&dataBean="+selected[0].get('gloriousId');
	window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
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
	var url=L5.webPath+"/jsp/cams/bpt/institution/gloriousInstitute/bptgloriousinstitute_detail.jsp?dataBean="+selected[0].get('gloriousId')+"&method=UPDATE"+"&years="+selected[0].get('years');
	window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
}
//插入新的年度
function insertDetail() { 
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length==1){
		var years = selected[0].get("years");
	}else{
		var years ='';
	}
	
	var url=L5.webPath+"/jsp/cams/bpt/institution/gloriousInstitute/bptgloriousinstitute_insertnew.jsp?method=INSERT&dataBean="+golriousId+"&year="+years;
	var reValue = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	
	if(reValue=='1'){
	init();
	}
}
//删除年度信息
function gloriousDel(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  idList=[];
			for(var i=0;i<selected.length;i++){
				idList[i]=selected[i].get("id");
			}
			var command=new L5.Command("com.inspur.cams.bpt.bptinstitution.cmd.BptGloriousInstituteCommand");
			command.setParameter("idList", idList);
			command.execute("gloriousDelete");
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
