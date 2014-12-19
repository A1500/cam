function init() {
	sooDs.setParameter("local_user_name@=",userName);
	sooDs.load();
	typeds.load();
}
function getSelect(){
	var gridPanel = L5.getCmp("gridPanel");
	var sm = gridPanel.getSelectionModel();
	var cell = sm.getSelectedCell();
	L5.Msg.alert("提示","您选择了第"+(cell[0]+1)+",第"+(cell[1]+1)+"列");
}
function add(){
	sooDs.newRecord();
}
function del(){
	var gridPanel = L5.getCmp('gridPanel');
	//获取grid的选择模型并从选择模型里获取选中单元格：
	var sm = gridPanel.getSelectionModel();
	var cell = sm.getSelectedCell();
	if (cell) {
		//首先从前台移除
		var record = sooDs.getAt(cell[0]);
		sooDs.remove(record);
		//然后去后台操作数据库
		var command = new L5.Command("com.inspur.cams.comm.soo.cmd.PubCamsSooCommand");
		ids = [];
		ids[0] = record.get("id");
		command.setParameter("delIds", ids);//设置参数，key是"record"如果是删除多行的话就传递一个数组
		command.execute("delete");//执行del方法
		//如果执行没有错误,dataset接受所有修改,否则弹出错误信息：
		if (!command.error) {
			sooDs.commitChanges();//将前台的状态清空
			L5.Msg.alert("提示","删除成功！");
		}else{
			L5.Msg.alert("提示",command.error);
		}
	}
}
function undo(){
	//仅仅针对没有提交的操作才能reject
	sooDs.rejectChanges();
}
function save(){
	//获取所有被修改的record:增加的、删除的、修改的
	var records = sooDs.getAllChangedRecords();
	if(records.length<1){//没有做任何修改,返回
		L5.Msg.alert("提示","没有需要保存的数据！");
		return false;
	}
	//构造Command对象,并将修改的record数组作为参数,并执行
	var command = new L5.Command("com.inspur.cams.comm.soo.cmd.PubCamsSooCommand");
	command.setParameter("records", records);
	command.setParameter("userName", userName);
	command.execute("save");
	//如果执行没有错误,dataset接受所有修改,否则弹出错误信息：
	if (!command.error) {
		sooDs.commitChanges();
		L5.Msg.alert("提示","保存成功！");
	}else{
		L5.Msg.alert("错误",command.error);
	}
}
