<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>定期信息提示列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src="informationCueList.js"></script>
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
	<model:dataset id="RegularInformationCueDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptRegularInformationCueQueryCommand" global="true" pageSize="10">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptRegularInformationCue"></model:record>
	</model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象类型 -->
	<model:dataset id="ObjectTypeDataset" enumName="OBJECT.TYPE.PART" autoLoad="true" global="true"></model:dataset>
	<!-- 提示信息确认标志 -->
	<model:dataset id="ConfirmflagEnum" enumName="CONFIRM.FLAG"  autoLoad="true" global="true"></model:dataset>
	<!-- 信息提示类别 -->
	<model:dataset id="InformationCueDataset" enumName="INFORMATIONCUE.TYPE" autoLoad="true" global="true"></model:dataset>
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
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
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
								<td class="FieldLabel" nowrap="nowrap">优抚对象类别：</td>
								<td class="FieldInput">
									<input type="text"  id="objectTypeName" class="TextEditor" title="优抚对象类别"  readonly="readonly" onclick="forHelpOT()"/>
									<input type="hidden" name="objectType"  id="objectType" class="TextEditor"/>
								</td>
								
								<td nowrap="nowrap" class="FieldLabel">确认标志：</td>
								<td class="FieldInput">
									<select id="confirmFlag" name="confirmFlag" field="confirmFlag">
										<option dataset="ConfirmflagEnum"></option>
									</select>
								</td>	
								
								<td class="FieldLabel" nowrap="nowrap">提示信息类别：</td>
								<td class="FieldInput">
									<select id="cueInfoType" name="cueInfoType" field="cueInfoType">
										<option dataset="InformationCueDataset"></option>
									</select>
								</td>
							</tr>
							<tr>	
								
								<td class="FieldLabel" align="center" >年龄：</td>
					<td class="FieldInput" align="center">
						<input type="text"  id="ageBegin" style="width:60px"  />~<input type="text"  id="ageEnd" style="width:60px"  />
					</td>
								<td class="FieldLabel" colspan="4" style="text-align:center;"><button id="queryButton" onclick="query()">查 询</button> 
									&nbsp;&nbsp;&nbsp;<button onclick="reset()">重 置</button> 
								</td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="bptregularinformationcueGrid" width="100%" clickToSelectedForChkSM="true" stripeRows="true" height="100%" dataset="RegularInformationCueDataset" title="定期信息提示">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="确认" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	    
	    <next:Column id="DOMICILE_NAME" header="属地行政区划" field="DOMICILE_NAME" width="85" >
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
		
		<next:Column id="AGE" header="年龄（周岁）" field="AGE" width="140" >
			<next:TextField allowBlank="false"/>
		</next:Column>
		
		<next:Column id="OBJECT_STATE" header="优抚对象状态" field="OBJECT_STATE" width="115" dataset="ObjectStateDataset">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="OBJECT_TYPE" header="优抚对象类别" field="OBJECT_TYPE" width="130"  dataset="ObjectTypeDataset">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="CUE_INFO_TYPE" header="提示信息类别" field="CUE_INFO_TYPE" width="90" dataset="InformationCueDataset" >
			<next:TextField/>
		</next:Column>
		<next:Column id="CUE_INFO_CONTENT" header="提示信息内容" field="CUE_INFO_CONTENT" width="150" >
			<next:TextField/>
		</next:Column>
		<next:Column id="CONFIRM_FLAG" header="确认标志" field="CONFIRM_FLAG" width="90" dataset="ConfirmflagEnum">
			<next:TextField/>
		</next:Column>
		<next:Column id="CONFIRM_TIME" header="确认时间" field="CONFIRM_TIME" width="90" renderer="formatDate(this)">
			<next:TextField/>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="RegularInformationCueDataset"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
