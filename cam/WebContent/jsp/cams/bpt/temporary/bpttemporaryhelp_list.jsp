<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
   var struId = '<%=BspUtil.getStruId()%>';
   var organCode = '<%=BspUtil.getOrganCode()%>';
   var organType = '<%=BspUtil.getOrganType()%>';
</script>
<html>
	<head>
		<title>临时救助申请列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="bpttemporaryhelp_list.js"></script>
		<script language="javascript">
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
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptTemporaryHelpQueryCommand" global="true" method="queryTemporaryHelp">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptTemporaryHelp">
			<model:field name="FAMILY_ID" type="string"/>
		</model:record>
	</model:dataset>
	
	<!-- 优抚对象类别-->
	<model:dataset id="objectDs"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BPT_OBJECT_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!--救助类别-->
	<model:dataset id="dsHelp" enumName="HELP.TYPE" autoLoad="true"></model:dataset>
	<!--性别-->
	<model:dataset id="dsSex" enumName="COMM.SEX" autoLoad="true"></model:dataset>
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
					<form style="width: 95%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >
								<td class="FieldLabel">属地行政区划：</td>
								<td class="FieldInput">
								<input type="text"  id="domicileName" class="TextEditor" title="属地行政区划" onclick="forHelp()" />
								<input type="hidden"  id="domicileCode" class="TextEditor" title="属地行政区划"  />
								<td class="FieldLabel">优抚对象类别:</td>
								<td class="FieldInput"><select id="objectType" name="objectType">
								        <option dataSet="objectDs"/>
								    </select></td>
							</tr>
							<tr >
								<td class="FieldLabel">帮助类别:</td>
								<td class="FieldInput">
								    <select id="helpType" name="helpType">
								        <option dataSet="dsHelp"/>
								    </select>
								</td>	
								<td colspan="2" align="left"><button onclick="query()">查 询</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="bpttemporaryhelpGrid" width="100%" stripeRows="true" height="100%" clickToSelectedForChkSM="true" dataset="ds" >
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="edit" />
		<next:ToolBarItem text="查看" iconCls="detail" handler="detail" />
		<next:ToolBarItem text="删除" iconCls="remove" handler="del" />
		<next:ToolBarItem text="审批" id="submitButton" iconCls="view" handler="submit" />
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="50" header="编号"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	    <next:Column id="applyId" header="申请ID" field="APPLY_ID" width="90" hidden="true">
			<next:TextField  />
		</next:Column>
		<next:Column id="name" header="姓名" field="NAME" width="90" >
			<next:TextField  />
		</next:Column>
		<next:Column id="sex" header="性别" field="SEX" width="50" dataset="dsSex">
			<next:TextField  />
		</next:Column>
		<next:Column id="idCord" header="身份证号" field="ID_CORD" width="150" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="age" header="年龄" field="AGE" width="50" >
			<next:TextField  />
		</next:Column>
		<next:Column id="nation" header="民族" field="NATION" width="90" dataset="NationDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="objectType" header="优抚对象类别" field="OBJECT_TYPE" width="150" dataset="objectDs">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="helpType" header="帮助类别" field="HELP_TYPE" width="90" dataset="dsHelp">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="familyNum" header="家庭人口" field="FAMILY_NUM" width="90" >
			<next:TextField  />
		</next:Column>
		<next:Column id="reviewMon" header="申请金额" field="APPLY_MON" width="90" align="right">
			<next:NumberField allowBlank="false" />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
