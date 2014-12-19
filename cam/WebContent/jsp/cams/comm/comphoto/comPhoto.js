//页面加载后自动运行，初始化事件等操作。
function init(){
	var ds = L5.DatasetMgr.lookup("comPhotoDs");	
	ds.newRecord();
	//L5.QuickTips.init();
}


//获取组件值
function save() {
	var ds = L5.DatasetMgr.lookup("comPhotoDs");
    var records = ds.getCurrent();
    records.set("photo",document.getElementById("photoTemp").value);
	var command=new L5.Command("com.inspur.cams.comm.comphoto.cmd.ComPhotoCmd"); 
	command.setParameter("record",records);
	command.execute("save");	
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
		var url='jsp/cams/drel/mbalance/samMBalanceList.jsp';
		var text = '一站结算_住院登记';
		L5.forward(url,text);
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

