<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>优抚对象信息查看</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="basicInfoList.js"></script>
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
	<!-- 人员信息 -->
	<model:dataset id="BPTObjectInfoDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" method="queryBPTObjectInfo" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 

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
					<form style="width: 95%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >
								<td class="FieldLabel" nowrap="nowrap">所属行政区划：</td>
								<td class="FieldInput"><input type="text"  id="domicileCode" class="TextEditor" title="属地行政区划" style="width:143px" /><font color="red">*</font></td>	
								<td class="FieldLabel">姓名：</td>
								<td class="FieldInput"><input type="text"  id="name" class="TextEditor" title="姓名"  /></td>	
								<td class="FieldLabel" nowrap="nowrap">身份证件号码：</td>
								<td class="FieldInput"><input type="text"  id="idCard" class="TextEditor" title="身份证件号码"  /></td>
								<td class="FieldLabel"><button onclick="query()">查 询</button> </td>
							</tr>
							<tr>
								<td class="FieldLabel">年龄：</td>
								<td class="FieldInput">
									<input type="text"  id="ageBegin" class="TextEditor" title="最小年龄" style="width:60px"  />&nbsp;—&nbsp;
									<input type="text"  id="ageEnd" class="TextEditor" title="最大年龄" style="width:60px"  />
								</td>	
								<td class="FieldLabel" nowrap="nowrap">优抚对象状态：</td>
								<td class="FieldInput">
									<select id="objectState" name="objectState" field="objectState"> 
											<option dataset="ObjectStateDataset"></option>
									</select>
								</td>	
								<td class="FieldLabel" nowrap="nowrap">优抚对象类别：</td>
								<td class="FieldInput">
									<select id="objectType" name="objectType" field="objectType"> 
											<option dataset="ObjectTypeDataset"></option>
									</select>
								</td>
								<td class="FieldLabel"><button onclick="reset()">重 置</button> </td>	
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="basicInfoGridPanel" name="basicInfoGridPanel" width="100%" stripeRows="true" height="100%" dataset="BPTObjectInfoDataSet" title="优抚对象基本信息" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="查看" iconCls="detail" handler="detail"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45" />
	    <next:RadioBoxColumn></next:RadioBoxColumn>
	    
		<next:Column id="DOMICILE_CODE" header="所属行政区划" field="DOMICILE_CODE" width="85">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="NAME" header="姓名" field="NAME" width="60" renderer="bptDetailHref">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="ID_CARD" header="身份证件号码" field="ID_CARD" width="135" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="SEX" header="性别" field="SEX" width="35"  dataset="SexDataset" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="NATION" header="民族" field="NATION" width="70" dataset="NationDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="objectState" header="优抚对象状态" field="OBJECT_STATE" width="115" dataset="ObjectStateDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="objectType" header="优抚对象类别" field="OBJECT_TYPE" width="130" dataset="ObjectTypeDataset">
			<next:TextField allowBlank="false" />
		</next:Column>		
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="BPTObjectInfoDataSet"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
