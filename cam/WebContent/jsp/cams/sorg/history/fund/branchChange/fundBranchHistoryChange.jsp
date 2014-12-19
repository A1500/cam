<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.StrUtil"%>
<%@page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<%@page import="com.inspur.cams.sorg.util.ApplyType"%>
<html>
<!-- 基金会分支/代表机构变更历史采集页面 -->
<head>
	<next:ScriptManager></next:ScriptManager>
	<script type="text/javascript" src="fundBranchHistoryChange.js"></script>
	<script type="text/javascript" src="<%=SkinUtils.getJS(request, "changeCheck.js")%>"></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js") %>'></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js") %>'></script>
	<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
	
<script>
		<%
			String taskCode=request.getParameter("taskCode");
			if(taskCode==null){
				taskCode="";
			}
		%>
		var rootPath="<%=SkinUtils.getRootUrl(request)%>";
		var taskCode='<%=taskCode%>';//业务编号
		if(taskCode == ''){
			taskCode = '<%=StrUtil.n2b(SomIdHelp.getFundTaskCode())%>';//生成业务编号
		}
	var somApplyType='<%=ApplyType.SOM_FUND_BRANCH_CHANGE%>';//业务类型
	var method='<%=request.getParameter("method")%>';
	var applyType="231";
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryOrgan">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<!-- 变更申请dataset -->
	<model:dataset id="somOrganDataSet1" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryOrgan">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<!-- 负责人信息 -->
	<model:dataset id="somDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 分支负责人 -->
	<model:dataset id="chargerDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 分支负责人 -->
	<model:dataset id="chargerDataSet1" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<%--分支负责人简历 --%>
	<model:dataset id="somResumeLegalDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<!-- 变更列表的dataset -->
	<model:dataset id="somChangeList" cmd="com.inspur.cams.sorg.manage.cmd.SomChangeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomChange"></model:record>
	</model:dataset>
	<!-- 变更申请dataset -->
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" >
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
	<!-- 变更window的dataset -->
	<model:dataset id="somChangeDataset" cmd="com.inspur.cams.sorg.manage.cmd.SomChangeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomChange"></model:record>
	</model:dataset>
	<model:dataset id="somChangeDetail" cmd="com.inspur.cams.sorg.manage.cmd.SomChangeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomChange"></model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog" isGroup="true" groupField="applyType" pageSize="50">
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
	<%--法定代表人员电子档案--%>
	<model:dataset id="somLegalPeopleElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryPeopleCatalog" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--法定代表人员电子档案上传窗口--%>
	<model:dataset id="winLegalPeopleElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryPeopleElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="politicsDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgDutiesDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="ifFulltimeDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="folkDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="countrySelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="SORT_NO">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_COUNTRY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="somChangeItem" enumName="SOM.BRANCH.CHANGE.ITEM"  autoLoad="true" global="true"></model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>		
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="hisOpinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel title="基金会变更" width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>			
		<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
		<%if(request.getParameter("method").equals("UPDATE")){ %>
			<next:ToolBarItem iconCls="save" text="修订保存" handler="reviseSave"></next:ToolBarItem>
		<%} %>
		<next:ToolBarItem iconCls="undo" text="返回" handler="goBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel width="100%" height="100%" id="tab" activeTab="1">
		<next:Tabs>
			<next:Panel title="基金会分支/代表机构变更登记申请表" width="100%" height="100%" autoScroll="true">
				<next:Panel>
					<next:Html>
						<fieldset><legend>变更信息</legend>
						<form method="post" onsubmit="return false" class="L5form">
							<table width="100%">
							<tr>
								<td class="FieldLabel" style="width: 10%;"><label>分支/代表机构登记证号：</label></td>
								<td class="FieldInput" style="width: 10%;"><input type="text" id="sorgCode" onkeyup="value=value.replace(/[^\-\\w\.\/]/ig,'').toUpperCase()" onblur="loadSorg();"/></td>
								<td class="FieldLabel" style="width: 10%;"><label>分支/代表机构名称：</label></td>
								<td class="FieldInput" style="width: 10%;"><label id="cnName"></label></td>
								
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 10%;"><label>基金会登记证号：</label></td>
								<td class="FieldInput" style="width: 10%;"><label id="sorgCodeM"></label></td>
								<td class="FieldLabel" style="width: 10%;"><label>基金会名称：</label></td>
								<td class="FieldInput" style="width: 10%;"><label id="cnNameM"></label></td>
								
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 10%;"><label>法定代表人：</label></td>
								<td class="FieldInput" style="width: 10%;"><label id="legalPeople"></label></td>
								<td class="FieldLabel" style="width: 10%;"><label>负责人：</label></td>
								<td class="FieldInput" style="width: 10%;"><label id="charger"></label></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 10%;"><label>申请时间：</label></td>
								<td class="FieldInput" style="width: 10%;"><input type="text" id="appDate" onClick="WdatePicker()"/><font color="red">*</font></td>
								<td class="FieldLabel" style="width: 10%;"><label></label></td>
								<td class="FieldInput" style="width: 10%;"><label></label></td>
							</tr>
							</table>
						</form>
						</fieldset>
					</next:Html>
				</next:Panel>
				<next:EditGridPanel id="changeEdit" dataset="somChangeList" height="60%" autoScroll="true">
					<next:TopBar>
						<next:ToolBarItem text='' id="displayItem"/>
						<next:ToolBarItem symbol="变更事项"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem text="增加变更" iconCls="add" handler="forAdd"></next:ToolBarItem>
						<next:ToolBarItem text="修改变更" iconCls="edit"  handler="forUpdate"></next:ToolBarItem>
						<next:ToolBarItem text="查看变更" iconCls="edit" handler="detailForChange"></next:ToolBarItem>
						<next:ToolBarItem text="删除变更" iconCls="remove" handler="forDelete"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="变更事项" field="changeItem" 
							 width="17%" editable="false" dataset="somChangeItem">
							<next:TextField />
						</next:Column>
						<next:Column header="变更前" field="changeBefore" 
							 width="30%"editable="false">
							<next:TextField/>
						</next:Column>
						<next:Column header="拟变更为" field="changeAfter" 
							 width="20%" editable="false">
							<next:TextField/>
						</next:Column>
						<next:Column header="变更理由" field="changeReason" 
							 width="30%" editable="false">
							<next:TextField/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				<next:Html>
				<fieldset><legend>基金会内部履行程序</legend>
				<form method="post" onsubmit="return false" class="L5form">
					<table width="100%">
					<tr>	
						<td class="FieldInput"colspan="3"><textarea name="基金会内部履行程序" id="process" cols="65" rows="4" style="width:95%"></textarea></td>
					</tr>
					</table>
				</form>
				</fieldset>
				</next:Html>
			</next:Panel>
			<next:Panel title="法律要件">
				<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet" autoScroll="true">
					<next:GroupingView forceFit="true"></next:GroupingView>
					<next:TopBar>
						<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加上传附件" handler="uploadFile"></next:ToolBarItem>
					</next:TopBar>
			
					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="档案目录名"  field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect"><next:TextField /></next:Column>
						<next:Column header="附件名称"    field="fileName" width="30%" editable="false"><next:TextField /></next:Column>
						<next:Column header="附件描述"    field="fileMess" width="20%" editable="false"><next:TextField /></next:Column>
						<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField/></next:Column>
						<next:Column header="业务类型"    field="applyType" hidden="true">
							<next:ExtendConfig>
								groupRenderer:grender,groupName:"法律要件目录"
							</next:ExtendConfig>
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somElectronicDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
			<next:Panel title="填写意见" id="ipinionPanel" width="100%" height="100%" autoScroll="true" style="display:block;">
							<next:Html>
						<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" >
					<fieldset>
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
									<td class="FieldInput" ><input type="text" name='初审时间' field="examinTime"onClick="WdatePicker()"  />
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
									<td class="FieldInput" ><input type="text" name='审核时间' field="checkTime" onClick="WdatePicker()"  />
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
									<td class="FieldInput" ><input type="text" name='批准时间' field="auditTime"onClick="WdatePicker()"  />
									</td>
								</tr>
								<tr>
									<td class="FieldLabel">批准补充意见：</td>
									<td class="FieldInput" colspan="5"><textarea rows="3" name='批准补充意见' field="auditOpinion" style="width:90%" ></textarea>
									</td>
								</tr>
							</table>
					</fieldset>					
						</form>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<!-- 基金会名称变更 -->
