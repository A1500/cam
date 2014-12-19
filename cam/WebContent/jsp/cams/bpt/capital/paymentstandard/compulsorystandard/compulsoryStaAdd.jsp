<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>添加义务兵优待金标准</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="../../common/comm.js"></script>
		<script type="text/javascript" src="../../../comm/bptComm.js"></script>
		<script type="text/javascript" src="compulsoryStaAdd.js"></script>
		<script>
		   var organCode = '<%=BspUtil.getOrganCode()%>';
		   var struId='<%=BspUtil.getStruId()%>';
		   var method='<%=request.getParameter("method")%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptCapitalstaQueryCommand" global="true" method="queryCompulsoryAdd" autoLoad="true">
		<model:record fromBean="com.inspur.cams.bpt.capital.data.BptCapitalsta"></model:record>
	</model:dataset>
	<!-- 优抚对象类别-->
	<model:dataset id="objectDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" >
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BPT_OBJECT_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
	<!-- 是否进藏、进疆 -->
	<model:dataset id="composedPort" enumName="COMM.YESORNO" global="true" autoLoad="true"></model:dataset>
	<!-- 户口类型 -->
	<model:dataset id="domicileTypeEnum" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox">
				<div>
					<form style="width: 95%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr>
								<td class="FieldLabel">生效日期:</td>
								<td class="FieldInput"><input type="text"  id="startDate" class="TextEditor" title="起生效日期"  format="Y-m-d" style="width: 100px;" onpropertychange="changeDateStyle(this)"  maxlength="10";"/><img  src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:EditGridPanel id="editGridPanel" name="bptcapitalstageneraGrid" width="100%" stripeRows="true" height="100%" dataset="ds">
	<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
	        <next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
			<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Columns>
	     <next:RowNumberColumn width="40" header="序号"/>
		<next:Column id="id" header="ID" field="id" width="90" hidden="true">
			<next:TextField allowBlank="false"/>
		</next:Column>
	    <next:Column id="standardsCounties" header="标准所属县区" field="standardsCounties" width="90" hidden="true">
		</next:Column>
		<next:Column id="objectType" header="优抚对象类别" field="objectType" width="170" dataset="objectDs" hidden="true">
		</next:Column>
	    <next:Column id="domicileType" header="户籍类别" field="domicileType" width="90" dataset="domicileTypeEnum">
		</next:Column>
		<next:Column id="inTibet" header="进藏进疆" field="inTibet" width="90" dataset="composedPort">
		</next:Column>
		<next:Column id="spotStandards" header="现月标准" field="spotStandards" width="90" align="right">
		</next:Column>
		<next:Column id="newmoonStandards" header="新月标准" field="newmoonStandards" width="90" align="right">
			<next:NumberField/>
		</next:Column>
		<next:Column id="inTibetAdditional" header="进藏进疆增发" field="inTibetAdditional" width="90" align="right">
			<next:NumberField/>
		</next:Column>
	    <next:Column id="startDae" header="生效日期（起）" field="startDate" width="90" hidden="true">
		</next:Column>
		<next:Column id="endDate" header="生效日期（止）" field="endDate" width="90" hidden="true">
		</next:Column>
        <next:Column id="regId" header="录入ID" field="regId" width="90"  hidden="true">
			<next:TextField/>
		</next:Column>
		<next:Column id="regTime" header="录入时间" field="regTime" width="90" hidden="true">
			<next:TextField/>
		</next:Column>
		<next:Column id="modId" header="修改ID" field="modId" width="90" hidden="true">
			<next:TextField/>
		</next:Column>
		<next:Column id="modTime" header="修改时间" field="modTime" width="90" hidden="true">
			<next:TextField/>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>
