<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>基金会换届（成立）选举报表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="somFundElectionInsert.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
</head>
<body>
<model:datasets>
    <model:dataset id="fundElectionDS" cmd="com.inspur.cams.sorg.manage.cmd.SomFundElectionQueryCmd" pageSize="10">
      <model:record fromBean="com.inspur.cams.sorg.base.data.SomMeeting">
      <model:field name="meetingDate" type="string" rule="require"/>
      <model:field name="meetingContent" type="string" rule="length{500}"/>
      <model:field name="borgOpinion" type="string" rule="length{200}"/>
      <model:field name="meetingName" type="string" rule="length{100}"/>
      <model:field name="councilNum" type="string" rule="number"/>
      <model:field name="supervisorNum" type="string" rule="number"/>
      <model:field name="chiefNum" type="string" rule="number"/>
      </model:record>
	</model:dataset>
	<model:dataset id="organDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryOrgan">
      <model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
</model:datasets>
	<next:Panel  width="100%" height="100%" autoScroll="true">
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="save" text="保存" handler="saveElection"></next:ToolBarItem>
				<next:ToolBarItem iconCls="return" text="返回" handler="backMain"></next:ToolBarItem>
			</next:TopBar>
			<next:Html>
				<form id="ElectionForm" method="post" dataset="fundElectionDS" onsubmit="return false" class="L5form">
				<input type="hidden" id="sorgId" field="sorgId" value="基金会ID">
				 <fieldset>
				   <legend>基金会换届（成立）选举报表</legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel"><label>登记证号：</label></td>
						<td class="FieldInput" colspan="3"><input type="text"  id="sorgCode" onchange="querySorgFundMess();"  style="width:95%" /><font color="red">*</font></td>
						<td class="FieldLabel"><label>基金会名称：</label></td>
						<td class="FieldInput" ><label  id="cnName"  style="width:100%" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:12%"><label>会议名称：</label></td>
						<td class="FieldInput" style="width:28%"><input type="text" name="会议名称" id="meetingName"  style="width:95%" field="meetingName" maxlength="50" ></td>
						<td class="FieldLabel" style="width:12%"><label>会议日期：</label></td>
						<td class="FieldInput" style="width:18%"><input type="text" id="meetingDate"  style="width:95%" format="Y-m-d" onclick="WdatePicker();" field="meetingDate"/><font color="red">*</font></td>
						<td class="FieldLabel" style="width:12%"><label>联系人：</label></td>
						<td class="FieldInput" style="width:18%"><input type="text" name="联系人" id="linkPeople" maxlength="36" style="width:95%" field="linkPeople"></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>联系电话：</label></td>
						<td class="FieldInput"><input type="text" name="联系电话" id="linkPhone" maxlength="30" style="width:95%" field="linkPhone"></td>
						<td class="FieldLabel"><label>上次换届时间：</label></td>
						<td class="FieldInput"><label id="electionDate" style="width:95%"  ></td>
						<td class="FieldLabel"><label>应当换届时间：</label></td>
						<td class="FieldInput"><label id="electionPeriodDate"  style="width:95%" ></td>
					</tr>
					<tr id="electionPeriodTr" style="display:none;">
						<td class="FieldLabel">换届年限:</td>
						<td class="FieldInput" ><input type="text" name="换届年限:" id="electionPeriod"  style="width:90%"/><span>年</span><font color="red">*</font></td>
						<td class="FieldLabel"></td>
						<td class="FieldInput"></td>
						<td class="FieldLabel"></td>
						<td class="FieldInput"></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>理事会候选人数：</label></td>
						<td class="FieldInput"><input type="text" name="理事会候选人数:" id="councilNum" maxlength="6" style="width:95%" field="councilNum"></td>
						<td class="FieldLabel"><label>监事人数：</label></td>
						<td class="FieldInput"><input type="text" name="监事人数:" id="supervisorNum" maxlength="6" style="width:95%" field="supervisorNum"></td>
						<td class="FieldLabel"><label>负责人候选人数：</label></td>
						<td class="FieldInput"><input type="text" name="负责人候选人数:" id="chiefNum" maxlength="6" style="width:95%" field="chiefNum"></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>会议地点：</label></td>
						<td class="FieldInput" colspan="5"><input type="text" name="会议地点" id="meetingPlace" maxlength="100"  style="width:99%" field="meetingPlace"></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>参会主要人员：</label></td>
						<td class="FieldInput" colspan="5"><textarea name="参会主要人员" id="mainPeople"  field="mainPeople" cols="65" rows="8" style="width:99%"></textarea></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>业务主管单位意见：</label></td>
						<td class="FieldInput" colspan="5"><textarea name="业务主管单位意见" id="borgOpinion" field="borgOpinion" cols="65" rows="4" style="width:99%"></textarea></td>

					</tr>
					<tr>
						<td class="FieldInput" colspan="6"><font color="red">
						说明：<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;1)参会主要人员的内容，必须在500字符之内。<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;2)业务主管单位意见，必须在200字符之内。
					</font>
					</td>
				    </tr>
				</table>
				</form>
		</next:Html>
		</next:Panel>
</body>
</html>