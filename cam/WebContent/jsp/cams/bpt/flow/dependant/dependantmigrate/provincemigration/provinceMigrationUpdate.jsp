<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<script type="text/javascript">
	var applyId = '<%=request.getParameter("applyId")%>';
</script>
<html>
<head>
<title>修改三属人员省内迁移信息</title>
<next:ScriptManager />
<script type="text/javascript" src="provinceMigrationUpdate.js"></script>
<script type="text/javascript" src="../../../../comm/bptComm.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
</head>
<body>
<model:datasets>
	 
	<!-- 三属人员抚省内迁移 -->
	<model:dataset id="ProvinceMigrationDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateQueryCommand" method="queryDependentProEmigrate" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptProvinceMigrate">
			<model:field name="relationship" type="string"/>
			<model:field name="dependantTypeCode" type="string" />
			<model:field name="idCard" type="string"/>
			<model:field name="name" type="string" />
			<model:field name="sex" type="string"/>
			<model:field name="dependantNo" type="string"/>
			<model:field name="ingoingName" type="string" />
			<model:field name="domicileName" type="string" rule="require"/>
			<model:field name="apanageName" type="string" rule="require"/>
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
		<next:ToolBarItem iconCls="print"  text="生成" handler="print"/>
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
				<td class="FieldInput" style="width:15%"><label type="text" name="idCard" field="idCard" style="width:135"  />
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
				<td class="FieldInput"><input type="text" id="allowanceMonth" onblur="setMoth(this)" name="allowanceMonth" field="allowanceMonth" format="Y" style="width: 100px;" maxlength="10"/><img  src="../../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
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
			<!-- 打印相关 -->
			<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/comm/print/e_migration_table.doc"/>
			<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
			<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
			<input type="hidden" id="scaconfPath" value="migrationApp/migrationAppPrintDao"/>
			<input type="hidden" id="serviceType" name="printQuery" queryData="queryData" value="23"/>
		</table>
		</form>
   </next:Html>
</next:Panel>	
<script type="text/javascript">
	
function print() {
		var url="../../../../../comm/print/jspcommonprint.jsp?";
		var width = 1024;
		var height = 768;
	    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	}
</script>
</body>
</html>
