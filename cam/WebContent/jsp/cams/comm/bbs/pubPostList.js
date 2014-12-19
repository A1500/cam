var row_index = 0;
/*
 * 增加一行
 */
function add_row() {
	var table2 = document.getElementById("table2");
	row_index++;
	var new_row = table2.insertRow(table2.rows.length);
	new_row.setAttribute("id", "row" + row_index);
	var new_col = new_row.insertCell(0);
	new_col.innerHTML = "<input id='attach' type='file' name='filename"
			+ row_index + "' size='87' >";
	var new_col = new_row.insertCell(1);
	new_col.innerHTML = "&nbsp;<input type='button' value='删除' onclick=\"delete_row('row"
			+ row_index + "')\">";
	document.getElementById("filename" + row_index).focus();
	document.getElementById("span").innerHTML = "<font color='red'>附件大小不能超过5M</font>";
}
/*
 * 删除一行
 */
function delete_row(rname) {
	var table2 = document.getElementById("table2");
	var i;
	i = table2.rows(rname).rowIndex;
	table2.deleteRow(i);
}
function init() {
	var pubPostDataSet = L5.DatasetMgr.lookup("pubPostDataSet");
	pubPostDataSet.setParameter("STATUS", "0");
	pubPostDataSet.setParameter("sort", "IF_TOP");
	pubPostDataSet.setParameter("dir", "desc");
	pubPostDataSet.load();
	var postDS = L5.DatasetMgr.lookup("postDS");
	postDS.newRecord({
				"postOrgancode" : postOrgancode,
				"postOrganname" : postOrganname
			});
}
function query() {
	var pubPostDataSet = L5.DatasetMgr.lookup("pubPostDataSet");
	var subjectquery = document.getElementById("subjectquery").value;
	pubPostDataSet.setParameter("SUBJECT@like", subjectquery);
	pubPostDataSet.load();
}

function toSubmit() {
	var postDS = L5.DatasetMgr.lookup("postDS");
	var subject = document.getElementById("subject").value;// 标题
	if (subject == "") {
		L5.Msg.alert("提示", "请至少输入标题！");
		return;
	}
	var record = postDS.getCurrent();
	var command = new L5.Command("com.inspur.cams.comm.bbs.cmd.PubPostCmd");
	command.setParameter("record", record);
	command.setForm("form_content");
	command.execute("save");
	if (!command.error) {
		L5.Msg.alert("提示", "发帖成功！", function() {
					init();
					document.getElementById("form_content").reset();
				});
	} else {
		L5.Msg.alert("提示", "发帖出错！" + command.error);
	}
}
function postDetailHref(value, cellmeta, record, rowindex, colindex, dataset) {
	if (record.get("ifTop") == "1") {
		return '<a href="javascript:postDetail(\'' + record.data["postId"]
				+ '\',\'' + record.data["subject"] + '\')">' + value
				+ '</a><font color="red">' + "【置顶】" + '</font>';
	} else {
		return '<a href="javascript:postDetail(\'' + record.data["postId"]
				+ '\',\'' + record.data["subject"] + '\')">' + value + '</a>';
	}
}
function postDetail(postId, subject) {
//	var data = new L5.Map();
//	data.put("postId", postId);
//	data.put("subject", encodeURIComponent(encodeURIComponent(subject)));
//	var url = 'jsp/cams/comm/bbs/pubPostReplyEdit.jsp';
//	var text = '回复信息';
//	L5.forward(url, text, data);
	var _url = "pubPostReplyEdit.jsp?postId="+postId+"&subject="+encodeURIComponent(encodeURIComponent(subject));
	var width = screen.width;
	var height = screen.height;
	var returnValue = window.showModalDialog(_url, window,
			"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:0");
	query();
}
function toTop() {
	var grid = L5.getCmp("grid");
	var records = grid.getSelectionModel().getSelections();
	if (records.length == 0) {
		L5.Msg.alert("提示", "请先选中一行!");
		return;
	}
	L5.MessageBox.confirm("提示", "确定置顶该帖子？", function(sta) {
		if (sta == "yes") {
			var command = new L5.Command("com.inspur.cams.comm.bbs.cmd.PubPostCmd");
			records[0].set("ifTop", "1");
			command.setParameter("record", records[0]);
			command.execute("save");
			if (!command.error) {
				L5.Msg.alert("提示", "置顶成功！", function() {
							init();
						});
			} else {
				L5.Msg.alert("提示", "置顶出错！" + command.error);
			}
		}
	});
}
function toNotTop() {
	var grid = L5.getCmp("grid");
	var records = grid.getSelectionModel().getSelections();
	if (records.length == 0) {
		L5.Msg.alert("提示", "请先选中一行!");
		return;
	}
	var ifTop = records[0].get("ifTop");
	if (ifTop != '1') {
		L5.Msg.alert("提示", "该帖子不是置顶，无需取消");
		return;
	}
	L5.MessageBox.confirm("提示", "确定取消置顶该帖子？", function(sta) {
		if (sta == "yes") {
			var command = new L5.Command("com.inspur.cams.comm.bbs.cmd.PubPostCmd");
			records[0].set("ifTop", "0");
			command.setParameter("record", records[0]);
			command.execute("save");
			if (!command.error) {
				L5.Msg.alert("提示", "取消成功！", function() {
							init();
						});
			} else {
				L5.Msg.alert("提示", "取消出错！" + command.error);
			}
		}
	});
}
function del() {
	var grid = L5.getCmp("grid");
	var records = grid.getSelectionModel().getSelections();
	if (records.length == 0) {
		L5.Msg.alert("提示", "请先选中一行!");
		return;
	}
	L5.MessageBox.confirm("提示", "确定删除该帖子？", function(sta) {
		if (sta == "yes") {
			var command = new L5.Command("com.inspur.cams.comm.bbs.cmd.PubPostCmd");
			records[0].set("status", "2");
			command.setParameter("record", records[0]);
			command.execute("deletePost");
			if (!command.error) {
				L5.Msg.alert("提示", "删除成功！", function() {
							init();
						});
			} else {
				L5.Msg.alert("提示", "删除出错！" + command.error);
			}
		}
	});
}