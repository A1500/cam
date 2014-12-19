<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
<head>
<title></title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="samGerocomiumInfoInsert1.js"></script>
<script type="text/javascript">
	<%
	String gerocomiumId=request.getParameter("gerocomiumId");
	String method=request.getParameter("method");
	String newGerocomiumId=IdHelp.getUUID32();
	String recordId=request.getParameter("recordId");
	%>
	var gerocomiumId='<%=request.getParameter("gerocomiumId")%>';
	var method='<%=request.getParameter("method")%>';
	var newGerocomiumId='<%=newGerocomiumId%>';
	var recordId='<%=recordId%>';
</script>
<script type="text/javascript">
		    <%
		    String organArea=BspUtil.getCorpOrgan().getOrganCode();
			String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
		    %>
			var organArea='<%=organArea%>';
			var organName='<%=organName%>';
		</script>
</head>
<body>
<model:datasets>
	<!-- 敬老院信息 -->
	<model:dataset id="samGerocomiumInfoDataSet"
		cmd="com.inspur.cams.drel.samu.cmd.SamGerocomiumInfoQueryCmd"
		pageSize="15">
		<model:record
			fromBean="com.inspur.cams.drel.samu.data.SamGerocomiumInfo" />
	</model:dataset>
	<!-- 敬老院等级 -->
	<model:dataset id="gerocomiumLevelDataset"
		enumName="SAM_GEROCOMIUM_LEVEL" autoLoad="true" global="true"></model:dataset>
	<!-- 房屋性质 -->
	<model:dataset id="housePropertyDataset" enumName="SAM_HOUSE_PROPERTY"
		autoLoad="true" global="true"></model:dataset>
	<!-- 取暖方式 -->
	<model:dataset id="heatingWayDataset" enumName="SAM_HEATING_WAY"
		autoLoad="true" global="true"></model:dataset>
	<!-- yes or no -->
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
		<!-- 房间信息 -->
	<model:dataset id="samRoomInfoDataSet"
		cmd="com.inspur.cams.drel.samu.cmd.SamRoomInfoQueryCmd" pageSize="15">
		<model:record fromBean="com.inspur.cams.drel.samu.data.SamRoomInfo" />
	</model:dataset>
	<!-- 房间状态 -->
	<model:dataset id="samStatusDataSet" enumName="SAM_STATUS"
		autoLoad="true" global="true"></model:dataset>
		<!-- 员工信息 -->
	<model:dataset id="samWorkerInfoDataSet"
		cmd="com.inspur.cams.drel.samu.cmd.SamWorkerInfoQueryCmd"
		pageSize="15">
		<model:record fromBean="com.inspur.cams.drel.samu.data.SamWorkerInfo" />
	</model:dataset>
	<!-- 文化程序 -->
	<model:dataset id="samEducationLevelDataSet"
		enumName="SAM_EDUCATION_LEVEL" autoLoad="true" global="true"></model:dataset>
	<!-- 岗位性质 -->
	<model:dataset id="samPostPropertyDataSet" enumName="SAM_POST_PROPERTY"
		autoLoad="true" global="true"></model:dataset>
	<!-- 工种 -->
	<model:dataset id="samWorkTypeDataSet" enumName="SAM_WORK_TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 工作人员职务 -->
	<model:dataset id="samPositonDataSet" enumName="SAM_POSITON"
		autoLoad="true" global="true"></model:dataset>
		<!-- 床位信息 -->
	<model:dataset id="samBedInfoDataSet" 
		cmd="com.inspur.cams.drel.samu.cmd.SamBedInfoQueryCmd" 
		pageSize="15">
		<model:record fromBean="com.inspur.cams.drel.samu.data.SamBedInfo"/>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="sexDataset" enumName="SAM_SEX"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel autoHeight="true" bodyStyle="width:100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="saveInfo" />
		<next:ToolBarItem iconCls="undo" text="返回" handler="undo" />
	</next:TopBar>
	<next:TabPanel>
		<next:Tabs>
			<next:Panel title="敬老院基本信息" width="100%" height="100%">
				<next:Html>
					<form id="form1" method="post" dataset="samGerocomiumInfoDataSet"
						onsubmit="return false" class="L5form">
					<fieldset><legend>敬老院基础信息</legend>
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width: 15%">年份：</td>
							<td class="FieldInput" style="width: 18%"><input type="text"
								name="年份" id="year" field="year" maxlength="50"
								style="width: 40%" /><font color="red">*</font> <input
								type="hidden" name="敬老院ID" id="gerocomiumId"
								field="gerocomiumId" maxlength="50" style="width: 80%" /></td>

							<td class="FieldLabel" style="width: 15%">名称：</td>
							<td class="FieldInput" style="width: 18%"><input type="text"
								name="名称" id="gerocomiumName" field="gerocomiumName"
								maxlength="50" style="width: 80%" /><font color="red">*</font></td>

							<td class="FieldLabel" style="width: 15%">建院时间：</td>
							<td class="FieldInput" style="width: 18%"><input type="text"
								name="建院时间" id="establishDate" field="establishDate"
								format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"
								style="width: 80%" /><font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%">主管单位名称：</td>
							<td class="FieldInput" style="width: 18%"><input type="text"
								name="主管单位名称" id="manaLevel" field="manaLevel" maxlength="50"
								style="width: 80%" readonly="readonly"/><img
								src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
								style="cursor: hand" onclick="func_ForManaSelect()" /> <input
								type="text" id="manaLevelId" name="manaLevelId" field="manaLevelId"
								style="display: none" /></td>

							<td class="FieldLabel" style="width: 15%">所属行政区划：</td>
							<td class="FieldInput" style="width: 18%"><input type="text"
								name="所属行政区划" id="areaLevel" field="areaLevel" maxlength="50"
								style="width: 80%" readonly="readonly"/><img
								src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
								style="cursor: hand" onclick="func_ForAreaSelect()" /> <input
								type="text" id="areaLevelId" name="areaLevelId" field="areaLevelId"
								style="display: none" /></td>
						
							<td class="FieldLabel" style="width: 15%">法人代表：</td>
							<td class="FieldInput" style="width: 18%"><input type="text"
								name="法人代表" id="legelPeople" field="legelPeople" maxlength="50"
								style="width: 80%" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%">总房间数：</td>
							<td class="FieldInput" style="width: 18%"><input type="text"
								name="总房间数" id="totalRoomNum" field="totalRoomNum" maxlength="50"
								style="width: 80%" /></td>
								
							<td class="FieldLabel" style="width: 15%">总床位数：</td>
							<td class="FieldInput" style="width: 18%"><input type="text"
								name="总床位数" id="totalBedNum" field="totalBedNum" maxlength="50"
								style="width: 80%" /></td>
								
							<td class="FieldLabel" style="width: 15%">等级：</td>
							<td class="FieldInput" style="width: 18%"><select
								id="gerocomiumLevel" name="等级" title="等级"
								field="gerocomiumLevel" style="width: 80%">
								<option dataset=gerocomiumLevelDataset></option>
							</select></td>
						</tr>
						<tr>

							<td class="FieldLabel" style="width: 15%">占地面积：<br>
							(单位：亩)</td>
							<td class="FieldInput" style="width: 18%"><input type="text"
								name="占地面积" id="totalArea" field="totalArea" maxlength="50"
								style="width: 80%" /></td>
							<td class="FieldLabel" style="width: 15%">建筑面积：<br>
							(单位：平米)</td>
							<td class="FieldInput" style="width: 18%"><input type="text"
								name="建筑面积" id="buildArea" field="buildArea" maxlength="50"
								style="width: 80%" /></td>

							<td class="FieldLabel" style="width: 15%">室外娱乐场所面积：<br>
							(单位：平米)</td>
							<td class="FieldInput" style="width: 18%"><input type="text"
								name="室外娱乐场所面积" id="outdoorArea" field="outdoorArea"
								maxlength="50" style="width: 80%" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%">室内娱乐场所面积：<br>
							(单位：平米)</td>
							<td class="FieldInput" style="width: 18%"><input type="text"
								name="室内娱乐场所面积" id="indoorArea" field="indoorArea"
								maxlength="50" style="width: 80%" /></td>
						
							<td class="FieldLabel" style="width: 15%">固定资产：<br>
							(单位：万元)</td>
							<td class="FieldInput" style="width: 18%"><input type="text"
								name="固定资产" id="fixedAssets" field="fixedAssets" maxlength="50"
								style="width: 80%" /></td>

							<td class="FieldLabel" style="width: 15%">五保对象供养标准：<br>
							(单位：元/年)</td>
							<td class="FieldInput" style="width: 18%"><input type="text"
								name="五保对象供养标准" id="supportStandard" field="supportStandard"
								maxlength="50" style="width: 80%" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%">管理工作经费：<br>
							(单位：万元/年)</td>
							<td class="FieldInput" style="width: 18%"><input type="text"
								name="管理工作经费" id="managementFunds" field="managementFunds"
								maxlength="50" style="width: 80%" /></td>
						
							<td class="FieldLabel" style="width: 15%">年副业收入：<br>
							(单位：万元/年)</td>
							<td class="FieldInput" style="width: 18%"><input type="text"
								name="年副业收入" id="yearSidelineIncome" field="yearSidelineIncome"
								maxlength="50" style="width: 80%" /></td>

							<td class="FieldLabel" style="width: 15%">联系电话：</td>
							<td class="FieldInput" style="width: 18%"><input type="text"
								name="联系电话" id="contactPhone" field="contactPhone"
								maxlength="50" style="width: 80%" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%">所在地址：</td>
							<td class="FieldInput" style="width: 18%"><input type="text"
								name="所在地址" id="location" field="location" maxlength="50"
								style="width: 80%" /></td>
						
							<td class="FieldLabel" style="width: 15%">房屋性质：</td>
							<td class="FieldInput" style="width: 18%"><select
								id="houseProperty" name="房屋性质" title="房屋性质"
								field="houseProperty" style="width: 80%">
								<option dataset=housePropertyDataset></option>
							</select></td>

							<td class="FieldLabel" style="width: 15%">所服务乡镇：</td>
							<td class="FieldInput" style="width: 18%"><input type="text"
								name="所服务乡镇" id="serveTowns" field="serveTowns" maxlength="50"
								style="width: 80%" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%">取暖方式：</td>
							<td class="FieldInput" style="width: 18%"><select
								id="heatingWay" name="取暖方式" title="取暖方式" field="heatingWay"
								style="width: 80%">
								<option dataset=heatingWayDataset></option>
							</select></td>
						
							<td class="FieldLabel" style="width: 15%">管理制度是否健全：</td>
							<td class="FieldInput" style="width: 18%"><select
								id="isManagePerfect" name="管理制度是否健全" title="管理制度是否健全"
								field="isManagePerfect" style="width: 80%">
								<option dataset=comm_yesorno></option>
							</select></td>

							<td class="FieldLabel" style="width: 15%">岗位责任制是否健全：</td>
							<td class="FieldInput" style="width: 18%"><select
								id="isPostPerfect" name="岗位责任制是否健全" title="岗位责任制是否健全"
								field="isPostPerfect" style="width: 80%">
								<option dataset=comm_yesorno></option>
							</select></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%">是否建立院管委会：</td>
							<td class="FieldInput" style="width: 18%"><select
								id="isEstablish" name="是否建立院管委会" title="是否建立院管委会"
								field="isEstablish" style="width: 80%">
								<option dataset=comm_yesorno></option>
							</select></td>
						
							<td class="FieldLabel" style="width: 15%">开展活动情况：</td>
							<td class="FieldInput" style="width: 18%"><input type="text"
								name="开展活动情况" id="activityAbout" field="activityAbout"
								maxlength="50" style="width: 80%" /></td>

							<td class="FieldLabel" style="width: 15%">院务是否公开：</td>
							<td class="FieldInput" style="width: 18%"><select
								id="isManagePublic" name="院务是否公开" title="院务是否公开"
								field="isManagePublic" style="width: 80%">
								<option dataset=comm_yesorno></option>
							</select></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%">财务是否公开：</td>
							<td class="FieldInput" style="width: 18%"><select
								id="isFinancialPublic" name="财务是否公开" title="财务是否公开"
								field="isFinancialPublic" style="width: 80%">
								<option dataset=comm_yesorno></option>
							</select></td>
						
							<td class="FieldLabel" style="width: 15%">娱乐健身器材情况：</td>
							<td class="FieldInput" style="width: 18%"><input type="text"
								name="娱乐健身器材情况" id="equipmentAbout" field="equipmentAbout"
								maxlength="50" style="width: 80%" /></td>

							<td class="FieldLabel" style="width: 15%">年种植蔬菜面积：<br>
							(单位：亩)</td>
							<td class="FieldInput" style="width: 18%"><input type="text"
								name="年种植蔬菜面积" id="vegetablesArea" field="vegetablesArea"
								maxlength="50" style="width: 80%" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%">年蔬菜产量：<br>
							(单位：斤)</td>
							<td class="FieldInput" style="width: 18%"><input type="text"
								name="年蔬菜产量" id="vegetablesYield" field="vegetablesYield"
								maxlength="50" style="width: 80%" /></td>
						
							<td class="FieldLabel" style="width: 15%">备注：</td>
							<td class="FieldInput" style="width: 18%" colspan="5"><textarea
								name="备注" title="备注" id="remarks" field="remarks"
								style="width: 97%" /></textarea></td>
						</tr>
					</table>
					</fieldset>
					</form>
				</next:Html>
			</next:Panel>
			<%-- <next:Panel title="房间基本信息" width="100%" height="100%"   >
				<next:EditGridPanel id="gridRoom" dataset="samRoomInfoDataSet"
					width="99%" stripeRows="true" height="99.9%">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加" handler="addRoom"></next:ToolBarItem>
						<next:ToolBarItem iconCls="edit" text="修改" handler="editRoom"></next:ToolBarItem>
						<next:ToolBarItem iconCls="delete" text="删除" handler="deleteRoom"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn></next:RowNumberColumn>
						<next:RadioBoxColumn></next:RadioBoxColumn>

						<next:Column field="roomName" header="房间编号或名称" sortable="false" />
						<next:Column field="inuseArea" header="使用面积" sortable="false" />
						<next:Column field="isToilet" header="是否带卫生间"
							dataset="comm_yesorno" sortable="false" />
						<next:Column field="bedNum" header="床位数" sortable="false" />
						<next:Column field="status" header="当前状态"
							dataset="samStatusDataSet" sortable="false" />
						<next:Column field="remarks" header="备注" sortable="false" />
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="samRoomInfoDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>
				<next:EditGridPanel id="gridBed" dataset="samBedInfoDataSet" hidden="true"
					width="99%" stripeRows="true" height="99.9%">
					<next:Columns>
						<next:RowNumberColumn></next:RowNumberColumn>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column field="bedName" header="床位编号/名称" sortable="false">
						<next:TextField></next:TextField>
						</next:Column>
						<next:Column field="remarks" header="备注" sortable="false" >
						<next:TextField></next:TextField>
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="samBedInfoDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel> --%>
			<next:Panel title="工作人员基本信息" width="100%" height="100%">
				<next:EditGridPanel id="gridWorker" dataset="samWorkerInfoDataSet"
					width="99%" stripeRows="true" height="99.9%">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加" handler="addWorker"></next:ToolBarItem>
						<next:ToolBarItem iconCls="edit" text="修改" handler="editWorker"></next:ToolBarItem>
						<next:ToolBarItem iconCls="delete" text="删除"
							handler="deleteWorker"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn></next:RowNumberColumn>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column field="workerName" header="姓名" sortable="false" />
						<next:Column field="idCard" header="身份证号" sortable="false" />
						<next:Column field="sex" header="性别" dataset="sexDataset" sortable="false" />
						<next:Column field="birthday" header="出生日期" sortable="false" />
						<next:Column field="nation" header="民族" sortable="false" />
						<next:Column field="politicsStatus" header="政治面貌" sortable="false" />
						<next:Column field="educationLevel" header="文化程度"
							dataset="samEducationLevelDataSet" sortable="false" />
						<next:Column field="postProperty" header="岗位性质"
							dataset="samPostPropertyDataSet" sortable="false" />
						<next:Column field="workType" header="工种"
							dataset="samWorkTypeDataSet" sortable="false" />
						<next:Column field="positon" header="职务"
							dataset="samPositonDataSet" sortable="false" />
						<next:Column field="isEnrolled" header="乡镇府在编人员"
							dataset="comm_yesorno" sortable="false" />
						<next:Column field="resumeTrain" header="培训简历" sortable="false" />
						<next:Column field="isLegelPeople" header="是否法人代表"
							dataset="comm_yesorno" sortable="false" />
						<next:Column field="salary" header="工资" sortable="false" />
						<next:Column field="officePhone" header="办公电话" sortable="false" />
						<next:Column field="telphone" header="手机" sortable="false" />
						<next:Column field="dutyTime" header="到岗时间" sortable="false" />
						<next:Column field="isOnduty" header="是否在岗" dataset="comm_yesorno"
							sortable="false" />
						<next:Column field="leaveTime" header="离岗时间" sortable="false" />
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="samWorkerInfoDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<next:Window id="addRoomWin" title="增加房间信息" expandOnShow="false"
	closeAction="hide" resizable="false" width="800" height="450"
	closable="false">

	<next:Panel>
		<next:Html>
			<form id="form1" method="post" dataset="samRoomInfoDataSet"
				onsubmit="return false" class="L5form">
			<fieldset><legend>房间信息</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width: 15%">房间编号或名称：</td>
					<td class="FieldInput" style="width: 18%"><input type="text"
						name="房间编号或名称" id="roomName" field="roomName" maxlength="50"
						style="width: 80%" /><font color="red">*</font> <input
						type="hidden" name="房间ID" id="roomId" field="roomId"
						maxlength="50" style="width: 80%" /> <input type="hidden"
						name="敬老院ID" id="gerocomiumId" field="gerocomiumId" maxlength="50"
						style="width: 80%" /></td>

					<td class="FieldLabel" style="width: 15%">使用面积：</td>
					<td class="FieldInput" style="width: 18%"><input type="text"
						name="使用面积" id="inuseArea" field="inuseArea" maxlength="50"
						style="width: 80%" /><font color="red">*</font></td>

					<td class="FieldLabel" style="width: 15%">是否带卫生间：</td>
					<td class="FieldInput" style="width: 18%"><select
						id="isToilet" name="是否带卫生间" title="是否带卫生间" field="isToilet"
						style="width: 80%">
						<option dataset=comm_yesorno></option>
					</select><font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%">床位数：</td>
					<td class="FieldInput" style="width: 18%"><input type="text"
						name="床位数" id="bedNum" field="bedNum" maxlength="50"
						style="width: 80%" /><font color="red">*</font></td>

					<td class="FieldLabel" style="width: 15%">当前状态：</td>
					<td class="FieldInput" style="width: 18%"><select id="status"
						name="当前状态" title="当前状态" field="status" style="width: 80%">
						<option dataset=samStatusDataSet></option>
					</select><font color="red">*</font></td>
					<td class="FieldLabel"></td>
					<td class="FieldInput"></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%">备注：</td>
					<td class="FieldInput" style="width: 18%" colspan="5"><textarea
						name="备注" title="备注" id="remarks" field="remarks"
						style="width: 97%" /></textarea></td>
				</tr>
			</table>
			</fieldset>
			</form>
		</next:Html>
	</next:Panel>
	<next:EditGridPanel id="bedGrid" dataset="samBedInfoDataSet"
		width="98%" stripeRows="true" height="230">
		<next:TopBar>
			<next:ToolBarItem text="房间床位信息"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="add" text="增加" handler="addBed"></next:ToolBarItem>
			<next:ToolBarItem iconCls="edit" text="修改" handler="editBed"></next:ToolBarItem>
			<next:ToolBarItem iconCls="delete" text="删除" handler="deleteBed"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn></next:RowNumberColumn>
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column field="bedName" header="床位编号/名称" sortable="false">
			<next:TextField></next:TextField>
			</next:Column>
			<next:Column field="remarks" header="备注" sortable="false" >
			<next:TextField></next:TextField>
			</next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="samBedInfoDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
	<next:Buttons>
		<next:ToolButton text="继续添加" handler="addRoomSubmit"></next:ToolButton>
		<next:ToolButton text="确定" handler="hideRoom"></next:ToolButton>
		<next:ToolButton text="关闭" handler="closeRoom"></next:ToolButton>
	</next:Buttons>
