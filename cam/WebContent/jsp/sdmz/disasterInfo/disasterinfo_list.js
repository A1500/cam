function init() {
	var ds=L5.DatasetMgr.lookup("ds");
	if (organArea.substring(4, 12) == "00000000")
    { var organArea1 = organArea.substring(0, 4);
       ds.setParameter("DISASTER_INFO.REG_ORGAN_AREA@like", organArea1);}
    else if (organArea.substring(6, 12) == "000000") {  
       var organArea1 = organArea.substring(0, 6) ;
       ds.setParameter("DISASTER_INFO.REG_ORGAN_AREA@like", organArea1); }
    else if (organArea.substring(9, 12) == "000")  {
        var organArea1 = organArea.substring(0, 9);
       ds.setParameter("DISASTER_INFO.REG_ORGAN_AREA@like", organArea1); } 
    else if (!organArea.substring(9, 12) == "000") {
        var organArea1 = organArea;
       ds.setParameter("DISASTER_INFO.REG_ORGAN_AREA@like", organArea1);
 	}
 	ds.load();
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	
	ds.setParameter("DISASTER_INFO.DISASTER_TIME@=",getParam("disasterTime"));		
	ds.setParameter("DISASTER_INFO.REG_PEOPLE@LIKE",getParam("regPeople"));		
	ds.setParameter("DISASTER_INFO.REG_TIME@LIKE",getParam("regTime"));		
	ds.load();
}

function insert() {
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/sdmz/disasterInfo/disasterinfo_edit.jsp';
	var text = '增加灾情信息';
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
	data.put("dataBean",selected[0].get('disasterId'));
	var url='jsp/sdmz/disasterInfo/disasterinfo_edit.jsp';
	var text = '修改灾情信息';
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
				delIds[i]=selected[i].get("disasterId");
			}
			var command=new L5.Command("com.inspur.sdmz.disasterInfo.cmd.DisasterInfoCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
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

/**
 *  事件处理：点击重置按钮
 *  灾情上报查询清空
 *  licb
 */
function reset(){
	var form=L5.getDom("form");
	form.reset();
}

