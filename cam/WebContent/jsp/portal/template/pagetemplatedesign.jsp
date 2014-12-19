<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.portal.util.PortalJspUtil" %>
<%@ page import="org.loushang.next.data.Record" %>
<%@ page import="org.loushang.portal.page.data.PortalPage" %>
<%@page import="java.util.List"%>

<%
  String webPath=PortalJspUtil.webPath(request);
  //模板id
  String templateId = request.getParameter("templateId");
  //页面ID
  String pageId=request.getParameter("pageId");
  //页面列定义
  List portalColumnList = PortalJspUtil.queryPortalColumnListByPageId(pageId);
  //页面列数
  int portalColumnCount=portalColumnList.size();
  //页面
  PortalPage portalPage = PortalJspUtil.queryPortalPage(pageId);
  //页面布局类型
  String layoutType=portalPage.getLayoutType();
  //查询应用的js文件路径
  String[] appBizJses = PortalJspUtil.queryAppBizJs();
%> 
<html>
<head>
  <title>模板布局设计器</title>
	<next:ScriptManager></next:ScriptManager>
	<link rel="stylesheet" type="text/css" href="<%=webPath %>/jsp/portal/css/portal.css"/>
    <script type="text/javascript" src="<%=webPath %>/jsp/portal/js/Portal.js"></script>
    <%
	if( appBizJses.length > 0){
		for(int i = 0; i < appBizJses.length; i++){
			String middle = "";
			if(!appBizJses[i].startsWith("/")){
				middle = "/";
			}
			String appBizJsPath = webPath + middle + appBizJses[i];
	%>
			<script type="text/javascript" src='<%=appBizJsPath %>'></script>
	<%
		}
	}
    %>
</head>
<model:datasets>
	<model:dataset id="portalTemplateWidgetLayout" cmd="org.loushang.portal.template.cmd.PortalTemplateQueryCmd" global="true" method="queryPortalTemplateWidgetLayout">
		<model:record fromBean="org.loushang.portal.widget.data.PortalWidget">
		</model:record>
	</model:dataset>
</model:datasets>
<body>
<next:ViewPort>
  <next:BorderLayout>
    <next:Center>
      <next:Panel bodyStyle="overflow-y:auto">
	    <next:Panel id="widgetContainer" width="100%" border="false">
		  <next:Panel xtype="portal" id="portal" width="100%" border="false">
		  </next:Panel>
		  <next:Panel xtype="absportal" id="absportal" width="100%" height="100%" border="false">
		  </next:Panel>
		</next:Panel>
		<next:Panel hidden="true" id="maxWidgetContainer" width="100%" border="false" cls="l-portal-maxwidgetcontainer">
		</next:Panel>
	    <next:TopBar>
		  <next:ToolBarItem symbol="<span id=tbCurPageName></span>"></next:ToolBarItem>
	      <next:ToolBarItem symbol="->"></next:ToolBarItem>
	      <next:ToolBarItem iconCls="save"  text="保存模板" handler="saveTemplate"/>
	      <next:ToolBarItem iconCls="save"  text="保存并应用模板" handler="applyTemplate"/>
	      <next:ToolBarItem iconCls="undo" text="返回" handler="forReturn"/>
	    </next:TopBar>
	  </next:Panel>
    </next:Center>
    <next:Right split="true" >
	  <next:Panel id="widgetSelector" width="200" height="100%" 
			 bodyStyle="overflow:auto;" border="0"  collapsible="true"  collapseMode="mini">
		<next:Html >
			 <iframe height="100%" width="100%" src="<%=webPath %>/jsp/portal/help/widgethelper.jsp?layoutType=<%=layoutType%>">
			 </iframe>
		</next:Html>
	  </next:Panel>
    </next:Right>
  </next:BorderLayout>
</next:ViewPort>
</body>
<script type="text/javascript">
//页面widget布局Json串
var widgetLayoutJson;
//页面布局类型
var curPageLayoutType="<%=layoutType%>";
//初始化
function init(){
	portalTemplateWidgetLayout.setParameter("templateId",'<%=templateId%>');
	portalTemplateWidgetLayout.load();
	portalTemplateWidgetLayout.on("load",initWidgetLayout);
	//微件选择器初始为折叠
    var widgetSelector = L5.getCmp("widgetSelector");
	widgetSelector.collapse(false);
	//设置当前页面
	L5.getDom("tbCurPageName").innerHTML="<font color='red'>[<%=portalPage.getName()%>]</font>";
}

// 初始化widget布局
function initWidgetLayout(){
	switch(curPageLayoutType)
	{
		//简单布局
		case "0":initColPortalWidgetLayout();
			    break;
	    //任意布局
		case "1":initAbsPortalWidgetLayout();
		        break;
	}
	//初始化最大化widget容器
	LoushangPortalUtil.initColPortalMaxWidgetContainer();
}

