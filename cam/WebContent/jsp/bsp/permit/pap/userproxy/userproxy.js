var page;
if(!page) page = {};
page.user_type='user';// 表示是委托用户还是代理用户
page.partProxyWin;// 选择用户代理权限的通用帮助
page.param = {// 规范页面的变量值
	dptTypeCode:'2',// /遵循1268的规则
	corpTypeCode:'1',// 同上
	struKey:'struId',
	rootStruName:'我的单位',
	organType:'organType',
	struRecord:'struRecord',
	yes:'y',
	no:'n',
	update:'update',
	remove:'delete',
	okMsg:'保存成功',
	prompts:'提示：'
}
// 记录一些业务规则和相关操作
page.book={};
page.proxyTypeMap={
	0:'userProxy',
	1:'partProxy',
	2:'builtInProxy'
}
page.cmd ={
	userProxy:'org.loushang.bsp.permit.pap.userproxy.cmd.UserProxyCommand',
	proxyPmsion:'org.loushang.bsp.permit.pap.userproxy.cmd.ProxyPermissionCommand',
	proxyPmsionItm:'org.loushang.bsp.permit.pap.userproxy.cmd.ProxyPermissionItemCommand'
}
page.cmdMethod={
	addUserProxy:'addUserProxy'
}
page.cmdHelper=function(cmd,okMsg){
    if(!cmd.error){
    	if(okMsg){
       		 L5.Msg.alert(page.param.prompts,okMsg);
    	}
		return true;

    }else{
        L5.Msg.alert(page.param.prompts,cmd.error);
		return false;
    }
}
page.proxyManager={
	// 全代理
	userProxy:{
		responseProxyType: function(){
			document.getElementById('partProxy_input').style.display = 'none';
			userProxyDst.getCurrent().set('proxyType','0');
		},
		save:function(){
			var cmd = new L5.Command(page.cmd.userProxy);
			cmd.setParameter('rcd',userProxyDst.getAt(0));
			cmd.setParameter('userProxy',page.param.yes);
			cmd.execute(page.cmdMethod.addUserProxy);
			if(page.cmdHelper(cmd,page.param.okMsg)){
				userProxyDst.commitChanges();
			}
		}
	},
	// 部分代理
	partProxy:{
		responseProxyType:function(){
			userProxyDst.getCurrent().set('proxyType','1');
			partProxyDst.setParameter('userId',jsp_userId);
			partProxyDst.load();
			page.partProxyWin.show();
		},
		save:function(){
			var cmd = new L5.Command(page.cmd.userProxy);
			cmd.setParameter('rcd',userProxyDst.getAt(0));
			cmd.setParameter('userProxy',page.param.no);
			cmd.execute(page.cmdMethod.addUserProxy);
			if(page.cmdHelper(cmd,page.param.okMsg)){
				userProxyDst.commitChanges();
			}
		}
	},
	// 内置代理
	builtInProxy:{
		responseProxyType:function(){

		},
		save:function(){
		}
	}

}

function init(){
	if(pageMode == "1"){//新增权限委托
	    L5.getCmp('updatePanel').hide();
	    L5.getCmp('insertPanel').show();
		userProxyDst.newRecord({userId:jsp_userId,startTime:currentDateTime,endTime:nextTowMonthDateTime});

	}else if(pageMode == "3"){//修改权限委托
	   L5.getCmp('insertPanel').hide();
	   L5.getCmp('updatePanel').show();
	   userProxyDst.on('load',function(){// 加载完后下拉框默认显示代理
			var options = document.getElementById("proxyType").options;
			var rcd = userProxyDst.getAt(0);
			var proxyType = rcd.get('proxyType');
			if(proxyType == "0"){// 是全代理
				options[0].selected = true;
				L5.fly('proxyType1').dom.value=options[0].text;
				return;
			}else if(proxyType=="1"){
				document.getElementById("proxyType").value="1";
				var leng = options.length;
				for(var i=1; i<leng; i++){
				    // 找出和代理id一致的选项
					if(options[i].value == userProxyDst.getAt(0).get('proxyPermissionId')){
						//options[i].selected = true;
						//document.getElementById("proxyType1").value=options[i].text;
						L5.fly('proxyType1').dom.value=options[i].text;
						break;
					}
				}
			}
		});
		userProxyDst.setParameter('USER_ID@=',jsp_userId);
		userProxyDst.setParameter('PROXY_USER_ID@=',proxyUserId);
		userProxyDst.setParameter('PROXY_TYPE@=',proxyType);
		userProxyDst.load();
		var data = page.userPartPermission(jsp_userId);
	    page.putPermissionIntoOptions(data);
	}
	var data = page.userPartPermission(jsp_userId);
	page.putPermissionIntoOptions(data);
	page.partProxyWin =  L5.getCmp('partProxyWinId');
	page.userWin = L5.getCmp('userTreeWin');

}
function turnback(){
	L5.forward('jsp/bsp/permit/pap/userproxy/userproxy_query.jsp','用户代理');
}
function synFiled(){
	var rcd = userProxyDst.getCurrent();

	var v = document.getElementById('proxyType').value;//
	if(v==="0"){// 全代理，要清空代理权限
		rcd.set('proxyType',"0");
		rcd.set('proxyPermissionId',"");
	}else {// 部分代理，添加代理权限
		rcd.set('proxyType',"1");
		rcd.set('proxyPermissionId',v);
	}
}

