/**
 * 页面初始化操作
 */
function init() {
	fisMattersAttention.setParameter("sort","ATTENTION_TIME");
	fisMattersAttention.setParameter("dir","desc");
	fisMattersAttention.load();
}

function updateAttention(){
	var gridAttention=L5.getCmp("gridPanel");
	var records = gridAttention.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
     var data = new L5.Map();
           data.put("method","update");
           data.put("attentionId",records[0].get("attentionId"));
     var url = "jsp/cams/fis/annocement/fisMattersAttentionEdit.jsp";
     L5.forward(url,"",data);
}

/**
 * 标题超链接
 */
/*function titleRender(title) {
	return "<a href='#' onclick='click_href()'><font color='blue'>" + title
			+ "</blue></a>";
}*/

function titleRender(value, cellmeta, record, rowindex, colindex, dataset,a,b){
	var view = value;
	return '<a href="javascript:click_title(\'' + record.get('attentionId')+'\')">'
	+ '<font style="font-weight:bold" color="blue">'+view +'</font>'+ '</a>';
}

function click_title(attentionId){
	window.location = "fisMattersAttentionDetail.jsp?attentionId="+attentionId;
}
/**
 * 事件处理：点击增加按钮
 */
function click_add() {
	var data = new L5.Map();
	data.put("method","add");
	var url = "jsp/cams/fis/annocement/fisMattersAttentionEdit.jsp";
	L5.forward(url,"",data);
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
	var attentionId = selected[0].get('attentionId');
	window.location = "fisMattersAttentionDetail.jsp?attentionId=" + attentionId + "&method=detail";
}


/**
 * 事件处理：点击删除按钮
 */
function click_delete() {
	var gridPanel = L5.getCmp('gridPanel');
	var selected = gridPanel.getSelectionModel().getSelections();
	if (selected.length !=1) {
		L5.Msg.alert('提示', "请选择一条记录！");
		return false;
	}

	L5.MessageBox.confirm('提示', '确认执行删除操作吗?该操作不能恢复！', function(state) {
		if (state == "yes") {
			var fisAttentionId= selected[0].get("attentionId");
			var command = new L5.Command("com.inspur.cams.fis.base.cmd.FisMattersAttentionCmd");
			command.setParameter("attentionId", fisAttentionId);
			command.execute("delete");
			// 如果执行没有错误,dataset接受所有修改,否则弹出错误信息：
			if (!command.error) {
				L5.Msg.alert('提示', '所选通知已成功删除！');
				fisMattersAttention.commitChanges();
			} else {
				L5.Msg.alert('提示', command.error);
			}
			fisMattersAttention.load();
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
