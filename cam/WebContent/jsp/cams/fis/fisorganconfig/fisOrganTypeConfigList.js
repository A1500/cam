function init(){
	fisOrganTypeConfig.setParameter("sort","CEMETERY_ORGAN");
	fisOrganTypeConfig.setParameter("dir","asc");
	fisOrganTypeConfig.load();
}

function add(){
	var data = new L5.Map();
	data.put("method","insert");
	var url = "jsp/cams/fis/fisorganconfig/fisOrganTypeConfigEdit.jsp";
	L5.forward(url,"",data);
}

function update(){
	var grid=L5.getCmp("gridPanel");
	var selecteds=grid.getSelectionModel().getSelections();
	if(selecteds.length !=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var configId = selecteds[0].get("configId");
	var data=new L5.Map();
	data.put("method","update");
	data.put("configId",configId);
	var url="jsp/cams/fis/fisorganconfig/fisOrganTypeConfigEdit.jsp";
	L5.forward(url,"",data);
}

function click_delete(){
	var grid=L5.getCmp("gridPanel");
	var selecteds=grid.getSelectionModel().getSelections();
	if(selecteds.length !=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var configId=selecteds[0].get("configId");
	L5.MessageBox.confirm('提示', '确认执行删除操作吗?该操作不能恢复！', function(state) {
		if (state == "yes") {
	var cmd=new L5.Command("com.inspur.cams.fis.base.cmd.FisOrganTypeConfigCmd");
	      cmd.setParameter("configId",configId);
	      cmd.execute("delete");
	      if(!cmd.error){
	    	  L5.Msg.alert("提示","删除成功!");
	    	  var fisOrganTypeConfig=L5.DatasetMgr.lookup("fisOrganTypeConfig");
	    	  fisOrganTypeConfig.commitChanges();
	    	  
	      }else{
	    	  L5.Msg.alert("提示",cmd.error);
	      }
		}else {
			return false;
		}
		
		 var fisOrganTypeConfig=L5.DatasetMgr.lookup("fisOrganTypeConfig");
	      fisOrganTypeConfig.load();
	});
	     
}

function click_view(){
	var grid = L5.getCmp("gridPanel");
	var selecteds=grid.getSelectionModel().getSelections();
	if(selecteds.length !=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data= new L5.Map();
	      data.put("method","detail");
	      data.put("configIdDet",selecteds[0].get("configId"));
	 var url="jsp/cams/fis/fisorganconfig/fisOrganTypeConfigDet.jsp";
	 L5.forward(url,"",data);
}