<next:Window id="detail0" closeAction="hide" title="名称变更" width="600"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWin"></next:ToolBarItem>
	</next:TopBar>
<next:Html>
	<form method="post" onsubmit="return false" class="L5form" dataset="somChangeDetail">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:25%"><label>名称变更前：</label></td>
				<td class="FieldInput" style="width:75%"><label id="nameBefore1" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label  style="color:blue">名称变更为：</label></td>
				<td class="FieldInput"><label  id="nameAfter1" style="color:blue"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label  style="color:blue">变更理由：</label></td>
				<td class="FieldInput"><textArea cols="75" rows="4" style="width: 100%;color:blue" field="changeReason" readonly="readonly"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>

<!-- 法定代表人变更 -->
<next:Window id="detail2" closeAction="hide" title="负责人变更" width="600"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="查看负责人" iconCls="add" handler="addLegalPeople"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDetail">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:25%"><label>负责人姓名变更前：</label></td>
				<td class="FieldInput"style="width:25%"><label  id="leaPeopleNameBefore1" /></td>
				<td class="FieldLabel"style="width:25%"><label style="color:blue">负责人姓名变更为：</label></td>
				<td class="FieldInput"style="width:25%"><label field="changeAfter" style="color:blue"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea cols="75" rows="4" style="width: 100%;color:blue" readonly="readonly" field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>