function getNodeType(record){
	if(record.isRoot)	return "isRoot";
		return record.recordType;
}

/*
 * 保存
 */
function saveProxy(){
	if(userProxyDst.getAllChangedRecords().length < 1){
		L5.MessageBox.alert('提示：','没有需要保存的内容');
		return ;
	}
	var startTime = document.getElementById("startTime").value;
	var endTime = document.getElementById("endTime").value;
	var proxyType = document.getElementById("proxyType").value;
	var proxyUserId=document.getElementById("proxyUserId").value;
	//L5.fireEvent(startTime,"blur");
	//L5.fireEvent(endTime,"blur");
	//L5.fireEvent(proxyType,"blur");
	
	if(/^\s*$/.test(proxyUserId)){
	   L5.MessageBox.alert('提示：','代理人不能为空！');
	   return ;
	}
	if(startTime>endTime){
		L5.MessageBox.alert('提示：','生效日期不能大于失效日期！');
		return;
	}
	
    if(proxyType!="0"){
      proxyType=1;
    }
	// 数据绑定
	var command = new L5.Command("org.loushang.bsp.permit.pap.userproxy.cmd.UserProxyCommand");
	var record=userProxyDst.getCurrent();
	record.set("proxyType",proxyType);
	record.set("startTime",startTime);
	record.set("endTime",endTime);
	command.setParameter("rcd", record);
	if(pageMode=='1'){
		command.execute("addUserProxy");
		//pageMode='3';
	}else if(pageMode=='3'){
		command.execute("updateUserProxy");
	}
	if (!command.error) {
		L5.MessageBox.alert('提示：','保存成功');
	}else{
		L5.MessageBox.alert('提示：',command.error);
	}
}

/*
 * 用户通用帮助
 */
function getUser(src){
	if(src.id=="proxyUserIdImg"){
		page.user_type = 'proxyUser';
	}else if(src.id=="userIdImg"){
		page.user_type = 'user';
	}
    var userId=window.showModalDialog("../user/selectuser.jsp","","dialogHeight:500px;dialogWidth:400px;resizable:no;scroll:no;status:no");
    // 切换了委托用户，刷新权限的下拉框 
    if(userId!=undefined&&userId!=null){
		if(page.user_type=='proxyUser'){
			userProxyDst.set('proxyUserId',userId);
		}else if(page.user_type=='user'){
			userProxyDst.set('userId',userId);
			var data = page.userPartPermission(userId);
			page.putPermissionIntoOptions(data);
		}
    }
}


function struLoaderTrigger(record){
	var rcdTp = record.recordType;
	if(rcdTp == "struRecord"){
		var organType = record.get('organType');
		var type = parseInt(organType.substring(0, 1));
		if(type == 0 || type == 1 || type == 2){
			return true;
		}
	}
	return false;
}
function getParentId(rcd){
	return rcd.get('organId');
}
function showImage(){
	return L5.webPath+"/skins/images/l5/users.gif"
}
function isLeaf(rcd){
	 return rcd.recordType == 'userRecord';
}

// 获取用户的部分权限
page.userPartPermission = function(userId){
	var command = new L5.Command("org.loushang.bsp.permit.pap.userproxy.cmd.ProxyPermissionCommand");
		command.setParameter("userId", userId);
		command.execute("getUserCreatedProxyPermission");
		var returnData = command.getReturn("returnData");
		return returnData.list;// 后台传回来的list到前台被一个对象封装了
}
// 把用户的部分权限加到下拉框上
page.putPermissionIntoOptions=function(permissions){
		var options = document.getElementById("proxyType").options;
		options.length = 1;
		var leng = permissions.length;
		for(var i=0;i<leng;i++){
			options.add(new Option(permissions[i].proxyPermissionName,permissions[i].proxyPermissionId));
		}
}

function letUserRadioed(rcd){
	if(rcd.get(page.param.organType)=='8'){
		return 'radiobox';
	}
}
// end for pop user tree
function announceProxyType(el){
	var  proxyType = page.proxyTypeMap[el.value];
	if (proxyType) {
		page.curProxyType = proxyType;
		page.proxyManager[proxyType].responseProxyType();
	}
	else {
		L5.Msg.alert(page.param.prompts,'代理类型不正确');
	}
}
function popPartProxyAgain(){
	var  proxyType = page.proxyTypeMap['1'];
	if (proxyType) {
		page.curProxyType = proxyType;
		page.proxyManager[proxyType].responseProxyType();n
	}
}
// 选择部分权限“确定”按钮的相应函数
function confirmPartProxy(){
	var rcds = L5.getCmp('partProxyPanId').getSelectionModel().getSelections();
	if(rcds.length < 1) {
		L5.Msg.alert(page.param.prompts,'没有选择部分委托');
		return;
	}
	userProxyDst.getAt(0).set('proxyPermissionId',rcds[0].get('id'));
	// make show
	var el = document.getElementById('partProxy_input');
	el.value = rcds[0].get('name');
	el.style.display = "";
	page.partProxyWin.hide();
	// dosomething
}
// //选择部分权限“取消”按钮的相应函数
function cancelPartProxy(){
	page.partProxyWin.hide();
}


