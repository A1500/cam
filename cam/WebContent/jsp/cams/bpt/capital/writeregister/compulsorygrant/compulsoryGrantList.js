function getParam(ElementId){
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	CompulsoryGrantDataSet.setParameter("organCode",organCode);
	CompulsoryGrantDataSet.setParameter("domicileCode",getParam("domicileCode"));		
	CompulsoryGrantDataSet.setParameter("name",getParam("name"));		
	CompulsoryGrantDataSet.setParameter("idCard",getParam("idCard"));		
	CompulsoryGrantDataSet.setParameter("domicileType",getParam("domicileType"));
	CompulsoryGrantDataSet.setParameter("belongYear",getParam("belongYear"));		
	CompulsoryGrantDataSet.setParameter("composedPortrait",getParam("composedPortrait"));		
	CompulsoryGrantDataSet.load();
	noReclick(CompulsoryGrantDataSet,"queryButton");
}

function reset(){
	document.getElementById("domicileCode").value = "";
	document.getElementById("domicileName").value = "";
	document.getElementById("name").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("domicileType").value = "";
	document.getElementById("belongYear").value = "";
	document.getElementById("composedPortrait").value = "";
}

function insert() {
	var url="compulsoryGrantAdd.jsp";
	var width = screen.width-100;
    var height = screen.height-140;
 	var returnValue = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	query();
}

function update(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var regDetailId = selected[0].get('REG_DETAIL_ID');
	var peopleId = selected[0].get('PEOPLE_ID');
	var url='compulsoryGrantEdit.jsp?peopleId='+peopleId+'&regDetailId='+regDetailId;
	var width = screen.width-100;
    var height = screen.height-140;
 	var returnValue = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	query();
}

function detail(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var regDetailId = selected[0].get('REG_DETAIL_ID');
	var peopleId = selected[0].get('PEOPLE_ID');
	var url='compulsoryGrantDetail.jsp?peopleId='+peopleId+'&regDetailId='+regDetailId;
	var width = screen.width-100;
    var height = screen.height-140;
 	var returnValue = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
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
				delIds[i]=selected[i].get("REG_DETAIL_ID");
			}
			var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCompulsoryDetailsCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	CompulsoryGrantDataSet.remove(selected[i]);
				}
				CompulsoryGrantDataSet.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}

function forHelp(){
		var revalue=window.showModalDialog(L5.webPath+"/jsp/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=11,12,13&organType=0&isExact=1&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
		}
}