<!-- 住所变更 -->
<next:Window id="detail1" closeAction="hide" title="住所变更" width="500"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDetail">

<table width="100%">
			
			<tr>
				<td class="FieldLabel" style="width:25%"><label>住所名称变更前：</label></td>
				<td class="FieldInput" style="width:75%"><label id="houseNameBefore1"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">住所名称变更为：</label></td>
				<td class="FieldInput"><label id="houseNameAfter1"  style="color:blue"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput"><textArea cols="75" rows="4" readonly="readonly" style="width: 100%;color:blue" field="changeReason" ></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>
<!-- 业务范围变更 -->
<next:Window id="detail3" closeAction="hide" title="业务范围变更" width="600"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDetail">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:25%"><label>业务范围变更前：</label></td>
				<td class="FieldInput"style="width:75%"><textArea  field='changeBefore' disabled="disabled" cols="75" rows="4" style="width: 100%"></textArea></td>
			</tr>
			<tr>
				<td class="FieldLabel"style="width:15%"><label style="color:blue">业务范围变更为：</label></td>
				<td class="FieldInput"style="width:15%"><textArea  field="changeAfter" readonly="readonly" cols="75" rows="4" style="width: 100%;color:blue"></textArea></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea readonly="readonly" cols="75" rows="4" style="width: 100%;color:blue" field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>

<!--添加变更  -->
<next:Window id="AddChange" closeAction="hide" title="添加变更" width="400"  autoScroll="true">
<next:Html>
	<form method="post" onsubmit="return false" class="L5form">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:15%"><label>变更事项：</label></td>
				<td class="FieldInput"style="width:15%"><select id="addChangeItem" ><option dataset="somChangeItem" ></option></select></td>
				<td class="FieldLabel"style="width:15%"><input type="button" value="确定" onclick="forChangeItem(addChangeItem.value)"/></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>
<!-- 基金会名称变更 -->
<next:Window id="AddChange0" closeAction="hide" title="名称变更" width="600"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="forNameMove" ></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWinD"></next:ToolBarItem>
	</next:TopBar>
<next:Html>
	<form method="post" onsubmit="return false" class="L5form" dataset="somChangeDataset">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:25%"><label>名称变更前：</label></td>
				<td class="FieldInput"style="width:75%"><label id="nameBefore"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">名称变更为：</label></td>
				<td class="FieldInput"><input id='nameAfter' type="text"  style="width:98%"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput"><textArea id="nameReason" cols="75" rows="4" style="width: 100%" field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>

<!-- 法定代表人变更 -->
<next:Window id="AddChange2" closeAction="hide" title="负责人变更" width="600"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="查看负责人" iconCls="add" handler="addLegalPeople"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="forLeaPeopleMove" ></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWinD"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDataset">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:15%"><label>负责人姓名变更前：</label></td>
				<td class="FieldInput"style="width:15%"><label  id="leaPeopleNameBefore" /></td>
				<td class="FieldLabel"style="width:15%" style="color:blue"><label>负责人姓名变更为：</label></td>
				<td class="FieldInput"style="width:15%"><input id='leaPeopleNameAfter' type="text" readonly="readonly"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea id="leaPeopleReason"cols="75" rows="4" style="width: 100%" field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>
