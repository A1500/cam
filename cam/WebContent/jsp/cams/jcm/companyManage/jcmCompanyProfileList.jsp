<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>单位信息列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="jcmCompanyProfileList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
		var organCode = '<%=BspUtil.getOrganCode()%>';
		var organName = '<%=BspUtil.getOrganName()%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="jcmCompanyProfileDataSet" cmd="com.inspur.cams.jcm.cmd.JcmCompanyProfileQueryCmd" method="queryCompany" pageSize="10">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmCompanyProfile"/>
	</model:dataset>
	<!-- 单位性质 -->
	<model:dataset id="DWXZDs" enumName="JCM.COMPANY_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 字典表的引用 单位所属业务类别  001-->
	<model:dataset id="typeDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="DIC_JCM_DETAILS"></model:param>        <!-- 需要查询的表 -->
			<model:param name="value" value="CODE"></model:param>     <!-- 查询的内容 -->
			<model:param name="text" value="NAME"></model:param>    <!-- 输出查询的结果 -->
			<model:param name="filterSql" value='DIC_TYPE=001'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
							<form onsubmit="return false;" class="L5form">				
								<table  border="1" width="100%">
									<tr>
										<td class="FieldLabel" width="10%">单位名称：</td>
							            <td class="FieldInput" width="20%">
							            <input type="text"  id="companyName" style="width:40%" /></td>
										<td class="FieldLabel" width="10%">单位性质：</td>
							            <td class="FieldInput" width="20%"><select type="text" id="companyNature"
											class="TextEditor" title="单位性质" />
											<option dataset="DWXZDs"/>
										</select></td>
										<td class="FieldLabel" width="10%">法人：</td>
							            <td class="FieldInput" width="20%">
							            <input type="text"  id="companyPeopleName" style="width:40%" /></td>
									</tr>
									<tr>
										<!--  
										<td class="FieldLabel" style="width: 15%">地区</td>
										<td class="FieldInput" style="width: 18%">
						 					<input type="text" style="width:78%"name="地区" title="地区"  field="organName" id="lrdwmc" />
											<input type="text" style="display: none;"  name="lrdwId" id="lrdwIdquery" field="organCode" />
						 					<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="func_ForDomicileSelect()" /><font color="red">*</font>
										</td>
										  -->
										<td class="FieldLabel" width="10%">批准文号：</td>
							            <td class="FieldInput" width="20%">
							            <input type="text"  id="companyNo" style="width:40%" /></td>
										<td class="FieldLabel" width="10%">主管部门名称：</td>
							            <td class="FieldInput" width="20%">
							            <input type="text"  id="companyBorgName" style="width:40%" /></td>
										<td class="FieldLabel" colspan="2">
										<button onclick="queryCompany()">查 询</button>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<button onclick="resetClick()">重置</button>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										</td>
									</tr>
								</table>
							</form>	
						</div>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="jcmCompanyProfileDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="增加" handler="insert"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="update"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="明细" handler="detail"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="del"></next:ToolBarItem>
		<next:ToolBarItem iconCls="select" text="调整" handler="select" hidden="true"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="COMPANY_NAME" header="单位名称" width="15%" sortable="false"/>
		<next:Column field="COMPANY_NATURE" header="单位性质" width="10%" sortable="false" hidden="true"/>
		<next:Column field="COMPANY_PEOPLE_NAME" header="法人" width="10%" sortable="false" hidden="true"/>
		<next:Column field="COMPANY_NO" header="批准文号" width="10%" sortable="false"/>
		<next:Column field="COMPANY_JOB_NUM" header="从业人数" width="10%" sortable="false"/>
		<next:Column field="COMPANY_EST_NUM" header="编制人数" width="10%" sortable="false"/>
		<next:Column field="COMPANY_BORG_NAME" header="主管部门名称" width="10%" sortable="false"/>
		<next:Column field="COMPANY_TYPE" header="单位所属业务类别" width="10%" sortable="false" dataset="typeDS"/>
		<next:Column field="COMPANY_STATUS" header="状态" width="10%" sortable="false" hidden="true"/>
		<next:Column field="GROSS_AREA" header="建筑面积" width="10%" sortable="false" hidden="true"/>
		<next:Column field="OFFICE_ADRESS" header="办公地址" width="10%" sortable="false"/>
		<next:Column field="ROOMS_NUM" header="房间间数" width="10%" sortable="false"/>
		<next:Column field="PRINCIPAL_NAME" header="负责人姓名" width="10%" sortable="false"/>
		<next:Column field="PRINCIPAL_DUTY" header="负责人职务" width="10%" sortable="false"/>
		<next:Column field="PRINCIPAL_PHONE" header="负责人办公电话" width="10%" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="jcmCompanyProfileDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>