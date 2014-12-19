
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>子系统列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="subsysConfigList.js"></script>
		<script language="javascript" hidden="true">
		 	 //查询条件打开合并函数
			 function collapse(element){
				var fieldsetParent=L5.get(element).findParent("fieldset");
				if(element.expand==null||element.expand==true){
					fieldsetParent.getElementsByTagName("div")[0].style.display="none";
					element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
					element.expand=false;
				}else{
					fieldsetParent.getElementsByTagName("div")[0].style.display="";
					element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
					element.expand =true;
				}
			}
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.comm.subsys.cmd.ComSubsysConfigQueryCmd" global="true" sortDirection="asc" sortField="orderNum" pageSize="20">
		<model:record fromBean="com.inspur.cams.comm.subsys.data.ComSubsysConfig"></model:record>
	</model:dataset>

	<model:dataset id="menuTypeds"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='PUB_MENU_TYPE'></model:param>
			<model:param name="value" value='MENU_TYPE_ID'></model:param>
			<model:param name="text" value='MENU_TYPE_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 是否 -->
    <model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true"    global="true"></model:dataset>
</model:datasets>


<next:GridPanel id="editGridPanel" name="comsubsysconfigGrid" clickToSelectedForChkSM="true" width="100%" stripeRows="true" height="100%" dataset="ds" notSelectFirstRow="true">
	<next:TopBar>
		
		<next:ToolBarItem  text='系统名称' />
		<next:ToolBarItem  xtype="textfield" id="sysName" />
		<next:ToolBarItem text='查询' iconCls="query" handler="query" />
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="刷新缓存" iconCls="add" handler="apply" />
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	     
		<next:Column id="sysId" header="系统编号" field="sysId" width="90" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="sysName" header="系统名称" field="sysName" width="140" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="sysMenuType" header="系统菜单" field="sysMenuType" width="140" >
			<next:ComboBox dataset="menuTypeds" displayField="text"
				valueField="value" typeAhead="true" />
		</next:Column>
		<next:Column id="sysIco" header="导航图标" field="sysIco" width="150" >
			<next:TextField  />
		</next:Column>
		<next:Column id="topPic" header="顶部图片" field="topPic" width="150" >
			<next:TextField  />
		</next:Column>
		<next:Column id="showFlg" header="是否显示" field='showFlg' width="50" dataset='comm_yesorno'>
			<next:TextField  />
		</next:Column>
		<next:Column id="orderNum" header="排序" field="orderNum" width="50" >
            <next:TextField  />
        </next:Column>
	   <next:Column id="mainPic" header="子系统首页" field="mainPic" width="200" >
            <next:TextField  />
        </next:Column>
         <next:Column id="ifJumpMain" header="是否直接跳转到相应菜单" field="ifJumpMain" width="200" dataset='comm_yesorno' >
            <next:TextField  />
        </next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