<!-- 住所变更 -->
<next:Window id="AddChange1" closeAction="hide" title="住所变更" width="500"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="forHouseMove" ></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWinD"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDataset">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:25%"><label>住所名称变更前：</label></td>
				<td class="FieldInput" style="width:75%"><label id="houseNameBefore"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">住所名称变更为：</label></td>
				<td class="FieldInput"><input id="houseNameAfter" type="text" style="width:98%"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput"><textArea id="houseReason" cols="75" rows="4" style="width: 100%" field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>
<!-- 业务范围变更 -->
<next:Window id="AddChange3" closeAction="hide" title="业务范围变更" width="600"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="forBusinessMove" ></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWinD"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDataset">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:25%"><label>业务范围变更前：</label></td>
				<td class="FieldInput" style="width:75%"><textArea id="businessNameBefore" disabled="disabled" field="changeBefore" cols="75" rows="4" style="width: 100%" ></textArea></td>
			</tr>
			<tr>
				<td class="FieldLabel"style="width:15%"><label style="color:blue">业务范围变更为：</label></td>
				<td class="FieldInput" style="width:15%"><textArea id="businessNameAfter" field="changeAfter" cols="75" rows="4" style="width: 100%" ></textArea></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea id="businessReason"cols="75" rows="4" style="width: 100%" field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>
