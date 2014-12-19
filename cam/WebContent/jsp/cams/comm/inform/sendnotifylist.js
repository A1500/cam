var menu;// grid右键菜单

/**
 * 页面初始化操作
 */
function init() {
	var grid = L5.getCmp('gridPanel');
	grid.on("rowdblclick", click_view);// 双击则进入明细页面
	grid.on("rowcontextmenu", rowContextMenuFun);// 右击弹出右键菜单
	var notifyDataset = L5.DatasetMgr.lookup("notifyDataset");
	notifyDataset.setParameter("sort", "SENDTIME");
	notifyDataset.setParameter("dir", "desc");
	notifyDataset.load();
}
/**
 * 右键菜单
 */
function rowContextMenuFun(grid, index, e) {
	grid.getSelectionModel().selectRow(index);
	e.stopEvent();
	e.index = index
	if (L5.isEmpty(menu)) {
		menu = new L5.menu.Menu({
			items : [{
				text : "新建",
				iconCls : 'add',
				handler : click_add
			}, {
				text : "修改",
				iconCls : 'edit',
				handler : click_update
			}, {
				text : "查看",
				iconCls : 'common-query',
				handler : click_response
			}, {
				text : "撤销",
				iconCls : 'undo',
				handler : click_undo
			}, {
				text : "删除",
				iconCls : 'remove',
				handler : click_delete
			}, {
				text : "查看",
				iconCls : "common-query",
				handler : click_view
			}, {
				text : "查询",
				iconCls : 'common-query',
				handler : click_query
			}]
		});
	};
	menu.showAt(e.getPoint());
}
/**
 * 状态信息格式化
 */
function flagRender(state) {
	if (state == "delete") {
		return "<font color='red'>已撤销</font>";
	} else {
		return "<font color='green'>有效</font>";
	}
}
/**
 * 标题超链接
 */
function titleRender(title) {

	return "<a href='javascript:click_view()'><font color='blue'>" + title
			+ "</blue></a>";
}
/**
 * 事件处理：点击增加按钮
 */
function click_add() {
	//公告窗口
	var sendWin = L5.getCmp("sendWin");
	sendWin.show();
	var form_content=L5.getDom("form_content");
	form_content.reset();
}
function click_close() {
	//公告窗口
	var sendWin = L5.getCmp("sendWin");
	sendWin.hide();
}
/**
 * 事件处理：查看明细
 */
function click_view() {
	var GridPanelOne = L5.getCmp('gridPanel');
	var selected = GridPanelOne.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录！");
		return false;
	}
	var queryid = selected[0].get('ID');
	window.location = "viewinform.jsp?queryid=" + queryid + "&page=sendpage";
}

/**
 * 事件处理：修改通知
 */
function click_edit() {
	var GridPanelOne = L5.getCmp('gridPanel');
	var selected = GridPanelOne.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录！");
		return false;
	}
	var queryid = selected[0].get('ID');
	window.location = "updatenotify.jsp?queryid=" + queryid + "&page=sendpage";
}

/**
 * 事件处理，撤销通知
 */
function click_undo() {

	var gridPanel = L5.getCmp('gridPanel');
	var selected = gridPanel.getSelectionModel().getSelections();
	if (selected.length == 0) {
		L5.Msg.alert('提示', "请选择一条或多条记录！");
		return false;
	}
	L5.MessageBox.confirm('提示', '确认执行撤销操作吗?该操作不能恢复！', function(state) {

		if (state == "yes") {
			var notifyDataset = L5.DatasetMgr.lookup("notifyDataset");
			for (var i = 0; i < selected.length; i++) {
				selected[i].set("FLAG", "delete");// 状态更改
			}
			var records = notifyDataset.getAllChangedRecords();
			if (records.length < 1) {// 没有做任何修改,返回
				L5.Msg.alert('提示', '所选通知已为【已撤销】状态，不需要再执行撤销操作！');
				notifyDataset.load();
				return false;
			}
			// 构造Command对象,并将修改的record数组作为参数,并执行
			var command = new L5.Command("com.inspur.cams.comm.inform.InformCommand");
			command.setParameter("records", records);
			command.execute("cancleInform");// 此处 command.execute("save")亦可

			// 如果执行没有错误,dataset接受所有修改,否则弹出错误信息：
			if (!command.error) {
				notifyDataset.commitChanges();
				L5.Msg.alert('提示', '所选通知已成功撤销！');
			} else {
				L5.Msg.alert('提示', command.error);
			}
			notifyDataset.load();
		} else {
			return false;
		}
	});

}
/**
 * 事件处理：点击删除按钮
 */
