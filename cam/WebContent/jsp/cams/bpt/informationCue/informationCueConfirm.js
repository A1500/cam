function init() {
		var peopleFrame = L5.getDom("peopleFrame");
		peopleFrame.src = L5.webPath+ "/jsp/cams/bpt/comm/peopleDetail.jsp?peopleId="+peopleId;
}

function save(){
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptRegularInformationCueCommand"); 
	command.setParameter("PEOPLE_ID",peopleId);
	command.setParameter("OBJECT_TYPE",objectType);
	command.execute("update");	
	if (!command.error) {
		L5.MessageBox.confirm('确定', '是否对优抚对象进行状态变更？',function(state){
		if(state=="yes"){
			var data = new L5.Map();
			data.put("peopleId",peopleId);
			data.put("objectState",objectState);
			data.put("objectType",objectType);
			var url='jsp/cams/bpt/stateChangeManage/stateChangeInsert.jsp';
			var text = '修改用户状态';
			L5.forward(url,text,data);
		}else{
			L5.Msg.alert("提示","确认成功！");
			return false;
		}
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
 function back(){	 	
	var url = "jsp/cams/bpt/informationCue/informationCueList.jsp";
	var text = '返回';
	L5.forward(url,text);
 }



