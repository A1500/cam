<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>已扫描电子档案人员查询</title>
		<next:ScriptManager/>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src="haveERecordQuery.js"></script>
		<script type="text/javascript" src="../comm/bptComm.js"></script>
		<script language="javascript">
			var organCode='<%=BspUtil.getOrganCode()%>';
			var organName = '<%=BspUtil.getOrganName()%>';
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
	<model:dataset id="NoERecordDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptNoERecordQueryCommand" global="true" pageSize="10" method="queryHaveERecord">
	</model:dataset>
	<model:dataset id="NoERecordDataset1" cmd="com.inspur.cams.bpt.manage.cmd.BptNoERecordQueryCommand" global="true" pageSize="10" method="queryHaveERecord">
	</model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象类型 -->
	<model:dataset id="ObjectTypeDataset" enumName="OBJECT.TYPE.PART" autoLoad="true" global="true"></model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Panel name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 99%; height: 100%;" class="L5form">
						<table  border="1" width="100%">
							<tr>
								<td class="FieldLabel" nowrap="nowrap">所属行政区划：</td>
								<td class="FieldInput">
									<input type="text"  id="domicileName" class="TextEditor" title="所属行政区划"  readonly="readonly" onclick="forHelp()"/>
									<input type="hidden"  id="domicileCode" class="TextEditor"/></td>
								<td nowrap="nowrap" class="FieldLabel">姓名：</td>
								<td class="FieldInput"><input type="text" id="name" class="TextEditor" title="姓名"/></td>	
								<td class="FieldLabel" nowrap="nowrap">身份证件号码：</td>
								<td class="FieldInput"><input type="text"  id="idCard" class="TextEditor" title="身份证件号码"/></td>	
							</tr>
							<tr>
								<td class="FieldLabel" nowrap="nowrap">优抚对象状态：</td>
								<td class="FieldInput">
									<select id="objectState" name="objectState" field="objectState"> 
											<option dataset="ObjectStateDataset"></option>
									</select>
								</td>
								<td class="FieldLabel" nowrap="nowrap">优抚对象类别：</td>
								<td class="FieldInput">
									<input type="text"  id="objectTypeName" class="TextEditor" title="优抚对象类别"  readonly="readonly" onclick="forHelpOT()"/>
									<input type="hidden" name="objectType"  id="objectType" class="TextEditor"/>
								</td>
								<td class="FieldLabel" align="center" >年龄：</td>
								<td class="FieldInput" align="center">
									<input type="text"  id="ageBegin" style="width:60px"  />~<input type="text"  id="ageEnd" style="width:60px"  />
								</td>
							</tr>
							<tr>
								<td class="FieldLabel" colspan="6" style="text-align: center;"><button id="queryButton" onclick="query()">查 询</button> 
									&nbsp;&nbsp;&nbsp;<button onclick="reset()">重 置</button> 
								</td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="editGridPanel" name="noERecordGrid" width="100%" stripeRows="true" height="100%" dataset="NoERecordDataset" title="已扫描电子档案人员">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="导出EXCEL" iconCls="detail" handler="excel_imp" id="excelButton"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	    <next:Column id="DOMICILE_NAME" header="属地行政区划" field="DOMICILE_NAME" width="235">
			<next:TextField allowBlank="false" />
		</next:Column> 
		<next:Column id="NAME" header="姓名" field="NAME" width="60" renderer="peopleDetail">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="SEX" header="性别" field="SEX" width="35" dataset="SexDataset" >
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="NATION" header="民族" field="NATION" width="70" dataset="NationDataset" >
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="ID_CARD" header="身份证件号码" field="ID_CARD" width="140" >
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="AGE" header="年龄" field="AGE" width="140" align="right">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="OBJECT_STATE" header="优抚对象状态" field="OBJECT_STATE" width="115" dataset="ObjectStateDataset">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="OBJECT_TYPE" header="优抚对象类别" field="OBJECT_TYPE" width="130" dataset="ObjectTypeDataset">
			<next:TextField allowBlank="false"/>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="NoERecordDataset"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
