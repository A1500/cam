<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>社会团体注销登记录入</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="groupHistoryCancel.js"></script>
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
		taskCode = '<%=SomIdHelp.getGroupTaskCode()%>';//生成业务编号
	}
	var method='<%=request.getParameter("method")%>';
	var sorgId='<%=sorgId%>';
</script>
</head>
<body>

<model:datasets>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">	
			<model:field name="appPeople" type="string" rule="length{72}" />	
			<model:field name="appPhone" type="string" rule="length{30}" />
			<model:field name="acceptPeopleName" type="string" rule="length{100}" />
			<model:field name="acceptOpinion" type="string" rule="length{500}"/>
			<model:field name="examinPeopleName" type="string" rule="length{30}" />
			<model:field name="examinOpinion" type="string" rule="length{30}" />
			<model:field name="checkPeopleName" type="string" rule="length{30}" />
			<model:field name="checkOpinion" type="string" rule="length{30}" />
			<model:field name="auditPeopleName" type="string" rule="length{30}" />
			<model:field name="auditOpinion" type="string" rule="length{30}" />		
		</model:record>
	</model:dataset>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryMain" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="sorgCode" type="string" rule="require"/>
			<model:field name="cancelDate" type="string" rule="require"/>
			<model:field name="cancelReason" type="string" rule="require|length{500}"/>
			<model:field name="liqResult" type="string" rule="require|length{200}"/>
			<model:field name="cnName" type="string" rule="require|length{100}"/>
		</model:record>
	</model:dataset>
	<model:dataset id="somLiqpeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomLiqpeopleQueryCmd" global="true" sortField="IF_CHIEF" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomLiqpeople"></model:record>
	</model:dataset>
	<model:dataset id="winLiqpeopleDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomGroupLiqpeopleQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomLiqpeople">
			<model:field name="name" type="string" rule="require|length{72}"/>
			<model:field name="liqDuties" type="string" rule="require|length{50}"/>
			<model:field name="ifChief" type="string" rule="require"/>
			<model:field name="workName" type="string" rule="length{100}"/>
			<model:field name="workDuties" type="string" rule="length{50}"/>			
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
	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>	
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+BspUtil.getOrganCode().substring(0,6)%>'></model:param>

		</model:params>
	</model:dataset>
	<model:dataset id="cancelReasonSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CANCEL_REASON'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
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
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="ifChiefSelect" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:ViewPort>
	<next:Panel width="100%" height="100%">
		<next:TopBar>
			<next:ToolBarItem symbol="社会团体注销登记"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="save" text="保存" handler="save" />	
			<next:ToolBarItem iconCls="return" text="返回" handler="goBack"></next:ToolBarItem>
		</next:TopBar>
		<next:TabPanel id="tabSomOrgan" width="100%" height="100%">	
			<next:Tabs>
				<next:Panel id="panelSomOrgan" title="社会团体法人注销登记表" width="100%" height="100%" autoScroll="true">
					<next:Html>
						<fieldset>
						<form id="cbForm" method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel" width="20%"><label>登记证号：</label></td>
								<td class="FieldInput" width="30%"><input id="sorgCode" field="sorgCode" name='"登记证号"' onkeyup="value=value.replace(/[^\\w\.\/]/ig,'').toUpperCase()"  onblur="loadSorg()" style="width:50%"/><span style="color:red">*</span></td>
								<td class="FieldLabel" width="20%"><label>社团代码：</label></td>
								<td class="FieldInput" width="30%"><label field="organCode" name='"社团代码"'/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>社团名称：</label></td>
								<td class="FieldInput"><label id="cnName" field="cnName" name='"社团名称"'/></td>
								<td class="FieldLabel"><label>成立日期：</label></td>
								<td class="FieldInput"><label field="buildDate" name='"成立日期"'/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>社团类别：</label></td>
								<td class="FieldInput">
									<select id="sorgKind" field="sorgKind" name='"社团类别"' style="width:50%" disabled="disabled">
										<option dataset="sorgKindSelect" ></option>
									</select>
								</td>
								<td class="FieldLabel"><label>所属行（事）业：</label></td>
								<td class="FieldInput">
									<select id="busScope" field="busScope" name='"所属行（事）业"' style="width:50%" disabled="disabled">
										<option dataset="busScopeSelect" ></option>
									</select>								
								</td>								
							</tr>
							<tr>							
								<td class="FieldLabel"><label>住所：</label></td>
								<td class="FieldInput"><label field="residence" name='"住所"'/></td>
								<td class="FieldLabel"><label>社团电话：</label></td>
								<td class="FieldInput"><label field="sorgPhone" name='"社团电话"'/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>法定代表人：</label></td>
								<td class="FieldInput"><label field="legalPeople" name='"法定代表人"' /></td>
								<td class="FieldLabel"><label>业务主管单位：</label></td>
								<td class="FieldInput">
									<select id="borgName" field="borgName" name='"业务主管单位"' style="width:80%" disabled="disabled">
										<option dataset="businessOrganSelect" ></option>
									</select>								
								</td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>注销社团原因：</label></td>
								<td class="FieldInput">
									<select id="cancelReason" field="cancelReason" name='"注销社团原因"' onchange="loadCancelReasonDesc()" style="width:50%">
										<option dataset="cancelReasonSelect"></option>
									</select><span style="color:red">*</span>
								</td>
								<td class="FieldLabel"><label>注销日期：</label></td>
								<td class="FieldInput"><input id="cancelDate" field="cancelDate" name='"注销日期"' onClick="WdatePicker()" /><span style="color:red">*</span></td>
							</tr>
							<tr id="cancelReasonDescTr" style="display:none">
								<td class="FieldLabel"><label>注销原因说明：</label></td>
								<td class="FieldInput" colspan="3"><textarea rows="3" id="cancelReasonDesc" field="cancelReasonDesc" name='"注销原因说明"' style="width:93%"></textarea><span style="color:red">*</span></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>清算结论：</label></td>
								<td class="FieldInput" colspan="3"><textarea rows="3" id="liqResult" field="liqResult" name='"清算结论"' style="width:93%"></textarea><span style="color:red">*</span></td>
							</tr>
						</table>
						</form>
						</fieldset>		
					</next:Html>
				</next:Panel>
	
				<next:GridPanel id="gridLiqpeople" dataset="somLiqpeopleDataSet" title="清算组织人员" width="100%" height="100%">
					<next:TopBar>
						<next:ToolBarItem symbol="清算组织主要组成人员列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加" handler="addLiqpeople"></next:ToolBarItem>
						<next:ToolBarItem iconCls="edit" text="修改" handler="editLiqpeople"></next:ToolBarItem>
						<next:ToolBarItem iconCls="remove" text="删除" handler="delLiqpeople"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="内码" field="id" hidden="true" />
						<next:Column header="姓名" field="name" width="10%" />
						<next:Column header="在清算组织中职务" field="liqDuties" width="25%" />
						<next:Column header="清算组织负责人" field="ifChief" dataset="yesornoDataSet" width="15%" />
						<next:Column header="工作单位" field="workName" width="18%" />
						<next:Column header="职务（职称）" field="workDuties" width="18%" />		
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somLiqpeopleDataSet"/>
					</next:BottomBar>
				</next:GridPanel>

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
										<td class="FieldInput" style="width:25%"><input type="text" name='承办时间' field="acceptTime"onClick="WdatePicker()" />
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
										<td class="FieldInput" ><input type="text" name='初审时间' field="examinTime" onClick="WdatePicker()"  />
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
										<td class="FieldInput" ><input type="text" name='审核时间' field="checkTime"onClick="WdatePicker()" />
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
										<td class="FieldInput" ><input type="text" name='批准时间' field="auditTime" onClick="WdatePicker()" />
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
<next:Window id="winLiqpeople" title="添加清算组织成员" width="650" height="100%" autoHeight="true" resizable="false" closeAction="hide" modal="true">
	<next:Panel id="panelWinLiqpeople">
		<next:Html>
			<form id="formWinLiqpeople" method="post" dataset="winLiqpeopleDataSet" onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel" width="25%"><label>姓名：</label></td>
					<td class="FieldInput" width="25%"><input name='"姓名"' field="name" width="90%"/><span style="color:red">*</span></td>
					<td class="FieldLabel" width="25%"><label>清算组织负责人：</label></td>
					<td class="FieldInput" width="25%">
						<select name='"清算组织负责人"' field="ifChief" style="width:70%">
							<option dataset="yesornoDataSet" ></option>
						</select><span style="color:red">*</span>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>在清算组织中职务：</label></td>
					<td class="FieldInput" colspan="3"><input name='"在清算组织中职务"' field="liqDuties" style="width:90%"/><span style="color:red">*</span></td>
				</tr>
				<tr>	
					<td class="FieldLabel"><label>工作单位：</label></td>
					<td class="FieldInput" colspan="3"><input name='"工作单位"' field="workName" style="width:90%"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>职务（职称）：</label></td>
					<td class="FieldInput" colspan="3"><input name='"职务（职称）"' field="workDuties" style="width:90%"/></td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>
	<next:Buttons>
		<next:ToolButton text="确定" handler="saveWinLiqpeople"></next:ToolButton>
		<next:ToolButton text="关闭" handler="closeWinLiqpeople"></next:ToolButton>
	</next:Buttons>
</next:Window>
<jsp:include page="../../../comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>