<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<html>
<head>
<title></title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src="samGerocomiumInfoDetail_list.js"></script>

<script type="text/javascript">
	<%
	String gerocomiumId=request.getParameter("gerocomiumId");
	%>
	var gerocomiumId='<%=gerocomiumId%>';
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
		<!-- 工资 -->
	<model:dataset id="samSalaryType" enumName="SAM_SALARY_TYPE"
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
	<!-- 民族 -->
	<model:dataset id="nation" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 政治面貌-->
	<model:dataset id="DmZzmmDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel autoHeight="true" bodyStyle="width:100%">
	<next:TabPanel>
		<next:Tabs>
		<next:Panel title="敬老院基本信息" width="99%" height="100%">
			<next:TopBar>
				<next:ToolBarItem symbol="->"/>
				<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
			</next:TopBar>
			<next:Html>
			<form id="form1" method="post" dataset="samGerocomiumInfoDataSet" onsubmit="return false" class="L5form">
			<fieldset>
				<legend>敬老院基础信息</legend>
				<table width="99%">
					<tr>
						<td class="FieldLabel" style="width:15%">年份：</td>
						<td class="FieldInput" style="width:18%"><label field="year"/></td>
					
						<td class="FieldLabel" style="width:15%">名称：</td>
						<td class="FieldInput" style="width:18%"><label field="gerocomiumName"/></td>
					
						<td class="FieldLabel" style="width:15%">建院时间：</td>
						<td class="FieldInput" style="width:18%"><label field="establishDate"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:15%">主管单位名称：</td>
						<td class="FieldInput" style="width:18%"><label field="manaLevel"/></td>
					
						<td class="FieldLabel" style="width:15%">所属行政区划：</td>
						<td class="FieldInput" style="width:18%"><label field="areaLevel"/></td>
					
					
						<td class="FieldLabel" style="width:15%">法人代表：</td>
						<td class="FieldInput" style="width:18%"><label field="legelPeople"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:15%">总房间数：</td>
						<td class="FieldInput" style="width:18%"><label field="totalRoomNum" /></td>
						
						<td class="FieldLabel" style="width:15%">总床位数：</td>
						<td class="FieldInput" style="width:18%"><label field="totalBedNum" /></td>
						
						<td class="FieldLabel" style="width:15%">等级：</td>
						<td class="FieldInput" style="width:18%"><label field="gerocomiumLevel" dataset="gerocomiumLevelDataset" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:15%">占地面积：<br>(单位：亩)</td>
						<td class="FieldInput" style="width:18%"><label field="totalArea"/></td>
					
						<td class="FieldLabel" style="width:15%">建筑面积：<br>(单位：平米)</td>
						<td class="FieldInput" style="width:18%"><label field="buildArea"/></td>
					
						<td class="FieldLabel" style="width:15%">室外娱乐场所面积：<br>(单位：平米)</td>
						<td class="FieldInput" style="width:18%"><label field="outdoorArea"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:15%">室内娱乐场所面积：<br>(单位：平米)</td>
						<td class="FieldInput" style="width:18%"><label field="indoorArea"/></td>
					
						<td class="FieldLabel" style="width:15%">固定资产：<br>(单位：万元)</td>
						<td class="FieldInput" style="width:18%"><label field="fixedAssets"/></td>
					
						<td class="FieldLabel" style="width:15%">五保对象供养标准：<br>(单位：元/年)</td>
						<td class="FieldInput" style="width:18%"><label field="supportStandard"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:15%">管理工作经费：<br>(单位：万元/年)</td>
						<td class="FieldInput" style="width:18%"><label field="managementFunds"/></td>
					
						<td class="FieldLabel" style="width:15%">年副业收入：<br>(单位：万元/年)</td>
						<td class="FieldInput" style="width:18%"><label field="yearSidelineIncome"/></td>
						
						<td class="FieldLabel" style="width:15%">年种植蔬菜面积：<br>(单位：亩)</td>
						<td class="FieldInput" style="width:18%"><label field="vegetablesArea"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:15%">年蔬菜产量：<br>(单位：斤)</td>
						<td class="FieldInput" style="width:18%"><label field="vegetablesYield"/></td>
					
						<td class="FieldLabel" style="width:15%">联系电话：</td>
						<td class="FieldInput" style="width:18%"><label field="contactPhone"/></td>
					
						<td class="FieldLabel" style="width:15%">所在地址：</td>
						<td class="FieldInput" style="width:18%"><label field="location"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:15%">房屋性质：</td>
						<td class="FieldInput" style="width:18%"><label field="houseProperty" dataset="housePropertyDataset"/></td>
					
						<td class="FieldLabel" style="width:15%">取暖方式：</td>
						<td class="FieldInput" style="width:18%"><label field="heatingWay" dataset="heatingWayDataset"/></td>
					
						<td class="FieldLabel" style="width:15%">管理制度是否健全：</td>
						<td class="FieldInput" style="width:18%"><label field="isManagePerfect" dataset="comm_yesorno"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:15%">岗位责任制是否健全：</td>
						<td class="FieldInput" style="width:18%"><label field="isPostPerfect" dataset="comm_yesorno"/></td>
					
						<td class="FieldLabel" style="width:15%">是否建立院管委会：</td>
						<td class="FieldInput" style="width:18%"><label field="isEstablish" dataset="comm_yesorno"/></td>
					
						<td class="FieldLabel" style="width:15%">开展活动情况：</td>
						<td class="FieldInput" style="width:18%"><label field="activityAbout"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:15%">院务是否公开：</td>
						<td class="FieldInput" style="width:18%"><label field="isManagePublic" dataset="comm_yesorno"/></td>
					
						<td class="FieldLabel" style="width:15%">财务是否公开：</td>
						<td class="FieldInput" style="width:18%"><label field="isFinancialPublic" dataset="comm_yesorno"/></td>
					
						<td class="FieldLabel" style="width:15%">娱乐健身器材情况：</td>
						<td class="FieldInput" style="width:18%"><label field="equipmentAbout"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:15%">所服务乡镇：</td>
						<td class="FieldInput" style="width:18%" colspan="5"><label field="serveTowns"/></td>
					
					</tr>
					<tr>
						<td class="FieldLabel" style="width:15%">备注：</td>
						<td class="FieldInput" style="width:18%" colspan="5"><label field="remarks"/></td>
					</tr>
				</table>
			</fieldset>
			</form>
			</next:Html>
		</next:Panel>
		<%-- 
		<next:Panel title="房间基本信息" width="100%" height="100%">
				<next:Panel width="100%" border="0">
					<next:Html>
					<fieldset style="overflow:visible;" class="GroupBox">
					<legend class="GroupBoxTitle">查询条件</legend>
						<form class="L5form">
							<table border="1" width="99%">
								<tr>
									<td class="FieldLabel" style="width:10%">房间名称</td>
									<td class="FieldInput" style="width:20%"><input type="text" id="roomName" style="width:80%"/>
									<td class="FieldLabel" style="width:10%">使用面积(单位：平米)</td>
									<td class="FieldInput" style="width:20%"><input type="text" id="inuseArea" style="width:80%"/>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:10%">床位数(单位：个)</td>
									<td class="FieldInput" style="width:20%"><input type="text" id="bedNum" style="width:80%"/>
									<td class="FieldLabel" style="width:10%">是否带卫生间</td>
									<td class="FieldInput" style="width:18%">
									<select id="isToilet" name="是否带卫生间" title="是否带卫生间"  field="isToilet" style="width:80%">
									<option dataset=comm_yesorno></option></select>
							</td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:10%">当前状态</td>
									<td class="FieldInput" style="width:18%">
									<select id="status" name="当前状态" title="当前状态"  field="status" style="width:80%">
									<option dataset=samStatusDataSet></option></select>
									</td>
									<td class="FieldLabel" style="width:10%"></td>
									<td class="FieldButton" style="width:20%"><button onclick="queryBed()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
								</tr>
							</table>
						</form>
					</fieldset>
					</next:Html>
				</next:Panel>
				<next:EditGridPanel id="gridRoom" dataset="samRoomInfoDataSet" width="99%" stripeRows="true" height="100%">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="detail" text="明细" handler="detailRoom"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn></next:RowNumberColumn>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column field="roomName" header="房间编号或名称"  sortable="false"/>
						<next:Column field="inuseArea" header="使用面积"  sortable="false"/>
						<next:Column field="isToilet" header="是否带卫生间" dataset="comm_yesorno" sortable="false"/>
						<next:Column field="bedNum" header="床位数"  sortable="false"/>
						<next:Column field="status" header="当前状态" dataset="samStatusDataSet" sortable="false"/>
						<next:Column field="remarks" header="备注"  sortable="false"/>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="samRoomInfoDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
		</next:Panel>
		--%>
		<next:Panel title="工作人员基本信息" width="100%" height="100%">
			<next:Panel width="100%" border="0">
				<next:Html>
				<fieldset style="overflow:visible;" class="GroupBox">
				<legend class="GroupBoxTitle">查询条件</legend>
					<form class="L5form">
						<table border="1" width="99%">
							<tr>
								<td class="FieldLabel" style="width:10%">姓名</td>
								<td class="FieldInput" style="width:20%"><input type="text" id="workerName" style="width:80%"/>
								<td class="FieldLabel" style="width:10%">身份证号</td>
								<td class="FieldInput" style="width:20%"><input type="text" id="idCard" style="width:80%" />
							</tr>
							<tr>
								<td class="FieldLabel" style="width:10%">岗位性质</td>
								<td class="FieldInput" style="width:18%">
								<select id="postProperty" name="岗位性质" title="岗位性质"  field="postProperty" style="width:80%">
								<option dataset=samPostPropertyDataSet></option></select>
								</td>
								<td class="FieldLabel" style="width:10%">工种</td>
								<td class="FieldInput" style="width:18%">
								<select id="workType" name="工种" title="工种"  field="workType" style="width:80%">
								<option dataset=samWorkTypeDataSet></option></select>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:10%">是否在岗</td>
								<td class="FieldInput" style="width:18%">
								<select id="isOnduty" name="是否在岗" title="是否在岗"  field="isOnduty" style="width:80%">
								<option dataset=comm_yesorno></option></select>
								</td>
								<td class="FieldLabel" style="width:10%"></td>
								<td class="FieldButton" style="width:20%"><button onclick="queryWorker()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
							</tr>
						</table>
					</form>
				</fieldset>
				</next:Html>
			</next:Panel>
			<next:EditGridPanel id="gridWorker" dataset="samWorkerInfoDataSet" width="100%" stripeRows="true" height="100%">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn></next:RowNumberColumn>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column field="workerName" header="姓名"  sortable="false"/>
					<next:Column field="idCard" header="身份证号" width="12%" sortable="false"/>
					<next:Column field="sex" header="性别"  sortable="false" dataset="sexDataset"/>
					<next:Column field="birthday" header="出生日期"  sortable="false"/>
					<next:Column field="nation" header="民族"  sortable="false" dataset="nation"/>
					<next:Column field="politicsStatus" header="政治面貌"  sortable="false" dataset="DmZzmmDataSet"/>
					<next:Column field="educationLevel" header="文化程度" dataset="samEducationLevelDataSet" sortable="false"/>
					<next:Column field="postProperty" header="岗位性质" dataset="samPostPropertyDataSet" sortable="false"/>
					<next:Column field="workType" header="工种" dataset="samWorkTypeDataSet" sortable="false"/>
					<next:Column field="positon" header="职务" dataset="samPositonDataSet" sortable="false"/>
					<next:Column field="isEnrolled" header="乡镇府在编人员" dataset="comm_yesorno" sortable="false"/>
					<next:Column field="resumeTrain" header="培训简历"  sortable="false"/>
					<next:Column field="isLegelPeople" header="是否法人代表" dataset="comm_yesorno" sortable="false"/>
					<next:Column field="salary" header="工资"  sortable="false" dataset="samSalaryType"/>
					<next:Column field="officePhone" header="办公电话"  sortable="false"/>
					<next:Column field="telphone" header="手机"  sortable="false"/>
					<next:Column field="dutyTime" header="到岗时间"  sortable="false"/>
					<next:Column field="isOnduty" header="是否在岗" dataset="comm_yesorno" sortable="false"/>
					<next:Column field="leaveTime" header="离岗时间"  sortable="false"/>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="samWorkerInfoDataSet"/>
				</next:BottomBar>
			</next:EditGridPanel>
		</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<next:Window id="BedInfoWin" title="房间床位信息" expandOnShow="false"
	closeAction="hide" resizable="false" width="600" height="400"
	closable="false">
	<next:GridPanel id="bedGrid" dataset="samBedInfoDataSet"
		width="98%" stripeRows="true" height="370">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="delete" text="关闭" handler="closeWin"></next:ToolBarItem>
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
	</next:GridPanel>
</next:Window>
</body>
</html>