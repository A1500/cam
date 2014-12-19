<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/loushang-bsp" prefix="bsp"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ page import="org.loushang.bsp.util.BspConfig"%>
<%@ taglib uri="/tags/loushang-bsp" prefix="bsp"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="com.inspur.cams.sorg.util.SomLoginHeadMsg"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ page import="com.inspur.cams.bpt.manage.cmd.BptNotRemindCommand" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>

<%
	request.getSession().setAttribute("_menuType", request.getParameter("_menuType"));
	String _menuType = request.getParameter("_menuType");
	String topPic = request.getParameter("_topPic");
	String verMargin = request.getParameter("_verMargin");
	String mainPic = request.getParameter("_mainPic");
    if(mainPic!=null && "".equals(mainPic.trim())){
        mainPic="/jsp/public/head.jsp";
    }
	String username = GetBspInfo.getBspInfo(request).getUserName();
	String userId = GetBspInfo.getBspInfo(request).getUserId();
	String collectMenuEnable= BspConfig.getString("bsp.collectmenu.enable");
	if(collectMenuEnable==null)collectMenuEnable="false";
	String updatepwdmsg=(String)request.getSession().getAttribute("pwdUpdateTimeMsg");
	//是否开启菜单缓存
	String menuCacheEnable = BspConfig.getString("bsp.menucache.enable");

	String currentOrganId = BspUtil.getEmpOrganId();//获取当前登录人organId
	List<Map<String,Object>> msgList = new ArrayList<Map<String,Object>>();
	//判断当前登录人是否有社会组织基本角色,如果有社会组织基本角色则加载代办列表数据
	if(_menuType.equals("0000000004")){
		SomLoginHeadMsg msg = new SomLoginHeadMsg();
		msgList = msg.getDaiBanList(currentOrganId);
	}

%>
<%@page import="java.util.ArrayList"%>
<html>
<head>
<link rel="shortcut icon" type="image/x-icon" href="jsp/public/subsysimg/favicon.ico" />
<link rel="icon" type="image/x-icon" href="jsp/public/subsysimg/favicon.ico" />
<title>山东民政“金民工程”综合业务管理平台</title>
<next:ScriptManager/>
<bsp:menuCache/>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/public/index.css" />
<style type="text/css">
    #txt{

 height:300px;
  width:300px;
  border:1px solid #333333;
  text-align:center;
  position:relative

}
 #txt p{
  position:absolute;
  bottom:0px;
  padding:0px;
  margin:0px
 }
 .back{
	float:left;
	width: 16px;
	height: 13px;
	margin-left:10px;
	background:	url(images/tb08-1.gif) no-repeat;
}
    .pics{float:right;}
    .right1{background: none}
    .right2{background: none}
    .left{width:100%;background: url(subsysimg/top01.jpg) no-repeat #016fce}
    .verText{float:left;font-size:12pt;margin-top:45px;margin-left:<%=verMargin %>px;color:#ffffff;font-weight:bold}
    <%
    if(topPic!=null&&!"".equals(topPic.trim())){
    %>
    .left{background: url(subsysimg/<%=topPic%>) no-repeat #016fce}
    <%
    }
    %>
</style>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/chart/HighCharts/jquery.min.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"jquery.messager.js")%>'></script>
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
	if(url.indexOf("http")==0||url.indexOf("www")>=0)
	     iframes[0].src =url;
	else
	iframes[0].src=L5.webPath+"/"+record.get("url");
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
  	document.location.href="<%=request.getContextPath() %>/logout";
}
function back(){
	window.location.href=L5.webPath+"/jsp/public/main.jsp";
}

function  head(){
	var tabPanel=L5.getCmp('center');
	var panel = tabPanel.getItem(0);
	panel.setTitle("首页");
	var iframes=panel.body.query('iframe');
	iframes[0].src=L5.webPath+"<%=mainPic%>";
}

function updatepwd(){
  var tabPanel=L5.getCmp('center');
  var panel = tabPanel.getItem(0);
  panel.setTitle("修改密码");
  var iframes=panel.body.query('iframe');
  iframes[0].src=L5.webPath+"/jsp/bsp/permit/pap/user/user_updatepasswd.jsp";
}



//top上面菜单的点击事件。
function topclick(link){
	L5.fly("menu").child(".selected").removeClass("selected");
	L5.fly(link).parent(".item").addClass("selected");
		var tree = L5.getCmp("tree");
	tree.innerCt.setVisible(false);
	tree.setRootNode(rootData.getAt(link.id));
	tree.innerCt.slideIn('t', {
           duration: .30,
           easing:'easeIn'
       });

	var record=rootData.getAt(link.id);
	//非叶子菜单增加触发URL功能后，在点击菜单按钮时，需要先检测该菜单按钮是否有URL
	var tabs=L5.getCmp('center');
	if(record && record.get("url")){
		loadPage(tabs, record);
	}else{
		record.set("url","<%=mainPic%>");
		record.set("text","首页");
		loadPage(tabs, record);
	}
}
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
		{name: 'url',type: 'string'},
		{name: 'isLeaf',type: 'boolean'}
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
	'<div class="menucenter"><a id="{id}" onclick="topclick(this)" hidefocus="true" href="#">{text}</a></div>',
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
		<%
			if(menuCacheEnable != null && "true".equals(menuCacheEnable)){
		%>
			var obj = L5.decode(response.responseText.substring(15,response.responseText.length-1));
		<%}else{%>
			var obj = L5.decode(response.responseText);
		<%}%>
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
	buildMenu(returns);
}