</next:Window>
<next:Window id="addWorkerWin" title="增加员工信息" expandOnShow="false"
	closeAction="hide" resizable="false" width="800" height="350"
	closable="false">
	<next:Html>
		<form id="form2" method="post" dataset="samWorkerInfoDataSet"
			onsubmit="return false" class="L5form">
		<fieldset>
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 15%">姓名：</td>
				<td class="FieldInput" style="width: 18%"><input type="text"
					name="姓名" id="workerName" field="workerName" maxlength="50"
					style="width: 80%" /><font color="red">*</font> <input
					type="hidden" name="工作人员ID" id="workerId" field="workerId"
					maxlength="50" style="width: 80%" /> <input type="hidden"
					name="敬老院ID" id="gerocomiumId" field="gerocomiumId" maxlength="50"
					style="width: 180px" /></td>

				<td class="FieldLabel" style="width: 15%">身份证号：</td>
				<td class="FieldInput" style="width: 18%"><input type="text"
					name="身份证号" id="idCard" field="idCard" maxlength="50"
					style="width: 80%" onchange="checkIdCradNo()"/><font color="red">*</font></td>

				<td class="FieldLabel" style="width: 15%">性别：</td>
				<td class="FieldInput" style="width: 18%"><select id="sex"
					name="性别" title="性别" field="sex" style="width: 80%">
					<option dataset="sexDataset"></option>
					</select></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">出生日期：</td>
				<td class="FieldInput" style="width: 18%"><input type="text"
					name="出生日期" id="birthday" field="birthday" format="Y-m-d"
					onclick="LoushangDate(this)" readonly="readonly" style="width: 80%" /></td>

				<td class="FieldLabel" style="width: 15%">民族：</td>
				<td class="FieldInput" style="width: 18%"><input type="text"
					name="民族" id="nation" field="nation" maxlength="50"
					style="width: 80%" /></td>

				<td class="FieldLabel" style="width: 15%">政治面貌：</td>
				<td class="FieldInput" style="width: 18%"><input type="text"
					name="政治面貌" id="politicsStatus" field="politicsStatus"
					maxlength="50" style="width: 80%" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">文化程度：</td>
				<td class="FieldInput" style="width: 18%"><select
					id="educationLevel" name="文化程度" title="文化程度" field="educationLevel"
					style="width: 80%">
					<option dataset=samEducationLevelDataSet></option>
				</select></td>
				<td class="FieldLabel" style="width: 15%">岗位性质：</td>
				<td class="FieldInput" style="width: 18%"><select
					id="postProperty" name="岗位性质" title="岗位性质" field="postProperty"
					style="width: 80%">
					<option dataset=samPostPropertyDataSet></option>
				</select></td>
				<td class="FieldLabel" style="width: 15%">工种：</td>
				<td class="FieldInput" style="width: 18%"><select id="workType"
					name="工种" title="工种" field="workType" style="width: 80%">
					<option dataset=samWorkTypeDataSet></option>
				</select></td>
			</tr>
			<tr>

				<td class="FieldLabel" style="width: 15%">职务：</td>
				<td class="FieldInput" style="width: 18%"><select id="positon"
					name="职务" title="职务" field="positon" style="width: 80%">
					<option dataset=samPositonDataSet></option>
				</select></td>
				<td class="FieldLabel" style="width: 15%">乡镇府在编人员：</td>
				<td class="FieldInput" style="width: 18%"><select
					id="isEnrolled" name="乡镇府在编人员" title="乡镇府在编人员" field="isEnrolled"
					style="width: 80%">
					<option dataset=comm_yesorno></option>
				</select></td>


				<td class="FieldLabel" style="width: 15%">是否法人代表：</td>
				<td class="FieldInput" style="width: 18%"><select
					id="isLegelPeople" name="是否法人代表" title="是否法人代表"
					field="isLegelPeople" style="width: 80%">
					<option dataset=comm_yesorno></option>
				</select></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">工资：</td>
				<td class="FieldInput" style="width: 18%"><input type="text"
					name="工资" id="salary" field="salary" maxlength="50"
					style="width: 80%" /></td>

				<td class="FieldLabel" style="width: 15%">办公电话：</td>
				<td class="FieldInput" style="width: 18%"><input type="text"
					name="办公电话" id="officePhone" field="officePhone" maxlength="50"
					style="width: 80%" /></td>

				<td class="FieldLabel" style="width: 15%">手机：</td>
				<td class="FieldInput" style="width: 18%"><input type="text"
					name="手机" id="telphone" field="telphone" maxlength="50"
					style="width: 80%" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">到岗时间：</td>
				<td class="FieldInput" style="width: 18%"><input type="text"
					name="到岗时间" id="dutyTime" field="dutyTime" format="Y-m-d"
					onclick="LoushangDate(this)" readonly="readonly" style="width: 80%" /></td>

				<td class="FieldLabel" style="width: 15%">是否在岗：</td>
				<td class="FieldInput" style="width: 18%"><select id="isOnduty"
					name="是否在岗" title="是否在岗" field="isOnduty" style="width: 80%">
					<option dataset=comm_yesorno></option>
				</select></td>

				<td class="FieldLabel" style="width: 15%">离岗时间：</td>
				<td class="FieldInput" style="width: 18%"><input type="text"
					name="离岗时间" id="leaveTime" field="leaveTime" format="Y-m-d"
					onclick="LoushangDate(this)" readonly="readonly" style="width: 80%" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">培训简历：</td>
				<td class="FieldInput" style="width: 18%" colspan="5"><textarea
					name="培训简历" title="培训简历" id="resumeTrain" field="resumeTrain"
					style="width: 97%" /></textarea></td>
			</tr>
		</table>
		</fieldset>
		</form>
	</next:Html>
	<next:Buttons>
		<next:ToolButton text="继续添加" handler="addWorkerSubmit"></next:ToolButton>
		<next:ToolButton text="确定" handler="hideWorker"></next:ToolButton>
		<next:ToolButton text="关闭" handler="closeWorker"></next:ToolButton>
	</next:Buttons>
</next:Window>
</body>
</html>