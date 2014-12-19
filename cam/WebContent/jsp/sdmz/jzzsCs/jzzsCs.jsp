<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.sdmz.comm.util.*"%>
<%
	String organArea = BspUtil.getCorpOrgan().getOrganCode();
	
%>
<html>
	<head>
		<title>救助指数参数配置</title>
		<next:ScriptManager></next:ScriptManager>
		<script type="text/javascript" src="jzzsCs.js"></script>

		<script>
		var organArea = "<%=organArea%>";
 function editable(){
	 var dataset = L5.DatasetMgr.lookup("ygjzJzzsConfDataset");
	 var state = dataset.getCurrent().state;
	 if(state==L5.model.Record.STATE_NEW)
		 return true;
	 else
     return false;
  }
		</script>
	</head>
<body>
<model:datasets> 
     <model:dataset id="DmJzfxDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_ASSITANCE_SIDE'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="ygjzJzzsConfDataset" cmd="com.inspur.sdmz.jzzs.cmd.YgjzJzzsConfQueryCommand" autoLoad="false" pageSize="20">
		<model:record fromBean="com.inspur.sdmz.jzzs.data.YgjzJzzsConf">
		</model:record>
	</model:dataset>
 
 
</model:datasets>

<next:EditGridPanel id="editGridPanel" clicksToEdit="2" name="custGrid" width="100%" height="400" dataset="ygjzJzzsConfDataset" frame="true">
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="helpOrganRegion" header="行政区划" field="helpOrganRegion" width="140" sortable="true">
			<next:TextField allowBlank="false" editable="editable" />
		</next:Column>
	   <next:Column id="helpOrganName" header="所属区" field="helpOrganName" width="80" sortable="true">
			<next:TextField allowBlank="false" editable="editable" />
		</next:Column>
	
		<next:Column header="指数类型" field="helpType"  width="300"  renderer="jzfxRef"/>
		<next:Column header="指数权重" field="helpPer" width="200" >
			<next:TextField allowBlank="false"/>
		</next:Column>
	</next:Columns>
	<next:TopBar>
		<next:ToolBarItem iconCls="add"  text="增加" handler="Evt_butadd_click"/>
		<next:ToolBarItem iconCls="save"  text="保存" handler="Evt_butsave_click"/>
	    <next:ToolBarItem iconCls="undo"  text="取消" handler="Evt_butundo_click"/>
	    <next:ToolBarItem iconCls="remove" text="删除" handler="Evt_butremove_click"/>
	</next:TopBar>
	<next:BottomBar>
		<next:PagingToolBar dataset="ygjzJzzsConfDataset"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>