//组装菜单
function buildMenu(data){
	var jsdata = data.map.menu;
	var root = dataSet.getRoot();
	var children = jsdata.rows;
	//循环创建record，并且将上面的菜单处理好。
	for(var i=0,len=children.length;i<len;i++){
		var recjson = children[i];
		var rec = L5.tree.TreeRecord.createRecord('menuRecord',recjson);
		root.insert(rec);
		//设置top上面的菜单。
		menuitme.append('menu',{id:i,selected:i==0?'selected':'',text:rec.get('text')});
	}
 	var tree = L5.getCmp("tree");
	tree.innerCt.setVisible(false);
	if(root.getAt(0)!==""&&root.getAt(0)!==undefined&&root.getAt(0)!==null){
	  tree.setRootNode(root.getAt(0));
	  tree.innerCt.slideIn('t', {
        duration: .25
    });
   }
	var collectMenuEnable=<%=collectMenuEnable%>;
	if(collectMenuEnable==true){
	//获取收藏菜单json串
	var collectJsdata = menuData.map.collectMenu;
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
 L5.forward("jsp/public/main.jsp","");
}
//删除收藏菜单
function detCollect(menuitem){
var record = menuitem.parentMenu.record;
var command=new L5.Command("org.loushang.bsp.permit.menu.cmd.CollectMenuCmd");
command.setParameter("record",record);
command.execute("delMenu");
//刷新页面
 L5.forward("jsp/public/main.jsp","");
}

</script>
</head>
<body>
<%if(_menuType.equals("0000000004")){%>
<DIV id=eMeng style="BORDER-RIGHT: #455690 1px solid; BORDER-TOP: #a6b4cf 1px solid; Z-INDEX:99999; LEFT: 0px; VISIBILITY: hidden; BORDER-LEFT: #a6b4cf 1px solid; WIDTH: 400px; BORDER-BOTTOM: #455690 1px solid; POSITION: absolute; TOP: 0px; HEIGHT: 219px;">
	<TABLE style="BORDER-BOTTOM: #ffffff 1px solid; BORDER-LEFT: #ffffff 1px solid" cellSpacing=0 cellPadding=0 width="100%" bgColor=#cfdef4 border=0>
		<TR>
			<TD style="FONT-SIZE: 12px; BACKGROUND-IMAGE: url(msgTopBg.gif); COLOR: #0f2c8c" width=30 height=30></TD>
			<TD style="FONT-WEIGHT: normal; FONT-SIZE: 12px; BACKGROUND-IMAGE: url(msgTopBg.gif); COLOR: #1f336b; PADDING-TOP: 4px;PADDING-left: 4px" vAlign=center width="100%"> 消息提示：</TD>
			<TD style="BACKGROUND-IMAGE: url(msgTopBg.gif); PADDING-TOP: 2px;PADDING-right:2px" vAlign=center align=right width=19><span title=关闭 style="CURSOR: hand;color:red;font-size:12px;font-weight:bold;margin-right:4px;" onclick=closeDiv() >×</span><!-- <IMG title=关闭 style="CURSOR: hand" onclick=closeDiv() hspace=3 src="msgClose.jpg"> --></TD>
		</TR>
	</TABLE>
	<DIV style="POSITION: absolute;overflow-y:scroll;Z-INDEX:99999; LEFT: 0px; WIDTH: 400px; HEIGHT: 185px; BACKGROUND-COLOR: #cfdef4">
		<TABLE style="BORDER-LEFT: #ffffff 1px solid" cellSpacing=0 cellPadding=0 width="100%" bgColor=#cfdef4 border=0 >
			<TBODY>
				<%if(msgList.size()>0){%>
				<TR>
					<TD style="PADDING-RIGHT: 1px; BACKGROUND-IMAGE: url(1msgBottomBg.jpg); PADDING-BOTTOM: 1px" colSpan=3>
						<DIV  class='div' style="PADDING-RIGHT: 13px; PADDING-LEFT: 13px; FONT-SIZE: 12px; PADDING-BOTTOM: 13px; WIDTH: 100%; COLOR: #1f336b; PADDING-TOP: 18px; HEIGHT: 100%">共有<span style="color:red"><%=msgList.size()%></span>条待办任务需要处理：
						</DIV>
					</TD>
				</TR>
				<%for(int k=0;k<msgList.size();k++){%>
				<TR>
					<TD style="PADDING-RIGHT: 1px; BACKGROUND-IMAGE: url(1msgBottomBg.jpg); PADDING-BOTTOM: 1px" colSpan=3>
						<DIV  class='div' style="PADDING-RIGHT: 13px; PADDING-LEFT: 13px; FONT-SIZE: 12px; PADDING-BOTTOM: 10px; WIDTH: 100%; HEIGHT: 100%; COLOR: #1f336b;">&nbsp&nbsp&nbsp&nbsp<%=msgList.get(k).get("TYPE_NAME")%>的<%=msgList.get(k).get("ACT_DEF_NAME")%>环节<span style="color:red"><%=msgList.get(k).get("COUNT")%></span>条
							<DIV align=center style="word-break:break-all"></DIV>
						</DIV>
					</TD>
				</TR><%} }else { %>
				<TR>
					<TD style="PADDING-RIGHT: 1px; BACKGROUND-IMAGE: url(1msgBottomBg.jpg); PADDING-BOTTOM: 1px" colSpan=3 height=185>
						<DIV  class='div' style="PADDING-RIGHT: 13px; PADDING-LEFT: 13px; FONT-SIZE: 12px; PADDING-BOTTOM: 13px; WIDTH: 100%; COLOR: #1f336b; PADDING-TOP: 18px; HEIGHT: 100%">目前没有待办任务需要处理!
						</DIV>
					</TD>
				</TR>
				<%} %>
			</TBODY>
		</TABLE>
	</DIV>
</DIV>
<%} %>
<next:ViewPort id="viewport">
	<next:BorderLayout>
		<next:Top>
			<next:Panel autoHeight="true" autoScroll="false" id="top">
				<next:Html>
					<div id="nomenu">
					<div class="left">
					<div class="right2">
					<div class="pics">
					<div class="top"></div>
					<a hidefocus="true" href="javascript:head()">首页</a>
					<div class="out"></div>
					<a hidefocus="true" href="javascript:logout()">注销</a>
					<div class="back"></div>
					<a hidefocus="true" href="javascript:back()">返回</a></div>
					</div>
					<div class="verText">
					</div>
					<div style="float:right;font-size:10pt;margin-top:55px;margin-right:10px;vertical-align:bottom;">
					<%
					if(updatepwdmsg!=null&&!updatepwdmsg.equals("")){
					%>
					<p align="center"><font color="red"><%=updatepwdmsg%></font>
					<a hidefocus="true" href="javascript:updatepwd()">【修改密码】</a></p>
					<%
					}else{
					%>

					<p ><font color="#000000" ><%=username%>您好，欢迎光临</font></p>
					<%
					}
					%>
					</div>
					</div>

					</div>
					<div id="menu" class="menu">
					<div id="buttons" class="buttons">
					<div onclick="zuo()" class="zuo" title="左移菜单"></div>
					<div onclick="you()" class="you" title="右移菜单"></div>
					<div onclick="shang()" class="shang" title="上缩进"></div>
					<div onclick="xia()" class="xia" title="下展开"></div>
					</div>
					</div>
				</next:Html>
			</next:Panel>
		</next:Top>
		<next:Left split="true">
		<next:Panel id="leftPanel" width="200" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:auto"
				collapsible="true" title=" " height="100%">
			<%if(collectMenuEnable.equals("true")){ %>
			<next:Panel  bodyBorder="false" title="收藏菜单">
				<next:ExtendConfig>
                    		singleExpand:false,
                    		xtype:'lstreepanel',
                    		title: '收藏菜单',
							collapsible:true,
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
									mapping:'isLeaf',handler:function(rec){if(rec.get("isLeaf") && rec.get("isLeaf") == "true")return true;else return false;}
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
			<next:Panel   bodyBorder="false" title="菜单" >
				<next:ExtendConfig>
                    		singleExpand:false,
                    		xtype:'lstreepanel',
                    		title: '菜单',
							collapsible:true,
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
									mapping:'isLeaf',handler:function(rec){if(rec.get("isLeaf") && rec.get("isLeaf") == "true")return true;else return false;}
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
					<next:Panel title="首页" closable="false" autoScroll="false">
						<next:Html>
							<div id="loadmask" style="display: none;" class="loading"><img
								src="<%=request.getContextPath()%>/skins/images/default/extanim32.gif"
								width="32" height="32" style="margin-right: 8px;" />正在加载...</div>
							<iframe id="frame1" frameborder="no" border="0" marginwidth="0"
								marginheight="0" allowtransparency="yes" width="100%"
								style="overflow: auto" height="100%"
								src="<%=request.getContextPath()+mainPic %>"></iframe>
						</next:Html>
					</next:Panel>
				</next:Tabs>
			</next:TabPanel>

		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
<script type="text/javascript">
function init(){
	//检测开关
	<%
	if(menuCacheEnable != null && "true".equals(menuCacheEnable)){
	%>
	buildMenu(menuData);
	<%}else{%>
	L5.Ajax.request(config);
	<% }
	%>
	zuo();
	var tabs=L5.getCmp('center');
	var panel = tabs.getItem(0);var iframes=panel.body.query('iframe');
   	var loading=L5.fly('loadmask',panel.body);
   	loading.setStyle("display","block");
   	iframes[0].style.visibility="hidden";
   	iframes[0].onload=iframes[0].onreadystatechange=function(){
         if(this.readyState=="complete"||!this.readyState){
        	 loading.dom.style.display="none";
        	 iframes[0].style.visibility="visible";
         }
   	  }
   	L5.fly(L5.DomQuery.selectNode(".xia")).setVisibilityMode(2).hide();
   	<%if(_menuType.equals("0000000004")){ %>
///*去掉此注释，可以弹出提示框
 		getMsg();
		resizeDiv();
	<%}%>
	<%
	if(_menuType.equals("0000000005")&&(BspUtil.getOrganType().equals("11")||BspUtil.getOrganType().equals("12")||BspUtil.getOrganType().equals("13"))){
		Map<String,String> bptmap =new HashMap();
		BptNotRemindCommand bnrCommand = new BptNotRemindCommand();
		bptmap = bnrCommand.queryDaiBanRemindNum();
	%>
		var ht=<%=bptmap.get("ht")==null?0:bptmap.get("ht")%>;
		var sq=<%=bptmap.get("sq")==null?0:bptmap.get("sq")%>;
		var zc=<%=bptmap.get("zc")==null?0:bptmap.get("zc")%>;
		var rz=<%=bptmap.get("rz")==null?0:bptmap.get("rz")%>;
		var organType = <%=BspUtil.getOrganType()%>
		sq=sq+zc;
		var blzs=ht+sq;

		var htmltext="<div style='width:300px;aligan:center;padding:15px;FONT-WEIGHT:normal;FONT-SIZE:13px;'>"+
		"共有&nbsp<font color='red'>"+blzs+"</font>&nbsp条任务需要处理&nbsp&nbsp&nbsp&nbsp<input type='button' value='办理' "+
		"onclick='openUrlbpt(\"任务列表\",\"jsp/cams/bpt/flow/querydaiban_bpt.jsp\")'/>&nbsp&nbsp&nbsp&nbsp<input type='button' value='设置' "+
		"onclick='openUrlbpt(\"任务提醒设置\",\"jsp/cams/bpt/remind/daibanEditRemind.jsp\")'/>"+
		"<br/><br/>&nbsp&nbsp&nbsp&nbsp其中上级退回&nbsp<font color='red'>"+ht+"</font>&nbsp条,"+
		"下级提交&nbsp<font color='red'>"+sq+"</font>&nbsp条.<br/><br/>";
		if(organType==13){
			htmltext=htmltext+"共有&nbsp<font color='red'>"+rz+"</font>&nbsp位人员需要状态认证&nbsp&nbsp&nbsp&nbsp"+
			"<input type='button' value='办理' onclick='openUrlbpt(\"人员状态认证\",\"jsp/cams/bpt/remind/doubleIdRemindList.jsp\")'/>";
		}
		htmltext=htmltext+"</div>";
		$.messager.lays(300, 200);
		$.messager.show('消息提示', htmltext, 0);
	<%}%>
	<%if(_menuType.equals("0000000023")){ %>
		var leftPanel=L5.getCmp('leftPanel');
		leftPanel.collapse(true);
	<%}%>
}
function openUrlbpt(title,urlPath){
	var panel = L5.getCmp('center').getItem(0);
	if(title){
		panel.setTitle(title);
	}
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
	if(urlPath.indexOf("http")==0||urlPath.indexOf("www")>=0)
	    iframes[0].src =urlPath;
	else{
		iframes[0].src=L5.webPath+"/"+urlPath;
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
}
function shang(){
	L5.fly("nomenu").setVisibilityMode(2).hide();
	L5.fly(L5.DomQuery.selectNode(".shang")).setVisibilityMode(2).hide();
	L5.fly(L5.DomQuery.selectNode(".xia")).setVisibilityMode(2).show();
	L5.getCmp("viewport").syncSize();
}
function xia(){
	L5.fly("nomenu").setVisibilityMode(2).show();
	L5.fly(L5.DomQuery.selectNode(".xia")).setVisibilityMode(2).hide();
	L5.fly(L5.DomQuery.selectNode(".shang")).setVisibilityMode(2).show();
	L5.getCmp("viewport").syncSize();
}
function you(){
	var next=L5.fly("buttons").next();
	while(!next.isVisible()){
		next=next.next();
	}
	var prev=next.prev();
	if(prev)
		prev.show();
}
function openUrl(urlPath){
	var panel = L5.getCmp('center').getItem(0);
	var title="受理";
	if(title){
		panel.setTitle(title);
	}
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
	if(urlPath.indexOf("http")==0||urlPath.indexOf("www")>=0)
	    iframes[0].src =urlPath;
	else{
		iframes[0].src=L5.webPath+"/"+urlPath;
	}
}
<%if(_menuType.equals("0000000004")){ %>
///*去掉此注释，可以弹出提示框
		window.onerror = function(){}
		//短信提示使用(asilas添加)
		var divTop,divLeft,divWidth,divHeight,docHeight,docWidth,objTimer;
		function getMsg(){
			try{
				divTop = parseInt(document.getElementById("eMeng").style.top,10);
				divLeft = parseInt(document.getElementById("eMeng").style.left,10);
				divHeight = parseInt(document.getElementById("eMeng").offsetHeight,10);
				divWidth = parseInt(document.getElementById("eMeng").offsetWidth,10);
				docWidth = document.body.clientWidth;
				docHeight = document.body.clientHeight;
				document.getElementById("eMeng").style.top = parseInt(document.body.scrollTop,10) + docHeight + 10;//  divHeight
				document.getElementById("eMeng").style.left = parseInt(document.body.scrollLeft,10) + docWidth - divWidth;
				document.getElementById("eMeng").style.visibility="visible";
				objTimer = window.setInterval("moveDiv()",10);
			}
			catch(e){}
		}
		function resizeDiv(){
			try{
				divHeight = parseInt(document.getElementById("eMeng").offsetHeight,10);
				divWidth = parseInt(document.getElementById("eMeng").offsetWidth,10);
				docWidth = document.body.clientWidth;
				docHeight = document.body.clientHeight;
				document.getElementById("eMeng").style.top = docHeight - divHeight + parseInt(document.body.scrollTop,10);
				document.getElementById("eMeng").style.left = docWidth - divWidth + parseInt(document.body.scrollLeft,10);
			}
			catch(e){}
		}
		function moveDiv(){
			try{
				if(parseInt(document.getElementById("eMeng").style.top,10) <= 380){
					window.clearInterval(objTimer);
					objTimer = window.setInterval("resizeDiv()",1);
					//setTimeout("closeDiv()",6000);
				}
				divTop = parseInt(document.getElementById("eMeng").style.top,10);
				document.getElementById("eMeng").style.top = divTop - 4;
			}
			catch(e){
			}
		}

		function closeDiv(){
			document.getElementById('eMeng').style.visibility='hidden';
			if(objTimer) window.clearInterval(objTimer)
		}
//*/
 <% } %>
</script>
<script for="window" event="onbeforeunload">
    if(document.body.clientWidth-event.clientX< 170&&event.clientY< 0||event.altKey){
		 	startRequest(L5.webPath+"/logout");
    }
</script>
<script language="javascript">
window.onload = getMsg;
window.onresize = resizeDiv;
window.onerror = function(){}
//短信提示使用(asilas添加)
var divTop,divLeft,divWidth,divHeight,docHeight,docWidth,objTimer;
function getMsg(){
	try{
		divTop = parseInt(document.getElementById("eMeng").style.top,10);
		divLeft = parseInt(document.getElementById("eMeng").style.left,10);
		divHeight = parseInt(document.getElementById("eMeng").offsetHeight,10);
		divWidth = parseInt(document.getElementById("eMeng").offsetWidth,10);
		docWidth = document.body.clientWidth;
		docHeight = document.body.clientHeight;
		document.getElementById("eMeng").style.visibility="visible";
		objTimer = window.setInterval("moveDiv()",10);
	}
	catch(e){}
}
function resizeDiv(){
	try{
		divHeight = parseInt(document.getElementById("eMeng").offsetHeight,10);
		divWidth = parseInt(document.getElementById("eMeng").offsetWidth,10);
		docWidth = document.body.clientWidth;
		docHeight = document.body.clientHeight;
		document.getElementById("eMeng").style.top = docHeight - divHeight + parseInt(document.body.scrollTop,10);
		document.getElementById("eMeng").style.left = docWidth - divWidth + parseInt(document.body.scrollLeft,10);
		setTimeout("closeDiv()",60000);
	}
	catch(e){}
}
function moveDiv(){
	try{
		if(parseInt(document.getElementById("eMeng").style.top,10) <= (docHeight - divHeight + parseInt(document.body.scrollTop,10))){
			window.clearInterval(objTimer);
			objTimer = window.setInterval("resizeDiv()",10);
		}
		divTop = parseInt(document.getElementById("eMeng").style.top,10);
		document.getElementById("eMeng").style.top = divTop - 4;
	}
	catch(e){
	}
}

function closeDiv(){
	document.getElementById('eMeng').style.visibility='hidden';
	if(objTimer) window.clearInterval(objTimer);
}
</script>
</body>
</html>