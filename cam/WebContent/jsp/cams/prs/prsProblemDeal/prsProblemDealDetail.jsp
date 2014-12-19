<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>问题处理信息管理</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="prsProblemDealDetail.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript">
			 var organId='<%=BspUtil.getCorpOrganId()%>';
		     var organArea='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
		     var method='<%=request.getParameter("method")%>';
		     var problemId='<%=request.getParameter("problemId")%>';
		     var page='<%=request.getParameter("page")%>';
		    var queryId='<%=request.getParameter("queryId")%>';
		</script>
	</head>
<body>
<model:datasets>
    <model:dataset id="problemDealDS" cmd="com.inspur.cams.prs.prsproblemdeal.cmd.PrsProblemDealQueryCmd">
      <model:record fromBean="com.inspur.cams.prs.prsproblemdeal.dao.PrsProblemDeal">
      	<model:field name="dealFlag" type="string" rule="require"/>
      </model:record>
	</model:dataset>
	<!-- 问题处理意见表从表 -->
	<model:dataset id="problemDealHistoryDS" cmd="com.inspur.cams.prs.prsproblemhistory.cmd.PrsProblemHistoryQueryCmd" >
      <model:record fromBean="com.inspur.cams.prs.prsproblemhistory.dao.PrsProblemHistory">
      </model:record>
	</model:dataset>
	<model:dataset id="problemFromDS" enumName="PROBLEM_FROM" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="supervisionDS" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="dealFlagDS" enumName="DEAL_FLAG" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel id="problem_winPanel"  width="100%" height="100%" collapsible="true" autoScroll="true">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="detail" text="查看转发记录" handler="detail_history"/>
			<next:ToolBarItem iconCls="undo" text="返回" handler="return_problem"/>
		</next:TopBar>
		<next:Html>
			<form class="L5form"id="form_content" method="post"onsubmit="return false" dataset="problemDealDS">
				<table width="100%">
					<tr >
						<td class="FieldLabel" >问题标题：</td>
						<td class="FieldInput">
							<input type="text" id="problemTitle" name="问题标题：" field="problemTitle"  maxlength="50"  style="width:90%" disabled="disabled"/>
							<font color="red">*</font>
						</td>
						<td class="FieldLabel">问题编号：</td>
						<td class="FieldInput">
							<input type="text" id="problemNumbers" name="问题编号：" field="problemNumbers"   style="width:90%" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">反映人单位:</td>
						<td class="FieldInput">
							<input type="text" id="problemCompany" name="反映人单位:"  field="problemCompany"  maxlength="25" style="width:90%" disabled="disabled"/>
						</td>
						<td class="FieldLabel">反映人姓名：</td>
						<td class="FieldInput" >
							<input type="text" id="problemPerson" name="反映人姓名："  field="problemPerson"  maxlength="25" style="width:90%" disabled="disabled"/>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" >反映人数：</td>
						<td class="FieldInput" >
							<input type="text" id="personNumber" name="反映人数:"  field="personNumber"  maxlength="10" style="width:90%" disabled="disabled"/>
							<font color="red">*</font>
						</td>
						<td class="FieldLabel" >反映问题时间：</td>
						<td class="FieldInput" >
							<input type="text" id="problemDate" name="反映问题时间：" field="problemDate" format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly" style="width:90%" disabled="disabled"/>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" >来源方式:</td>
						<td class="FieldInput" >
							<select id="problemFrom" name="来源方式:" field="problemFrom"  style="width:90%" disabled="disabled"><option dataset="problemFromDS" disabled="disabled"></option></select>
							<font color="red">*</font>
						</td>
						<td class="FieldLabel">是否督办件：</td>
						<td class="FieldInput" >
							<select  id="supervision" name="是否督办件：" field="supervision" style="width:90%" disabled="disabled" ><option dataset="supervisionDS"></option></select>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">反映内容：</td>
						<td class="FieldInput" colspan="3">
							<textArea type="text" id="content" name="反映内容：" field="content" cols="15" rows="3" disabled="disabled"  style="width:90%"></textArea>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">诉求内容：</td>
						<td class="FieldInput" colspan="3">
							<textArea type="text" id="demands" name="诉求内容：" field="demands" cols="15" rows="3" disabled="disabled" style="width:90%;"></textArea>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>处理结果:</label></td>
						<td colspan="3" class="FieldInput" readOnly=true>
						<input type="radio" id="dealFlag"  name="dealFlag" field="dealFlag" value="01" disabled="disabled" />待办<br>
						<input type="radio" id="dealFlag"  name="dealFlag" field="dealFlag" value="03" disabled="disabled"  />办理<br>
					    <input type="radio" id="dealFlag" name="dealFlag" field="dealFlag" value="02" disabled="disabled"  />转办单位
					    <label id="area" field="receiveorganName" disabled="disabled"></label>
					    </td>
				  </tr>
					<tr>
						<td class="FieldLabel">处理情况：</td>
						<td class="FieldInput" colspan="3">
							<textArea type="text" id="deal" field="deal" name="处理情况："  cols="15" rows="3" style="width:90%;" disabled="disabled"></textArea>
						</td>
				   </tr>
				  <tr>
						<td class="FieldLabel">受理人：</td>
						<td class="FieldInput">
							<input type="text" id="dealPerson" field="dealPerson" name="处理人：" disabled="disabled" ></input>
						</td>
						<td class="FieldLabel">受理时间：</td>
						<td class="FieldInput" colspan="5">
							<input type="text" id="dealTime" field="dealTime" name="处理时间：" disabled="disabled" ></input>
						</td>
				</tr>
				<tr>
						<td class="FieldLabel">附件</td>
						<td colspan="3">
							<div id="fileName"></div>
	           			</td>
           			</tr>
			</table>
		</form>
	</next:Html>
</next:Panel>
<next:Window id="history_help" title="转发信息"  width="550" height="260" collapsible="true" closeAction="hide">
	<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="delete" text="关闭" handler="close_help"></next:ToolBarItem>
	</next:TopBar>
	<next:GridPanel id="history_grid" name="history_grid" dataset="problemDealHistoryDS" width="100%" height="99.9%" disableSelection="true" stripeRows="true" notSelectFirstRow="true" collapsible="true"  autoScroll="true" >
				<next:Columns>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column id="problemHistoryId" header="主键ID" field="problemHistoryId" hidden="true" width="10" >
					</next:Column>
					<next:Column id="problemId" header="问题处理ID" field="problemId" hidden="true" width="10" >
					</next:Column>
					<next:Column id="receiveorganName" header="接收单位名称" field="receiveorganName" width="12%"  >
					</next:Column>
					<next:Column id="sendOrganName" header="发送单位名称" field="sendOrganName" width="12%" >
					</next:Column>
					<next:Column id="sendPersonName" header="发送人名称" field="sendPersonName" width="12%"  >
					</next:Column>
					<next:Column id="sendOrgan" header="发送单位" field="sendOrgan"  hidden="true" width="9%"  >
					</next:Column>
					<next:Column id="sendTime" header="发送时间" field="sendTime"  width="10%" >
					</next:Column>
					<next:Column id="dealFlag" header="处理状态" field="dealFlag" dataset="dealFlagDS" width="9%" >
					</next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="problemDealHistoryDS"/>
				</next:BottomBar>
		</next:GridPanel>
</next:Window>
</body>
</html>