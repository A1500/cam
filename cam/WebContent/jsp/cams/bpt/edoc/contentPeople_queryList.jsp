<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
   var organCode = '<%=BspUtil.getOrganCode()%>';
   var contentNumId= '<%=request.getParameter("contentNumId")%>';
</script>
<html>
	<head>
		<title>优抚人员档案目录</title>
		<next:ScriptManager/>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src="contentPeople_queryList.js"></script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
		<script type="text/javascript" src="../comm/bptComm.js"></script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js") %>"></script>
	</head>
<body>
<model:datasets>
	<!-- 目录号 -->
	<model:dataset id="ContentPeopleDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptElectronicQueryCommand" global="true" method="queryContentPeople">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptElectronic">
			<model:field name="PEOPLE_ID" type="string" />
			<model:field name="NAME" type="string" />
			<model:field name="ID_CARD" type="string" />
			<model:field name="SEX" type="string" />
			<model:field name="BPT_NO" type="string" />
			<model:field name="CONTENT_YEAR" type="string"/>
			<model:field name="ROOM_NO" type="string" />
			<model:field name="FILE_CABINET_NAME" type="string"/>
			<model:field name="LAYER_NUM" type="string"/>
			<model:field name="BOX_NUM" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象类型 -->
	<model:dataset id="ObjectTypeDataset" enumName="OBJECT.TYPE.PART" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 100%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >
								<td class="FieldLabel" nowrap="nowrap">所属行政区划：</td>
								<td class="FieldInput"><input type="text"  id="domicileName" class="TextEditor" title="所属行政区划"  readonly="readonly" onclick="forHelp()"/>
								<input type="hidden"  id="domicileCode" class="TextEditor"/></td>	
								<td class="FieldLabel">姓名：</td>
								<td class="FieldInput"><input type="text"  id="name" class="TextEditor" title="姓名"  /></td>	
								<td class="FieldLabel" nowrap="nowrap">身份证件号码：</td>
								<td class="FieldInput"><input type="text"  id="idCard" class="TextEditor" title="身份证件号码"  /></td>
								<td class="FieldLabel" style="align:center">
								<button id="queryButton" onclick="query()">查 询</button> 
								<button onclick="reset()">重 置</button> </td>	
							</tr>
							
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>


<next:GridPanel id="gridPanel" name="bptcontentnummaintainGrid" width="100%" stripeRows="true" height="100%" clickToSelectedForChkSM="true" dataset="ContentPeopleDataset" >
	<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
	        <next:ToolBarItem symbol="-"></next:ToolBarItem>
			<next:ToolBarItem iconCls="detail" text="查看" handler="detail()"  />
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="NAME" header="姓名" field="NAME" width="95" >			
		</next:Column>
		<next:Column id="ID_CARD" header="身份证号" field="ID_CARD" width="135" >			
		</next:Column>
		<next:Column id="SEX" header="性别" field="SEX" dataset="SexDataset" width="95" >			
		</next:Column>
		<next:Column id="BPT_NO" header="抚恤证号" field="BPT_NO" width="95" >			
		</next:Column>
		<next:Column id="CONTENT_YEAR" header="年度" field="CONTENT_YEAR" width="95" >			
		</next:Column>
		<next:Column id="ARCHIVE_NO" header="室编卷号" field="ARCHIVE_NO" width="95"></next:Column>
		<next:Column id="FILE_CABINET_NAME" header="档案柜名称" field="FILE_CABINET_NAME" width="110" align="right"></next:Column>
		<next:Column id="LAYER_NUM" header="层数" field="LAYER_NUM" width="95" align="right"></next:Column>
		<next:Column id="BOX_NUM" header="盒" field="BOX_NUM" width="95" align="right"></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ContentPeopleDataset"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
