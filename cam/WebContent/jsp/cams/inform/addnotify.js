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
 * 实现HtmlEdit
 */
function init(){
 	var top = new L5.FormPanel({
        labelAlign: 'top',
        renderTo:"htmledit",
        //title: '通知内容',
        //bodyStyle:'padding:5px 5px 0',
        width: 850,
        height:400,
        border:false,
        frame:true,
        items: [{
            xtype:'htmleditor',
            id:'bio',
           fieldLabel:'通知正文',
            height:330,
            anchor:'100%',
            fontFamilies:['宋体','隶书','黑体','楷体_GB2312','华文行楷','arial','courier','verdana'],
            sourceEdit:true
        }]
    });
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
    var editor=L5.getCmp('bio');
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
	}else if(trim(L5.getCmp('bio').getValue())==""){
		L5.Msg.alert("提示","请填写通知正文!");
		return false;
	}else if((editor.getValue()).length>=4000){
		L5.Msg.alert("提示","正文不能超过4000字!");
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

		var editor=L5.getCmp('bio');
		var command=new L5.Command("com.inspur.cams.comm.inform.InformCommand");
		command.setParameter("title",document.getElementById("title").value);//通知标题
		command.setParameter("informtype",document.getElementById("informtype").value);//通知类型
		command.setParameter("content",editor.getValue());//通知内容
		command.setParameter("CODE",document.getElementById("CODE").value);//struId,机构ID
		command.setParameter("receiveman",document.getElementById("NAME").value);
		command.setForm("form_content");
		command.execute("insert");
		//包含有大字段的异常判断
		command.afterExecute=function(){

			if(!command.error){
			L5.Msg.alert("提示","通知发布成功!");

			 var url='jsp/cams/inform/sendnotifylist.jsp';
             var text = '发件箱列表';
             L5.forward(url,text);
				//click_back();
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


	var url = "approvalsysorgantreecheckbox.jsp?cantCode="+cantCode+"&cantName="+cantName;
	var win = showModalDialog(url, null,
			"scroll:no;status:no;dialogWidth:500px;dialogHeight:550px");
	if (win == null) {
		return;
	}

	var id="";
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
	}

	document.getElementById("NAME").value=name;
	document.getElementById("CODE").value=id;
}