<next:Window id="legalPeopleWindow" title="负责人信息" resizable="false" width="800" height="400" modal="true" closeAction="hide"  closable="false">
	<next:TabPanel  width="98%" height="84%" >
		<next:Tabs>
			<next:Panel  title="基金会分支（代表）机构负责人备案表" width="100%" height="100%" autoScroll="true">
				<next:Html>
					<form id="peopleFrom" method="post" dataset="chargerDataSet1" onsubmit="return false" class="L5form">
						<input type="hidden" id="peopleId" field="peopleId">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width:15%">身份证号码：</td>
								<td class="FieldInput" style="width:21%"><label id="labelIdCard" field="idCard"/></td>
								<td class="FieldLabel" style="width:14%">姓名：</td>
								<td class="FieldInput" style="width:17%"><label field="name"/></td>
								<td class="FieldLabel" style="width:14%" rowspan="4">照片:</td>
								<td class="FieldInput" style="width:19%" nowrap colspan="1" rowspan="4">
								<div id="photoDiv">
									<img id="img" name="RELATIONER_PHOTOC_IMG" width=82.5 height=110 src="<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg" 
									align="top" ondblclick="editPhoto(1,'photoId','RELATIONER_PHOTOC_IMG');"
									onerror="javascript:this.src='<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg'" alt="暂无图片" />
									<input type="hidden" id="photoId" name="photoId"/>
								</div>	
							</tr>
							<tr>
								<td class="FieldLabel">曾用名：</td>
								<td class="FieldInput"><label field="aliasName"/></td>
								<td class="FieldLabel">年龄：</td>
								<td class="FieldInput"><label id="labelAge" name='年龄'/></td>
							</tr>
							<tr>
								<td class="FieldLabel">性别：</td>
								<td class="FieldInput"><label field="sex" dataset="sexDataSet"/></td>
								<td class="FieldLabel">出生年月：</td>
								<td class="FieldInput"><label field="birthday"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">政治面貌：</td>
								<td class="FieldInput"><label field="politics" dataset="politicsDataSet"/></td>
								<td class="FieldLabel">民族：</td>
								<td class="FieldInput"><label field="folk" dataset="folkDataSet"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">国籍：</td>
								<td class="FieldInput" ><label field="nation" dataset="countrySelect"/></td>
								<td class="FieldLabel">家庭住址：</td>
								<td class="FieldInput" ><label field="adds"/></td>
								<td class="FieldLabel">户口所在地：</td>
								<td class="FieldInput"><label field="populace"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">邮编：</td>
								<td class="FieldInput"><label field="postCode"/></td>
								<td class="FieldLabel">电话：</td>
								<td class="FieldInput"><label field="phone"/></td>
								<td class="FieldLabel">专/兼职：</td>
								<td class="FieldInput"><label field="ifFulltime" dataset="ifFulltimeDataSet" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">工作单位：</td>
								<td class="FieldInput" colspan="3"><label field="workName"/></td>
								<td class="FieldLabel">工作单位职务：</td>
								<td class="FieldInput"><label field="workDuties"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">社团职务：</td>
								<td class="FieldInput"><label field="sorgDuties" dataset="sorgDutiesDataSet"/></td>
								<td class="FieldLabel">任职开始日期：</td>
								<td class="FieldInput"><label field="startDate"/></td>
								<td class="FieldLabel"><label>任职结束日期：</label></td>
								<td class="FieldInput"></td>
							</tr>
							<tr>
								<td class="FieldLabel">是否党政机关领导干部：</td>
								<td class="FieldInput"><label field="ifPartyLeader" dataset="yesornoDataSet"/></td>
								<td class="FieldLabel">批准机关：</td>
								<td class="FieldInput"><label field="promiseOrgan"/></td>
								<td class="FieldLabel">批准文号：</td>
								<td class="FieldInput"><label field="promiseCode" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">本人所在单位人事部门审查意见：</td>
								<td class="FieldInput" colspan="5"><textarea rows="2" name='"所在单位人事部门审查意见"' readonly="readonly" field="workOpinion" style="width:97.7%"></textarea><span style="color:red">*</span></td>
							</tr>
							<tr>
								<td class="FieldLabel">审查工作单位：</td>
								<td class="FieldInput" colspan="3"><label  field="workName"/></td>
								<td class="FieldLabel">审查日期：</td>
								<td class="FieldInput"><label  field="workCheckDate"/></td>
							</tr>
							<tr>
									<td class="FieldLabel"><label>按照本社会团体章程会议产生通过情况：</label></td>
									<td class="FieldInput" colspan="5"><textarea   rows="2" name='"按照本社会团体章程会议产生通过情况"' field="sorgOpinion" style="width:97.7%"></textarea><span style="color:red">*</span></td>
								</tr>
								<tr>	
									<td class="FieldLabel"><label>签署日期：</label></td>
									<td class="FieldInput" colspan="5"><input type="text"  field="sorgCheckDate"onClick="WdatePicker()" style="width:22%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">备注：</td>
								<td class="FieldInput" colspan="5"><textarea rows="2" name='"备注"' readonly="readonly" field="note" style="width:97.7%"></textarea></td>
							</tr>
						</table>
					</form>
				</next:Html>
			</next:Panel>
			<next:EditGridPanel id="somResumeLegalGrid" dataset="somResumeLegalDataSet" stripeRows="true" title="本人简历" width="100%" height="100%" autoScroll="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="内码" field="id" width="15%" editable="false" hidden="true"><next:TextField/></next:Column>
					<next:Column header="开始年月" field="startDate" width="10%" editable="false" ><next:TextField/></next:Column>
					<next:Column header="结束年月" field="endDate" width="10%" editable="false"><next:TextField/></next:Column>
					<next:Column header="在何地区何单位" field="workOrgan" width="45%" editable="false"><next:TextField/></next:Column>
					<next:Column header="任（兼）何职" field="duty" width="20%" editable="false"><next:TextField/></next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somResumeLegalDataSet" />
				</next:BottomBar>
			</next:EditGridPanel>
			<next:EditGridPanel id="uploadLegalPeopleGrid" title="法律要件" stripeRows="true" dataset="somLegalPeopleElectronicDataSet" width="100%" height="100%" autoScroll="true">
				<next:TopBar>
					<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="add" text="增加上传附件" handler="uploadLegalPeopleFile"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn />
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="档案目录名" field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect">
						<next:TextField />
					</next:Column>
					<next:Column header="附件名称" field="fileName" width="30%" editable="false">
						<next:TextField />
					</next:Column>
					<next:Column header="附件描述" field="fileMess" width="20%" editable="false">
						<next:TextField />
					</next:Column>
					<next:Column header="下载附件" field="" width="10%" editable="false" renderer="clickDownloadLegalPeopleHref">
						<next:TextField />
					</next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somLegalPeopleElectronicDataSet" />
				</next:BottomBar>
			</next:EditGridPanel>
		</next:Tabs>
	</next:TabPanel>	
	<next:Buttons>
		<next:ToolButton text="关闭"handler="closePeopleWin"></next:ToolButton>
	</next:Buttons>
</next:Window>
<jsp:include page="../../../comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>