function click_delete() {
	var gridPanel = L5.getCmp('gridPanel');
	var selected = gridPanel.getSelectionModel().getSelections();
	if (selected.length == 0) {
		L5.Msg.alert('提示', "请选择一条或多条记录！");
		return false;
	}

	L5.MessageBox.confirm('提示', '确认执行删除操作吗?该操作不能恢复！', function(state) {
		if (state == "yes") {
			var notifyDataset = L5.DatasetMgr.lookup("notifyDataset");
			for (var i = 0; i < selected.length; i++) {
				notifyDataset.remove(selected[i]);
			}
			// 构造Command对象,并将修改的record数组作为参数,并执行
			var command = new L5.Command("com.inspur.cams.comm.inform.InformCommand");
			command.setParameter("records", selected);
			command.execute("delete");
			// 如果执行没有错误,dataset接受所有修改,否则弹出错误信息：
			if (!command.error) {
				notifyDataset.commitChanges();
				L5.Msg.alert('提示', '所选通知已成功删除！');
			} else {
				L5.Msg.alert('提示', command.error);
			}
			notifyDataset.load();
		} else {
			return false;
		}
	});
}

/**
 * 事件处理：点击查询按钮
 */
var win;// 查询窗口对象
function click_query() {
	win = L5.getCmp("organize");
	win.setPosition(300,50);
	// 显示查询窗口,动画效果，从点击处弹出
	win.show();
}
function query() {
	var notifyDataset = L5.DatasetMgr.lookup("notifyDataset");
	notifyDataset.setParameter("sendmanIdquery",document.getElementById("sendmanIdquery").value);
	notifyDataset.setParameter("titlequery",document.getElementById("titlequery").value);
	notifyDataset.setParameter("sort", "SENDTIME");
	notifyDataset.setParameter("dir", "desc");
	notifyDataset.load();
}
function undoit() {
	win = L5.getCmp("organize");
	win.hide();
}
/**
 * 事件处理：查看回执
 */
function click_response() {
	var GridPanelOne = L5.getCmp('gridPanel');
	var selected = GridPanelOne.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录！");
		return false;
	}
	var informId = selected[0].get('id');
	window.location = "informresponse.jsp?informId=" + informId;
}
/*******  *****/
 var row_index=0;
 /*
  * 增加一行
  */
  function  add_row()
  {
    var table2 = document.getElementById("table2");
	row_index++;
    var new_row=table2.insertRow(table2.rows.length);
	new_row.setAttribute("id", "row"+row_index);
	var new_col=new_row.insertCell(0);
	new_col.innerHTML="<input type='file' name='filename"+row_index+"' size='87' >";
    var new_col=new_row.insertCell(1);
    new_col.innerHTML="&nbsp;<input type='button' value='删除' onclick=\"delete_row('row"+row_index+ "')\">";
    document.getElementById("filename"+row_index).focus();
    document.getElementById("span").innerHTML="<font color='red'>附件大小不能超过5M</font>";
  }
  /*
   * 删除一行
   */
  function delete_row(rname)
  {
	var table2 = document.getElementById("table2");
    var i;
    i=table2.rows(rname).rowIndex;
    table2.deleteRow(i);
  }

/*
 * 删除左右两端空格
 */
function trim(str){

	return str.replace(/(^\s*)|(\s*$)/g, '');
}


/*
 * 执行保存前的校验
 */
function click_check(){
    //var editor=L5.getCmp('bio');
	var temp=undefined;


	//if(getParam("content").length>=2000){
	//L5.Msg.alert("提示","正文不得大于2000个字符!");
	//return false;
	//}

	if(getParam("title")==temp||trim(getParam("title"))==""){
		L5.Msg.alert("提示","通知标题不能为空!");
		return false;
	}else if(getParam("informtype")==temp||trim(getParam("informtype"))==""){
		L5.Msg.alert("提示","请选择通知类型!");
		return false;
	}else if(getParam("content")==temp||trim(getParam("content"))==""){
		L5.Msg.alert("提示","正文不能为空!");
		return false;
	}else{
		return true ;
	}

	if(getParam("title").length>=200){
	L5.Msg.alert("提示","标题不得大于200个字符!");
	return false;
	}
	if(getParam("NAME").length>=1000){
	L5.Msg.alert("提示","单位不得大于1000个字符!");
	return false;
	}
}

//根据ID获取界面控件的值
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
/*
 * 发布通知
 */
