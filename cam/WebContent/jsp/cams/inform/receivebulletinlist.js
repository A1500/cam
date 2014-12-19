var menu;//grid右键菜单

function init(){
	
	var grid=L5.getCmp('gridPanel');
	grid.on("rowdblclick",click_view);//添加双击事件
	grid.on("rowcontextmenu",rowContextMenuFun);//右击弹出右键菜单
	var notifyDataset = L5.DatasetMgr.lookup("notifyDataset")
	notifyDataset.setParameter("informtype","bulletin");
	notifyDataset.load();
}
/**
 * 右键菜单
 */
function rowContextMenuFun(grid,index,e){
	grid.getSelectionModel().selectRow(index);
	e.stopEvent();
	e.index=index
	if (L5.isEmpty(menu)) {
		menu = new L5.menu.Menu({
    		items: [
    		        {
    		        text   : "查看",
    		        iconCls:'common-query',
    		        handler: click_view
        		},
        		{
            		text   : "查询",
            		iconCls:'common-query',
           			handler: click_query
            	},
                {
                    text   : "删除",
                    iconCls:'remove',
                   	handler: click_delete
                 }
        		]
		});
	};
	menu.showAt(e.getPoint());
}
/**
 * 显示格式化:提示信息格式化
 */
function cautionRender(state){
	if(state=="0"){
		var url = L5.webPath;
		return "<img src='"+ url +"/jsp/ecgap/image/new.gif'/>";
	}else{
		return "已阅";
	}
}
/**
 * 标题超链接
 */
function titleRender(title){
	
	return "<a href='javascript:click_view()'><font color='blue'>"+title+"</blue></a>";
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
	window.location = "viewinform.jsp?queryid=" + queryid + "&page=bulletinreceivepage";
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
			for ( var i = 0; i < selected.length; i++) {
				notifyDataset.remove(selected[i]);
			}
			// 构造Command对象,并将修改的record数组作为参数,并执行
			var command = new L5.Command("inform.InformCommand");
			command.setParameter("records", selected);
			command.execute("deleteInformPrivileges");
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
	notifyDataset.setParameter("titlequery",document.getElementById("titlequery").value);	
	notifyDataset.setParameter("sendmanquery",document.getElementById("sendmanquery").value);
	notifyDataset.setParameter("informtype","bulletin");
	notifyDataset.setParameter("query","query");
	notifyDataset.load();
}
function undoit() {
	win = L5.getCmp("organize");
	win.hide();
}