//初始化页面布局为 "column"的Portal里的widget布局
function initColPortalWidgetLayout()
{	  
	//1.隐藏任意布局
	var absportal=L5.getCmp("absportal");
	absportal.hide();

    // 2.显示简单布局
    var portal = L5.getCmp("portal");
    portal.show();
    
	// 3.创建列
	<%
	  for(int i=0;i<portalColumnCount;i++)
	  {
		Record record = (Record)portalColumnList.get(i);
		String columnId = "column"+(i+1);
		String columnWidth = (String )record.get("colWidth");
	%>
	    portal.addColumn("<%=columnId%>","<%=columnWidth%>");
	<%
	  }
	%>

	// 4.向每列中添加widget
	// 4.1 widget布局json串
	widgetLayoutJson = portalTemplateWidgetLayout.getCustomData("widgetLayout");
	var widgetLayoutArray;
	try
	{
		widgetLayoutArray =eval(widgetLayoutJson);
	}catch(e){
		L5.MessageBox.alert("消息提示","获得页面widget布局出现异常!");
		return;
	}

	// 4.2 处理列数可能变动的情况
	// 上次保存的页面列数
	var preColumnCount=widgetLayoutArray.length;
	// 这次设置的页面列数
	var curColumnCount=<%=portalColumnCount%>;
	// 这次要向其中添加widget的页面列数
	var toAddWidgetColumnCount=preColumnCount>curColumnCount?curColumnCount:preColumnCount;

	// 4.3 向每列中添加widget
	for(var i=0;i<toAddWidgetColumnCount;i++){
		var colContainer = L5.getCmp("column"+(i+1));
		for(var j = 0 ;j<widgetLayoutArray[i].length;j++){
			var widgetId=widgetLayoutArray[i][j];
			var record = portalTemplateWidgetLayout.getById(widgetId);
			if(record)
			{
				colContainer.addPortlet(record);
			}
		}
	}

	//5.调整布局
	portal.doLayout();
}

//初始化页面布局为 "absolute"的Portal里的widget布局
function initAbsPortalWidgetLayout()
{
	//1.隐藏简单布局
	var portal=L5.getCmp("portal");
	portal.hide();
	
	//2.显示任意布局
    var absPortal = L5.getCmp("absportal");
    absPortal.show();

    // 3.向Portal中添加widget
    // 3.1 widget布局json串
    widgetLayoutJson = portalTemplateWidgetLayout.getCustomData("widgetLayout");
    var widgetLayoutArray;
    try
    {
	  widgetLayoutArray =eval(widgetLayoutJson);
    }catch(e){
	  L5.MessageBox.alert("消息提示","获得页面widget布局出现异常!");
	  return;
    }
    // 3.2 向Portal中添加widget
	for(var i = 0 ;i<widgetLayoutArray.length;i++){
		var widgetId=widgetLayoutArray[i][0];
		var record = portalTemplateWidgetLayout.getById(widgetId);
		if(record)
		{
			var widgetX=widgetLayoutArray[i][1];
			var widgetY=widgetLayoutArray[i][2];
			var widgetWidth=widgetLayoutArray[i][3];
			var widgetHeight=widgetLayoutArray[i][4];
			absPortal.addPortlet(record,widgetX,widgetY,widgetWidth,widgetHeight,true);
		}
	}

    //4.调整布局
	absPortal.doLayout();	
}

//保存模板
function saveTemplate(){
	var save = saveWidgetLayout();
	if(save=="success"){
		L5.MessageBox.alert("消息提示",'保存成功!');
		return;
	}
}

//应用模板
function applyTemplate(){
	var save = saveWidgetLayout();
	
	if(save=="fail"){
		return;
	}
	var templateIds = [];
	templateIds[0] = '<%=templateId %>';
	var command = new L5.Command("org.loushang.portal.template.cmd.PortalTemplateCmd");
	command.setParameter("templateIds",templateIds);
    command.afterExecute=function(){
		if (!command.error) {
			L5.MessageBox.alert("消息提示",'应用成功!');
		}else{
			L5.MessageBox.alert("消息提示",command.error);
		}
    }
    command.execute('applyPortalTemplate');
}

// 保存widget布局
function saveWidgetLayout(){
	var portal=(curPageLayoutType=="0")?L5.getCmp("portal"):L5.getCmp("absportal");
	var array=portal.toJsonArray();
	var widgetLayout = L5.encode(array);
	//将上面的json串保存到数据库中。
	if(widgetLayout!=widgetLayoutJson){
		var command = new L5.Command("org.loushang.portal.template.cmd.PortalTemplateCmd");
		command.setParameter("templateId",'<%=templateId%>');
		command.setParameter("widgetLayout",widgetLayout);
		command.afterExecute=function(){
			if (!command.error) {
				widgetLayoutJson = widgetLayout;
				returnValue= "success";
			}else{
				L5.MessageBox.alert("消息提示",command.error);
				returnValue = "fail";
			}
		}
		command.execute("updatePortalTemplatWidgetLayout");
		return returnValue;
	}else{
		L5.MessageBox.alert("消息提示",'布局未做改动,无需保存!');
		return "";
	}
}

//返回到模板查询页面
function forReturn(){
	var url="jsp/portal/template/pagetemplate.jsp";
	L5.forward(url,"页面模板");
}
</script>
</html>