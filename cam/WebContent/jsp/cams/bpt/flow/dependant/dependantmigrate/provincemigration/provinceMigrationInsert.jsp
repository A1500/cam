<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>添加三属人员省内迁移信息</title>
<next:ScriptManager />
<script type="text/javascript" src="provinceMigrationInsert.js"></script>
<script type="text/javascript" src="../../../../comm/bptComm.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
</head>
<body>
<model:datasets>
	<!-- 人员信息 -->
	<model:dataset id="ProvinceMigrationDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDependantQueryCommand" method="queryByIdCard" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
			<model:field name="relationship" type="string"/>
			<model:field name="dependantTypeCode" type="string" />
			<model:field name="ingoingName" type="string" />
			<model:field name="domicileName" type="string"  />
			<model:field name="apanageName" type="string"  />
		</model:record>
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptProvinceMigrate">
		</model:record>
	</model:dataset>
	
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
	<!-- 三属类别 -->
	<model:dataset id="DependantTypeDataset" enumName="DEPENDANT.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 与牺牲病故军人关系 -->
	<model:dataset id="RelationTypeEnum" enumName="RELATION.TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel width="100%" height="100%" autoScroll="false">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
	</next:TopBar>     
	<next:Html>
		<form id="approveForm" onsubmit="return false" style="padding: 5px;" class="L5form" dataset="ProvinceMigrationDataSet">
		<table border="1" width="99%">
			<tr>
				<td class="FieldLabel" style="width:20%">身份证号:</td>
				<td class="FieldInput" style="width:15%"><input readonly="readonly" id="idCard" type="text" name="idCard" field="idCard" maxlength="18" style="width:135"/>
								<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="getIdCard()"/>
				</td>
				<td class="FieldLabel" style="width:15%">姓名:</td> 
				<td class="FieldInput" style="width:15%"><label id="name" name="name" field="name"/></td>
				<td class="FieldLabel" style="width:15%">性别:</td>
				<td class="FieldInput" style="width:15%"><label id="sex" name="sex" field="sex" dataset="SexDataset"></label></td>
	   		</tr>
	   		<tr>
	   			<td class="FieldLabel">三属人员类别:</td>
				<td class="FieldInput"><label id="dependantTypeCode" name="dependantTypeCode" field="dependantTypeCode" dataset="DependantTypeDataset"/></td>
				<td class="FieldLabel">与牺牲病故军人关系:</td>
				<td class="FieldInput"><label id="relationship" name="relationship" field="relationship" dataset="RelationTypeEnum"></label></td>
				<td class="FieldLabel">定期抚恤金证编号:</td>
				<td class="FieldInput"><label id="dependantNo" name="dependantNo" field="dependantNo"></label></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap="nowrap">迁入地民政局:</td>
				<td class="FieldInput"><input type="hidden" id="ingoingCode" name="ingoingCode" field="ingoingCode"/>
									   <input type="text" id="ingoingName" readonly="readonly" name="ingoingName" field="ingoingName" onclick="func_Ingoing()"/>
				<font color="red">*</font></td>
				<td class="FieldLabel" nowrap="nowrap">残疾抚恤金已发至:</td>
				<td class="FieldInput"><input type="text" id="allowanceMonth" name="allowanceMonth" onblur="setMoth(this)" field="allowanceMonth" format="Y" style="width: 100px;" maxlength="10"/><img  src="../../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
				<td class="FieldLabel" nowrap="nowrap">迁出地民政部门联系电话:</td>
				<td class="FieldInput" ><input type="text" name="outTownCheckPhone" field="outTownCheckPhone"/></td>
			</tr>
			<tr>
				
				<td class="FieldLabel" >迁入地户口薄(行政区划):</td>
						   <td class="FieldInput" colspan="5" >
						       <input type="text" id="domicileName" style="width:300px;" name="domicileName" field="domicileName" title="属地行政区划" onclick="func_ForInDomicileSelect()" readonly="readonly"/><font color="red">*</font>
						       <input type="hidden" id="domicileCode" name="domicileCode" field="inDomicileCode" title="属地行政区划"/> 
				  			&nbsp;&nbsp;&nbsp;地址: 
						    <input type="text" style="width:300px;" id="inDomicileAddress" name="inDomicileAddress" field="inDomicileAddress" title="户口薄住址" ></td>      
			</tr>
			<tr>
				<td class="FieldLabel">迁入地实际居住(行政区划):</td> 
							<td class="FieldInput" colspan="5"><input type="text" style="width:300px;" id="apanageName" name="apanageName" field="apanageName" title="行政区划" readonly="readonly" onclick="func_ForInApanageSelect()"/><font color="red">*</font>
							<input type="hidden" name="apanageCode" field="inApanageCode" title="行政区划"/>       
				         &nbsp;&nbsp;&nbsp;地址: 
							 <input type="text" style="width:300px;" id="inApanageAddress" name="inApanageAddress" field="inApanageAddress" title="实际居住地址"  ></td>  
			</tr>
			<input type="hidden" id="peopleId" field="peopleId"/>
			<input type="hidden" id="familyId" field="familyId"/>
		</table>
		</form>
   </next:Html>
</next:Panel>	

</body>
</html>
