<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<%@ page import="com.inspur.cams.comm.util.*"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>基金会分支/代表机构注销登记录入</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fundBranchHistoryCancel.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"camsCheck.js") %>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript">
	<%
		String taskCode=request.getParameter("taskCode");
		if(taskCode==null){
			taskCode="";
		}
		String sorgId=request.getParameter("sorgId");
		if(sorgId==null){
			sorgId="";
		}
	%>
	var taskCode="<%=taskCode%>";
	if(taskCode == ''){
		taskCode = '<%=SomIdHelp.getFundTaskCode()%>';//生成业务编号
	}
	var method='<%=request.getParameter("method")%>';
	var sorgId='<%=sorgId%>';
</script>
</head>
<body>

<model:datasets>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">			
		</model:record>
	</model:dataset>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryBranch" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="sorgCode" type="string" rule="require"/>
			<model:field name="cancelDate" type="string" rule="require"/>
			<model:field name="cancelReason" type="string" rule="require|length{500}"/>
			<model:field name="cnName" type="string" rule="require|length{100}"/>
			<model:field name="buildDate" type="string" rule="require|length{10}"/>
			<model:field name="organCode" type="string" rule="require|length{20}"/>
			<model:field name="sorgKind" type="string" rule="require"/>
			<model:field name="borgName" type="string" rule="require|length{100}"/>			
		</model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryCatalog" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--电子档案上传窗口--%>
	<model:dataset id="winElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>	
	<model:dataset id="somOrganQueryDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryMain">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
		</model:record>
	</model:dataset>	
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="DIC_GROUP_KIND"></model:param>
			<model:param name="value" value="CODE"></model:param>
			<model:param name="text" value="NAME"></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="SOM_BUSINESS_ORGAN"></model:param>
			<model:param name="value" value="BORG_CODE"></model:param>
			<model:param name="text" value="BORG_NAME"></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+BspUtil.getOrganCode().substring(0,6)%>'></model:param>			
		</model:params>
	</model:dataset>	
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="SOM_CATALOG"></model:param>
			<model:param name="value" value="CATALOG_CODE"></model:param>
			<model:param name="text" value="CATALOG_NAME"></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:ViewPort>
	<next:Panel width="100%" height="100%">
		<next:TopBar>
			<next:ToolBarItem symbol="基金会分支/代表机构注销登记"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="save" text="保存" handler="save" />	
			<next:ToolBarItem iconCls="return" text="返回" handler="goBack"></next:ToolBarItem>
		</next:TopBar>
		<next:TabPanel id="tabSomOrgan" width="100%" height="100%">	
			<next:Tabs>
				<next:Panel id="panelSomOrgan" title="基金会分支/代表机构注销登记表" width="100%" height="100%" autoScroll="true">
					<next:Html>
						<fieldset>
							<form id="cbForm" method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
								<table width="100%">
									<tr>
										<td class="FieldLabel" width="20%"><label>分支\代表机构登记证号：</label></td>
										<td class="FieldInput" width="30%"><input id="sorgCode" field="sorgCode" name='"分支/代表机构登记证号"' onkeyup="value=value.replace(/[^\-\\w\.\/]/ig,'').toUpperCase()" onblur="loadSorg()" style="width:50%"/><span style="color:red">*</span></td>
										<td class="FieldLabel" width="20%"><label>分支负责人：</label></td>
										<td class="FieldInput" width="30%"><label id="branchCharger" field="branchCharger" name='"分支负责人"' /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>分支/代表机构名称：</label></td>
										<td class="FieldInput"><label id="cnName" field="cnName" name='"分支/代表机构名称"'/></td>
										<td class="FieldLabel"><label>成立日期：</label></td>
										<td class="FieldInput"><label field="buildDate" name='"成立日期"'/></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>基金会名称：</label></td>
										<td class="FieldInput"><label field="name" name='"基金会名称"'/></td>
										<td class="FieldLabel"><label>基金会登记证号：</label></td>
										<td class="FieldInput"><label field="mainSorgCode" name='"登记证号"'/></td>
									</tr>							
									<tr>							
										<td class="FieldLabel"><label>住所：</label></td>
										<td class="FieldInput"><label field="residence" name='"住所"'/></td>
										<td class="FieldLabel"><label>基金会电话：</label></td>
										<td class="FieldInput"><label field="sorgPhone" name='"基金会电话"'/></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>注销日期：</label></td>
										<td class="FieldInput"><input id="cancelDate" field="cancelDate" name='"注销日期"'onClick="WdatePicker()" /><span style="color:red">*</span></td>
										<td class="FieldLabel"><label>业务主管单位：</label></td>
										<td class="FieldInput">
											<select id="borgName" field="borgName" name='"业务主管单位"' style="width:80%" disabled="disabled">
												<option dataset="businessOrganSelect" ></option>
											</select>								
										</td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>注销原因：</label></td>
										<td class="FieldInput" colspan="3" ><textarea rows="3" id="cancelReason" field="cancelReason" name='"注销原因"' style="width:93%"></textarea><span style="color:red">*</span></td>
									</tr>
								</table>
							</form>
						</fieldset>
						<fieldset>	
							<legend>履行内部程序</legend>					
							<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" >
								<table width="100%">
									<tr>														
										<td class="FieldLabel" style="width:20%"><label>履行内部程序：</label></td>
										<td class="FieldInput" colspan="3" ><textarea rows="3" id="process" name='"基金会履行内部程序"' field="process" style="width:93%"></textarea><span style="color:red">*</span></td>
									</tr>	
								</table>
							</form>	
						</fieldset>		
						<fieldset>
							<legend>业务主管单位审查意见</legend>					
							<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" >
								<table width="100%">
									<tr>
										<td class="FieldLabel" style="width:20%">业务主管单位审查意见：</td>
										<td class="FieldInput" colspan="3"><textarea rows="3" id="borgOpinion" name="业务主管单位审查意见" field="borgOpinion" style="width:93%" ></textarea><span style="color:red">*</span></td>
									</tr>
								</table>
							</form>
						</fieldset>		
					</next:Html>
				</next:Panel>
	
				<next:Panel title="法律要件" >
					<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
						<next:TopBar>
							<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem iconCls="add" text="增加上传附件" handler="clickUploadFile"></next:ToolBarItem>
						</next:TopBar>
				
						<next:Columns>
							<next:RowNumberColumn />
							<next:RadioBoxColumn></next:RadioBoxColumn>
							<next:Column header="档案目录名"  field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect" ><next:TextField /></next:Column>
							<next:Column header="附件名称"    field="fileName" width="30%" editable="false"><next:TextField /></next:Column>
							<next:Column header="附件描述"    field="fileMess" width="20%" editable="false"><next:TextField /></next:Column>
							<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
						</next:Columns>
						<next:BottomBar>
							<next:PagingToolBar dataset="somElectronicDataSet" />
						</next:BottomBar>
					</next:EditGridPanel>
				</next:Panel>
				
				<next:Panel id="panelOpinion" title="处理意见" width="100%" height="100%" autoScroll="true">
					<next:Html>
						<fieldset>
							<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" >
								<table width="100%">
									<tr>
										<td class="FieldLabel" style="width:15%">承办人意见：</td>
										<td class="FieldInput" style="width:15%">
											<select field="acceptOpinionId" name='"承办人意见"' >
												<option dataset="opinionSelect"/>
											</select>
										</td>
										<td class="FieldLabel" style="width:15%">承办人：</td>
										<td class="FieldInput" style="width:15%"><input type="text" field="acceptPeopleName" name='承办人'  style="width:90%" />
										</td>
										<td class="FieldLabel" style="width:15%">承办时间：</td>
										<td class="FieldInput" style="width:25%"><input type="text" name='承办时间' field="acceptTime" onClick="WdatePicker()" />
										</td>
									</tr>
									<tr>
										<td class="FieldLabel">承办补充意见：</td>
										<td class="FieldInput" colspan="5"><textarea rows="3" name='承办补充意见' field="acceptOpinion" style="width:90%" ></textarea>
										</td>
									</tr>
									<tr>
										<td class="FieldLabel" >初审意见：</td>
										<td class="FieldInput" >
											<select field="examinOpinionId" name='"初审意见"' >
												<option dataset="opinionSelect"/>
											</select>
										</td>
										<td class="FieldLabel" >初审负责人：</td>
										<td class="FieldInput" ><input type="text" field="examinPeopleName" name='初审负责人'  style="width:90%" />
										</td>
										<td class="FieldLabel" >初审时间：</td>
										<td class="FieldInput" ><input type="text" name='初审时间' field="examinTime" onClick="WdatePicker()" />
										</td>
									</tr>
									<tr>
										<td class="FieldLabel">初审补充意见：</td>
										<td class="FieldInput" colspan="5"><textarea rows="3" name='初审补充意见' field="examinOpinion" style="width:90%" ></textarea>
										</td>
									</tr>
									<tr>
										<td class="FieldLabel" >审核意见：</td>
										<td class="FieldInput" >
											<select field="checkOpinionId" name='"审核意见"' >
												<option dataset="opinionSelect"/>
											</select>
										</td>
										<td class="FieldLabel" >审核人：</td>
										<td class="FieldInput" ><input type="text" field="checkPeopleName" name='审核人' style="width:90%" />
										</td>
										<td class="FieldLabel" >审核时间：</td>
										<td class="FieldInput" ><input type="text" name='审核时间' field="checkTime" onClick="WdatePicker()" />
										</td>
									</tr>
									<tr>
										<td class="FieldLabel">审核补充意见：</td>
										<td class="FieldInput" colspan="5"><textarea rows="3" name='审核补充意见' field="checkOpinion" style="width:90%" ></textarea>
										</td>
									</tr>
									<tr>
										<td class="FieldLabel" >批准意见：</td>
										<td class="FieldInput" >
											<select field="auditOpinionId" name='"批准意见"' >
												<option dataset="opinionSelect"/>
											</select>
										</td>
										<td class="FieldLabel" >批准人：</td>
										<td class="FieldInput" ><input type="text" field="auditPeopleName" name='批准人' style="width:90%" />
										</td>
										<td class="FieldLabel" >批准时间：</td>
										<td class="FieldInput" ><input type="text" name='批准时间' field="auditTime"onClick="WdatePicker()" />
										</td>
									</tr>
									<tr>
										<td class="FieldLabel">批准补充意见：</td>
										<td class="FieldInput" colspan="5"><textarea rows="3" name='批准补充意见' field="auditOpinion" style="width:90%" ></textarea>
										</td>
									</tr>
								</table>
							</form>
						</fieldset>					
					</next:Html>
				</next:Panel>
			</next:Tabs>
		</next:TabPanel>
	</next:Panel>
</next:ViewPort>
<jsp:include page="../../../comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>