function click_save(){

	if(click_check()){

		//var editor=L5.getCmp('bio');
		var command=new L5.Command("com.inspur.cams.comm.inform.InformCommand");
		command.setParameter("title",document.getElementById("title").value);//通知标题
		command.setParameter("informtype",document.getElementById("informtype").value);//通知类型
		command.setParameter("content",document.getElementById("content").value);//通知内容
		command.setParameter("CODE",document.getElementById("CODE").value);//struId,机构ID
		command.setParameter("receiveman",document.getElementById("NAME").value);
		command.setForm("form_content");
		command.execute("insert");
		//包含有大字段的异常判断
		command.afterExecute=function(){
			if(!command.error){
			L5.Msg.alert("提示","通知发布成功!");
				var sendWin = L5.getCmp("sendWin");
				sendWin.hide();
		        init();
			}else{
		        L5.Msg.alert("提示",(command.error+'').replace("出现系统异常",""),{});
	        }
		}
	}
}
//调用"选择部门"通用帮助
function selectDept() {
	if(checkNotifyAdmin())
	{
		var url = "../common/bsp_multi_stru.jsp";
	}
	else
	{
		var url = "../common/bsp_multi_stru.jsp?rootStruId="+L5.session.getUserInfo().struId;
	}
	var win = showModalDialog(url, null,
			"scroll:no;status:no;dialogWidth:500px;dialogHeight:550px");
	if (win == null) {
		return;
	}
	var organId="";
	var struId="";
	var organName="";

	// 如果是点击的是【确定】
	if (win[0].length > 0) {

		//第一个值前面没有逗号
		organId = win[0][0];
		organName = win[1][0];
		struId=win[2][0];

		//其余值之间用逗号分隔
		if (win[0].length > 1) {
			for ( var i = 1; i < win[0].length; i++) {
				organId = organId + "," + win[0][i];
				organName = organName + "," + win[1][i];
				struId=struId+","+win[2][i];
			}
		}
	}
	document.getElementById("receivemanview").value=organName;
	document.getElementById("receiveman").value=organId;
	document.getElementById("struIds").value=struId;
	document.getElementById("receivemantype").value="organize";
}

/*
 * 实现用户多选
 */
function selectUser(){
	alert("----");
	}

//判断是否是通知管理员
function checkNotifyAdmin()
{
	var command=new L5.Command("common.AssignedRolesCommand");
	//传参数"OpionShow"
	command.setParameter("assignedRoles","NotifyAdmin");
	command.execute("checkAssignedRoles");
	if (command.error) {
		alert(command.error);
	}
	else
	{
		var states = command.getReturn("rtn");

		if(states=="1")
		{
			return true;
		}
		else
		{
			return false;
		}

	}
}


/**
 * 实现选择单位树
 */
function selectUser(flag){



L5.informSession = {};
L5.informSession.getUserInfo = function() {
	if (sameDomain && top.userInfo != null)
	 return top.userInfo;
	var command = new L5.Command("com.inspur.cams.comm.informUtil.InformSessionCmd");
	command.execute("getUserInfo");
	if (!command.error) {
		var info = command.getReturn("userInfo");
		if (sameDomain) {
			top.userInfo = info;
		}
		return info;
	} else {
		alert("用户没有登录！");
	}
}
	var userInfo=L5.informSession.getUserInfo();
    var cantCode=userInfo.cantCode;
    var cantName=userInfo.cantName;


	var url = "../../dis/createBatch/dicCity.jsp?organCode=" + cantCode
					+ "&organName=" + escape(encodeURIComponent(cantName))
					+ "&radioType=checkbox&level=3&radioMaxlevel=-2";
	var win = showModalDialog(url, null,
			"scroll:no;status:no;dialogWidth:500px;dialogHeight:550px");
	if (win == null) {
		return;
	}

	/*var id="";
	var name="";
	var id_name="";

	// 如果是点击的是【确定】
	if (win[0].length > 0) {

		//第一个值前面没有逗号
		id = win[0][0];//id1,id2,id3......
		name = win[1][0];//name1,name2,name3......
		id_name=id+"["+name+"]";//id1[name1],id2[name2],id3[name3].......

		//其余值之间用逗号分隔
		if (win[0].length > 1) {
			for ( var i = 1; i < win[0].length; i++) {
				id = id + "," + win[0][i];
				name = name + "," + win[1][i];
				id_name=id_name+","+win[0][i]+"["+win[1][i]+"]";
			}
		}
	}*/
	var list = win.split(";");
	document.getElementById("NAME").value=list[4];
	document.getElementById("CODE").value=list[0];
}

// 渲染接收单位
function receiveRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	var str = " ";
	for (var i = 0; i < receiveOrganDS.getCount(); i++) {
		if (value.indexOf(receiveOrganDS.getAt(i).get("value")) != -1) {
			str += receiveOrganDS.getAt(i).get("text") + ",";
		}
	}
	return str.substring(0, str.length - 1);
}