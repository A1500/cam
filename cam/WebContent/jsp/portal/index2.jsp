<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.portal.util.PortalJspUtil" %>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ page import="org.loushang.bsp.util.BspConfig"%>
<%
String webPath=PortalJspUtil.webPath(request);
String username=GetBspInfo.getBspInfo(request).getUserName();
String collectMenuEnable= BspConfig.getString("bsp.collectmenu.enable");
if(collectMenuEnable==null)collectMenuEnable="false";
%>
<html>
<head>
  <title>楼上平台集成门户</title>
	<next:ScriptManager></next:ScriptManager>
	<link rel="stylesheet" type="text/css" href="<%=webPath %>/jsp/portal/css/portal.css" />
    <script type="text/javascript" src="<%=webPath %>/jsp/portal/js/Portal.js"></script>
	<script type="text/javascript" src="<%=webPath %>/jsp/portal/index2.js"></script>
	<style type="text/css">
	.zuo{
		width:16px;
		cursor:pointer;
		background:	url('<%=webPath %>/jsp/portal/images/theme/blue/sys_menu_left.png') no-repeat center center;
	}
	.shang{
		width:16px;
		cursor:pointer;
		background:	url('<%=webPath %>/jsp/portal/images/theme/blue/sys_menu_up.png') no-repeat center center;
	}
	.xia{
		width:16px;
		cursor:pointer;
		background:	url('<%=webPath %>/jsp/portal/images/theme/blue/sys_menu_down.png') no-repeat center center;
	}
	.you{
		width:16px;
		cursor:pointer;
		background:	url('<%=webPath %>/jsp/portal/images/theme/blue/sys_menu_right.png') no-repeat center center;
	}
	.menu{
		padding-left:15px;
		width: 100%;
		height: 23px;
		overflow:hidden;
		background:	url(images/cd.jpg) repeat-x;
	}
	.buttons{
		float:right;
		width:110px;
		height: 23px;
	}
	.buttons div{
		margin-left:5px;
		float: left;
		height: 23px;
	}
	.last{
		width:16px;
		cursor:pointer;
		background: url('<%=webPath %>/jsp/portal/images/theme/blue/sys_menu_end_left.png') no-repeat center center;
	}
	.first{
		width:16px;
		cursor:pointer;
		background: url('<%=webPath %>/jsp/portal/images/theme/blue/sys_menu_end_right.png') no-repeat center center;
	}
	.item{
		float:left;
		height: 23px;
	}
	.menuleft{
		margin-left:2px;
		float:left;
		width: 7px;
		height: 13px;
		background:	url(images/tb04.gif) no-repeat center center;
	}
	.menucenter{
		height: 23px;
		float: left;
	}
	.menuright{
		width: 3px;
		height: 23px;
		float: left;
	}
	.menucenter a{
		display:block;
		float:left;
		margin-left:1px;
		margin-right:1px;
		text-decoration:none;
		white-space:nowrap;
		font-family: 宋体,Arial;
		font-size: 12px;
		color:#e2f6ff;
		line-height: 23px;
		outline:0 none;
	}
	.menucenter a:HOVER{
		margin-top:1px;
		color: black;
	}
	.selected .menuleft{
		width: 3px;
		background:	url(images/cd-1.gif) no-repeat center center;
	}
	.selected .menucenter{
		background:	url(images/cd-2.gif) repeat-x center center;
	}
	.selected .menucenter a{
		margin-left: 15px;
		margin-right: 13px;
	}
	.selected .menucenter a:HOVER{
		color: black;
		margin-top: 0px;
		cursor: default;
	}
	.selected .menuright{
		background:	url(images/cd-3.gif) no-repeat center center;
	}
	
	</style>

	<script type="text/javascript">
	//菜单树的类型创建。
	var menuType = L5.tree.TreeRecord.create({
		name:'menuRecord',
		idField:'id',
		fields:[
			{name: 'id',type: 'string'},
			{name: 'title',type: 'string'},
			{name: 'text',type: 'string'},
			{name: 'targetframe',type: 'string'},
			{name: 'link',type: 'int'},
			{name: 'url',type: 'string'}
		]
	});
	//虚拟根节点。
	var data = {
		id:'S001',
		recordType : 'menuRecord'
	};
	var menuitme=new L5.Template(
			'<div class="item {selected}">',
			'<div class="menuleft"></div>',
			'<div class="menucenter"><a id="{id}" onclick="sysMenuClick(this)" hidefocus="true" style="cursor: pointer">{text}</a></div>',
			'<div class="menuright"></div>',
			'</div>'
		);
	//创建根节点。
	var rootData = new menuType(data,'S001');
	//DataSet创建。
	var dataSet = new L5.tree.TreeDataSet({root:rootData,id:'menu',loaders:[]});
	//收藏菜单虚拟根节点
	var collectData = {
		id:'S001',
		recordType : 'menuRecord'
	};
	//创建收藏菜单的根节点
	var collectRootData=new menuType(collectData,'S001');
	//收藏菜单DataSet创建。
	var collectDataSet = new L5.tree.TreeDataSet({root:collectRootData,id:'collectMenu',loaders:[]});
	//command回调函数。
	function callbacktest(options,success,response){
		var returns = null;
		try {
			// 通讯异常
			if (!success) {
				throw new L5.Exception(response.status, response.statusText);
			}
			var obj = L5.decode(response.responseText);
			// 业务异常
			if (obj.error) {
				var exception=new L5.Exception(obj.error.code, obj.error.msg,
						obj.error.trace)
				if(obj.error.title){//如果有自定义title，则复制给exception
					exception.title=obj.error.title;
				}
				throw exception;
			}
			// 一切正常
			returns = L5.serializer.unmarshall(obj);
		} catch (e) {
			alert(e.message);
		}
		var jsdata = returns.get("menu");
		var root = dataSet.getRoot();
		var children = jsdata.rows;
		outerChildren=children;
		//循环创建record，并且将上面的菜单处理好。
		for(var i=0,len=children.length;i<len;i++){
			var recjson = children[i];
			var rec = L5.tree.TreeRecord.createRecord('menuRecord',recjson);
			root.insert(rec);
			//设置top上面的菜单。
			menuitme.append('menu',{id:i,text:recjson['text'],split:i!=len-1?"  |  ":""});
			//menuitme.append('menu',{id:i,selected:i==0?'selected':'',text:rec.get('text'),split:i!=len-1?"  |  ":""});
		}
	 	var tree = L5.getCmp("tree");
		tree.innerCt.setVisible(false);
		if(root.getAt(0)){
		  tree.setRootNode(root.getAt(0));
		  tree.innerCt.slideIn('t', {
	        duration: .25
	    });
	   }
		var collectMenuEnable=<%=collectMenuEnable%>;
		if(collectMenuEnable==true){
		//获取收藏菜单json串
		var collectJsdata = returns.get("collectMenu");
		//获取收藏菜单根节点
		var collectRoot = collectDataSet.getRoot();
		//获取收藏菜单json数据
		var collectChildren = collectJsdata.rows;

		//循环创建record，并且将上面的菜单处理好。
		for(var i=0,len=collectChildren.length;i<len;i++){
			var recjson = collectChildren[i];
			var rec = L5.tree.TreeRecord.createRecord('menuRecord',recjson);
			collectRoot.insert(rec);
			//设置top上面的菜单。
		//	menuitme.append('menu',{id:i,selected:i==0?'selected':'',text:rec.get('text')});
		}
		//获得树，并树里增加数据
	 	var collectionTree = L5.getCmp("collectionTree");
		collectionTree.innerCt.setVisible(false);
		collectionTree.setRootNode(collectRoot);
		collectionTree.innerCt.slideIn('t', {
	        duration: .25
	    });
	    }
	}

	var config={url : L5.webPath+"/command/dispatcher/org.loushang.bsp.permit.menu.cmd.MenuXmlCommand",
			jsonData : {},
			callback : callbacktest,
			sync:false
			};
	//收藏菜单
	function collect(menuitem){
	var record = menuitem.parentMenu.record;
	var command=new L5.Command("org.loushang.bsp.permit.menu.cmd.CollectMenuCmd");
	command.setParameter("record",record);
	command.execute("collectMenu");
	//刷新页面
	if(!command.error)
	{  
	  var collectionTree = L5.getCmp('collectionTree');
	  collectionTree.root.record.insert(record);
	}
	else
	{
		L5.MessageBox.alert("消息提示","添加收藏菜单出现异常!"+command.error);
	}

	}
	//删除收藏菜单
	function detCollect(menuitem){
	var record = menuitem.parentMenu.record;
	var command=new L5.Command("org.loushang.bsp.permit.menu.cmd.CollectMenuCmd");
	command.setParameter("record",record);
	command.execute("delMenu");
	//刷新页面
	if(!command.error)
	{  
		var prec = record.parentRecord;
		if(prec){
			prec.remove(record);
		}
	}
	else
	{
		L5.MessageBox.alert("消息提示","删除收藏菜单出现异常!"+command.error);
	}

	}
	var outerChildren;
	</script>
	<style>
	.lt {
	background:url('<%=webPath %>/jsp/portal/images/theme/blue/bg_left.jpg') no-repeat;
	height:96px;
    }
   .rt {
	background:url('<%=webPath %>/jsp/portal/images/theme/blue/bg_right.jpg') no-repeat;
	height:96px;
    }
   .cirbutton{background:url('<%=webPath %>/jsp/portal/images/theme/blue/portal_menu.gif') right -60; font color:#fff;  text-decoration:none; height:23px;  cursor:hand; margin:5px 5px 0 0;padding-right:3px}
   .cirbutton:hover{background:url('<%=webPath %>/jsp/portal/images/theme/blue/portal_menu.gif') right -30px;height:23px;}
   .cirbutton span{background:url('<%=webPath %>/jsp/portal/images/theme/blue/portal_menu.gif') 0 0;  padding:5px 8px 0px 8px; margin:0 0 0 0px; float:left; height:23px;}
   .cirbutton:hover span{background:url('<%=webPath %>/jsp/portal/images/theme/blue/portal_menu.gif') 0 -30px; color:#000;  padding:5px 8px 0px 8px; margin:0 0 0 0px; height:23px;  }
	</style>
</head>
<model:datasets>
	<model:dataset id="portalWidgetDataset" cmd="org.loushang.portal.layout.cmd.PortalUserLayoutQueryCmd" global="true" method="queryCurUserPortalPageLayout">
		<model:record fromBean="org.loushang.portal.widget.data.PortalWidget"></model:record>
	</model:dataset>
	<model:dataset id="portalMenuDataset" cmd="org.loushang.portal.layout.cmd.PortalUserLayoutQueryCmd" global="true" autoLoad="true" method="queryCurUserPortalPageJson">
		<model:record fromBean="org.loushang.portal.page.data.PortalPage"></model:record>
	</model:dataset>
</model:datasets>
<body style="margin:0;padding:0;overflow-x:hidden;" >
  <next:ViewPort id="viewport">
    <next:BorderLayout>
	  <next:Top>
		<next:Panel autoHeight="true" autoScroll="false" id="top">
		  <next:Html>
            <table id="banner1" width="100%" height="96px" border="0" cellspacing="0" cellpadding="0">
             <tr>
               <td align="left" width="100%" valign="top">
                 <table width="100%"  border="0" cellpadding="0" cellspacing="0" background="<%=webPath %>/jsp/portal/images/theme/blue/bg_center.jpg">
                   <tr>
                     <td width="73%" align="left" class="lt"></td>
                     <td nowrwap="nowrap" width="27%" height="96" align="right" valign="bottom" background="<%=webPath %>/jsp/portal/images/theme/blue/portal_menu.jpg" class="rt" id="portalMenu"></td>
                   </tr>
                </table>
              </td>
             </tr>
            </table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
				<td height="25" class="topbj">
						     <table width="100%" border="0" cellspacing="0" cellpadding="0">
			                    <tr>
						         <td >
						         <div id="menu" class="menu">
									 <div id="buttons"  class="buttons">
										 <div id="firstDiv" onclick="first()" class="first" title="右滚动到底" ></div>
										 <div onclick="last()"  id="lastDiv" class="last" title="左滚动到底"></div>
							           	 <div onclick="zuo()" class="zuo" title="菜单左滚动"></div>
							             <div onclick="you()" class="you" title="菜单右滚动"></div>
							             <div onclick="shang()" id="shangdiv" class="shang" title="隐藏Logo"></div>
							             <div onclick="xia()" id="xiadiv" class="xia" title="展开Logo"></div>
						             </div>
								 </div>
								 </td>					          					        
							   </tr>
							  </table>
					       </td>		
					       <td align="right" class="topbj" width="250" height="20">
						      <table width="100%" border="0" cellspacing="0" cellpadding="0">
						        <tr>
						          <td align="right"><label id="date_time"></label>&nbsp;<label>欢迎您：</label><label id="user_name"><%=username %></label>&nbsp;</td>
						          </tr>
						      </table>
						   </td>
					    </tr>
					</table>
				</next:Html>
			</next:Panel>
			</next:Top>
			<next:Center>
			<next:Panel id="centerWidPanel" bodyStyle="background-color:#ffffff;overflow-y:auto" border="0" >
			<next:Panel id="widpanel" height="100%" width="100%" hidden="true">
				<next:BorderLayout >
				<next:Left split="true">
		  		<next:Panel id="leftPanel" width="200" height="100%" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden"
						collapsible="true" title=" ">
					<%if(collectMenuEnable.equals("true")){ %>
					<next:Panel id="collectPanel" width="100%" border="0" bodyBorder="false" title="我的收藏" 
						bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden" collapsible="true" titleCollapse="true">
						<next:ExtendConfig>
		                    		singleExpand:false,
		                    		xtype:'lstreepanel',
		                    		title: '我的收藏',
									collapsible:true,
									titleCollapse:true,
									autoScroll : true,
									id:"collectionTree",
									rootExpanded:true,
									rootVisible:false,
									lines: false,
									dataset:'collectMenu',
									nodeModels:[{
										recordType: menuType,
										attrs: [{
											name:'text',
											mapping:'text'},
											{
											name:'leaf',
											mapping:'url',	handler:function(rec){if(rec.get("url")!="")return true;else return false;}
											},
											{
											name:'cls',handler:function(rec){if(rec.getDepth()==2)return "left1";else return "left2"}}
											],
										listeners:{contextmenu:function(record,e,node){
											var menu;
											menu=L5.menu.MenuMgr.get('corp');
											if(menu==undefined){
											var items = [{text:'删除',handler:detCollect}];
											menu=new L5.menu.Menu({id:'corp1Del',items:items});
											}
											if(!menu)
											return;
											menu['node']=node;
											menu['record']=record;
											menu.showAt(e.getXY());
										}}
									}]
		  						</next:ExtendConfig>

						<next:Listeners>
							<next:Listener eventName="click" handler="leftClick"></next:Listener>
						</next:Listeners>
					</next:Panel>
					<%} %>
					<next:Panel width="100%" border="0" bodyBorder="false" title="菜单" 
						bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden" collapsible="true" titleCollapse="true">
						<next:ExtendConfig>
		                    		singleExpand:false,
		                    		xtype:'lstreepanel',
		                    		title: '菜单',
									collapsible:true,
									titleCollapse: <%=collectMenuEnable%>,
									autoScroll : true,
									id:"tree",
									rootExpanded:false,
									rootVisible:false,
									lines: false,
									dataset:'menu',
									nodeModels:[{
										recordType: menuType,
										attrs: [{
											name:'text',
											mapping:'text'},
											{
											name:'leaf',
											mapping:'url',	handler:function(rec){if(rec.get("url")!="")return true;else return false;}
											},
											{
											name:'cls',handler:function(rec){if(rec.getDepth()==2)return "left1";else return "left2"}}
											],
										listeners:{contextmenu:function(record,e,node){
											var menu;
											menu=L5.menu.MenuMgr.get('corp');
											var collectMenuEnable=<%=collectMenuEnable%>;
											if(menu==undefined&&collectMenuEnable==true&&record.get("url")!=""){
											var items = [{text:'收藏',handler:collect}];
											menu=new L5.menu.Menu({id:'corpCol',items:items});
											}
											if(!menu)
											return;
											menu['node']=node;
											menu['record']=record;
											menu.showAt(e.getXY());
										}}
									}]
		  						</next:ExtendConfig>

						<next:Listeners>
							<next:Listener eventName="click" handler="leftClick"></next:Listener>
						</next:Listeners>
					</next:Panel>

					</next:Panel>
							</next:Left>
							<next:Center>
								<next:TabPanel id="center" enableTabScroll="true" activeTab="0">
									<next:Tabs>
										<next:Panel title="首页" width="100%" closable="false" autoScroll="false" >
											<next:Html>
												<div id="loadmask" style="display: none;" class="loading"><img
													src="<%=webPath %>/skins/images/default/extanim32.gif"
													width="32" height="32" style="margin-right: 8px;" />正在加载...</div>
												<iframe id="frame1" frameborder="no" border="0" marginwidth="0"
													marginheight="0" allowtransparency="yes" width="100%"
													style="overflow: auto" height="100%" 
													src="<%=webPath%>/jsp/public/head.jsp"></iframe>
											</next:Html>
										</next:Panel>
									</next:Tabs>
								</next:TabPanel>
							</next:Center>
						</next:BorderLayout>
						</next:Panel>
						<next:Panel id="widgetContainer" width="100%" border="false"> 
						  <next:Panel xtype="portal" id="portal" width="100%" height="100%" border="false" bodyStyle="overflow-x:hidden" >
						  </next:Panel>
						  <next:Panel xtype="absportal" id="absportal" width="100%" height="100%" border="false">
						  </next:Panel>	
						</next:Panel>
						<next:Panel hidden="true" id="maxWidgetContainer" width="100%" height="100%" border="0">
						</next:Panel>
				</next:Panel>
			</next:Center>
			<next:Right split="true" >
				<next:Panel id="widgetSelector" width="200" height="100%" 
						 bodyStyle="overflow:auto;" border="0"  collapsible="true"  collapseMode="mini">
					<next:Html >
						 <iframe height="100%" width="100%" src="<%=webPath %>/jsp/portal/help/widgethelper.jsp?isFilterWidget='1'">
						 </iframe>
					</next:Html>
				</next:Panel>
			</next:Right>
		</next:BorderLayout>
	</next:ViewPort>
</body>
<script type="text/javascript">
var xmlHttp;
function createXMLHttpRequest() {
    if (window.ActiveXObject) {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    else if (window.XMLHttpRequest) {
        xmlHttp = new XMLHttpRequest();
    }
}
function startRequest(url) {
    createXMLHttpRequest();
    xmlHttp.open("GET", url, false);
    xmlHttp.send(null);
    return xmlHttp.responseText;
}
//页面加载时候使用的加载loading展现。
function loadPage(tabPanel, record) {
	var panel = tabPanel.getItem(0);
	var title=record.get("text");
	if(title)panel.setTitle(title);
	var iframes=panel.body.query('iframe');
	var loading=L5.fly('loadmask',panel.body);
	loading.setStyle("display","block");
	iframes[0].style.visibility="hidden";
	iframes[0].onload=iframes[0].onreadystatechange=function(){
	if(this.readyState=="complete"||!this.readyState){
		(function(){
			iframes[0].style.visibility="visible";
			loading.dom.style.display="none";
		}).defer(50);
		}
	}
	var url = record.get("url");
	if(url.indexOf("http")>=0||url.indexOf("www")>=0)
	{
		iframes[0].src=url;
	}
	else if(url.substring(0,1)=="/")
	{
		iframes[0].src=L5.webPath+url;
	}
	else
	{
		iframes[0].src=L5.webPath+"/"+url;
	}
}
//左边菜单的点击事件。
function leftClick(node,e){
	var record = node.record;
	var href = record.get("url");
	if(href){
		e.stopEvent();
		var tabs=L5.getCmp('center');
		loadPage(tabs, record);
	}
}
window.load=function(node){
   if(node.href){
 		var tabs=L5.getCmp('center');
 		loadPage(tabs, node.record);
 	}
};
function logout(){
    if(!confirm("您确定要退出系统吗？"))
      return ;
	document.location.href=L5.webPath+"/logout";
}

function first(){
	document.getElementById("lastDiv").style.visibility="";
	var next=L5.fly("buttons").next();
	while(!next.isVisible()){
		next=next.next();
	}
	var prev=next.prev();
	if(prev)
		prev.show();
	if(prev.prev()!=null){
		if(prev.prev().prev()==null){
			document.getElementById("firstDiv").style.visibility="hidden";
		}else{
			this.first();
		}
	}
}
function last(){
	var next=L5.fly("buttons").next();
	while(!next.isVisible()){
		next=next.next();
	}
	var last=L5.fly("menu").last();
	var anchor=last.child("a");//使用A代替div，防止半边卡住出不来。
	var left=anchor.getOffsetsTo(L5.fly("menu"));
	if(left[1]==0){
		return;
	}
	document.getElementById("firstDiv").style.visibility="";
	next.setVisibilityMode(2).hide();
	if(last.child("a").getOffsetsTo(L5.fly("menu"))[1]==0){
		document.getElementById("lastDiv").style.visibility="hidden";
	}else{
		this.last();
	}
}

function zuo(){
	var next=L5.fly("buttons").next();
	while(!next.isVisible()){
		next=next.next();
	}
	var last=L5.fly("menu").last();
	var anchor=last.child("a");//使用A代替div，防止半边卡住出不来。
	var left=anchor.getOffsetsTo(L5.fly("menu"));
	if(left[1]==0)
		return;
	next.setVisibilityMode(2).hide();
	document.getElementById("firstDiv").style.visibility="";
	if(last.child("a").getOffsetsTo(L5.fly("menu"))[1]==0){
		document.getElementById("lastDiv").style.visibility="hidden";
	}
}
function shang(){
	 document.getElementById("banner1").style.display="none";
     document.getElementById("shangdiv").style.display="none";
     document.getElementById("xiadiv").style.display="";
	var viewport = L5.getCmp("viewport");
	viewport.syncSize();
	var widpanel = L5.getCmp("widpanel");  
	if(!widpanel.hidden)
	{
		widpanel.show();
		widpanel.doLayout();
	}
}
function xia(){
	document.getElementById("banner1").style.display="";
    document.getElementById("shangdiv").style.display="";
    document.getElementById("xiadiv").style.display="none";
	 var viewport = L5.getCmp("viewport");
	 viewport.syncSize();

	var widpanel = L5.getCmp("widpanel");  
	if(!widpanel.hidden)
	{
		widpanel.show();
		widpanel.doLayout();
	}
}
function you(){ 
	var next=L5.fly("buttons").next();
	while(!next.isVisible()){
		next=next.next();
	}
	var prev=next.prev();
	if(prev)
		prev.show();
	document.getElementById("lastDiv").style.visibility="";
	if(prev.prev()!=null){
		if(prev.prev().prev()==null){
			document.getElementById("firstDiv").style.visibility="hidden";
		}
	}	
}
//初始化系统自定义事件
function initAppCustomEvent()
{
  //初始化当前时间
  initCurDate();  
  //初始化菜单左右移动
  document.getElementById("firstDiv").style.visibility="hidden";
  document.getElementById("xiadiv").style.display="none";
  //设置样式
  L5.util.CSS.swapStyleSheet("color",L5.webPath+"/jsp/portal/css/blue.css");
}
//初始化当前时间
function  initCurDate()
{
  var date=new Date();
  var s1=date.format('Y年n月j日');
  document.getElementById('date_time').innerHTML=s1;  
}

//获得门户菜单默认字体颜色
function getPortalMenuDefaultFontColor()
{
  return "#0261dd";
}

//获得选中的门户菜单字体颜色
function getPortalMenuSelectedFontColor()
{
  return "#000000";
}
//为门户菜单添加注销按钮
function appendLogOutToPortalMenu()
{
  return '<a  class="cirbutton"><span align="right" style="color:red;" onclick="logout()">注销</span></a>';
}
//点击系统菜单后，中间面板显示页面 
function sysMenuClickForward(ele)
{
	//中间面板显示系统首页 
	var tabPanel=L5.getCmp('center');
	var panel = tabPanel.getItem(0);
	panel.setTitle("首页");
	var iframes=panel.body.query('iframe');
	iframes[0].src=L5.webPath+"/jsp/public/head.jsp";	  
}
//点击门户菜单后，中间面板显示页面 
function portalMenuClickForward(ele)
{
	//中间面板显示系统首页 
	var tabPanel=L5.getCmp('center');
	var panel = tabPanel.getItem(0);
	panel.setTitle("空白页");
	var iframes=panel.body.query('iframe');
	iframes[0].src=L5.webPath+"/jsp/portal/help/blank.jsp";	  
}
</script>
<script for="window" event="onbeforeunload">
    if(document.body.clientWidth-event.clientX< 170&&event.clientY< 0||event.altKey){
		 	startRequest(L5.webPath+"/logout");
    }
</script>
</html>