<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%
	String organArea = BspUtil.getCorpOrgan().getOrganCode();
	String nowYear= DateUtil.getYear();
%>
<html>
<head>
<title>主页</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript">
	var organCode='<%=BspUtil.getOrganCode()%>';
	var organType='<%=BspUtil.getOrganType()%>';
	var nowYear='<%=nowYear%>';
</script>
<script type="text/javascript" src="funds/fundsComm.js"></script>
<script type="text/javascript" src="comm/disComm.js"></script>
<script type="text/javascript" src="disMain.js"></script>
<script type="text/javascript">
	var organArea='<%=organArea%>';
</script>
</head>
<body>
<model:datasets>
	<!--资金总表-->
	<model:dataset id="disFundsTempDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsTempQueryCmd"
		method="queryFunds" global="true">
	</model:dataset>
	<!--需填报-->
	<model:dataset id="disReliefBatchDetailDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchDetailQueryCmd"
		pageAble="false" global="true">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DisReliefBatchDetail">
		</model:record>
	</model:dataset>
	<!--已上报-->
	<model:dataset id="disReliefBatchDetailReqDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchDetailQueryCmd"
		pageAble="false" global="true">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DisReliefBatchDetail">
		</model:record>
	</model:dataset>
	<!--已提交-->
	<model:dataset id="disReliefBatchDetailCommitDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchDetailQueryCmd"
		pageAble="false" global="true">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DisReliefBatchDetail">
		</model:record>
	</model:dataset>
	<!--资金发放-->
	<model:dataset id="disReliefBatchDetailFundsDoleDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchDetailQueryCmd"
		method="queryCueDoleSums" pageAble="false" global="true">
	</model:dataset>
	<!--物资发放-->
	<model:dataset id="disReliefBatchDetailDetailDoleDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchDetailQueryCmd"
		method="queryCueDoleSums" pageAble="false" global="true">
	</model:dataset>
	<model:dataset id="pubPostDataSet"
		cmd="com.inspur.cams.comm.bbs.cmd.PubPostQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.comm.bbs.data.PubPost" />
	</model:dataset>
	<model:dataset id="notifyDataset" cmd="com.inspur.cams.comm.inform.InformQueryCommand" global="true" method="queryReceiveBox">
		<model:record>
			<model:field name="ID" type="string"/>
			<model:field name="TITLE" type="string"/>
			<model:field name="SENDMAN" type="string"/>
			<model:field name="SENDMANID" type="string"/>
			<model:field name="SENDTIME" type="date" dateFormat="Y-m-d H:i:s"/>
			<model:field name="RECEIVEMAN" type="string"/>
			<model:field name="INFORMTYPE" type="string"/>
			<model:field name="FLAG" type="string"/>
			<model:field name="BFLAG" type="string"/>
		</model:record>
	</model:dataset>
	<model:dataset id="type" enumName="Inform.Type" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="organDS" cmd="com.inspur.cams.comm.informUtil.InformPubOrganQueryCommand" global="true" autoLoad="true" pageSize="-1">
		<model:record fromBean="com.inspur.cams.comm.informUtil.InformPubOrgan">
		    <model:field name="value" mapping="organCode"/>
			<model:field name="text" mapping="shortName"/>
		</model:record>
	</model:dataset>
	<model:dataset id="receiveOrganDS" cmd="com.inspur.cams.comm.informUtil.InformPubOrganQueryCommand" method="queryNameByOrganType" global="true" autoLoad="true" pageSize="-1">
		<model:record fromBean="com.inspur.cams.comm.informUtil.InformPubOrgan">
		    <model:field name="value" mapping="organCode"/>
			<model:field name="text" mapping="shortName"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:ColumnLayout>
		<!--系统动态+操作提示-->
		<next:Panel id="leftPanel" columnWidth="0.4" height="100%"
			title="系统动态">
			<next:Html>
				<form method="post" onsubmit="return false" class="L5form"
					dataset="disFundsTempDs">
				<table border="0" width="100%">
					<tr>
						<td class="FieldLabel" style="width: 80px">总资金:</td>
						<td class="FieldInput"><label field="AMOUNT_BALANCE"
							renderer="amountBalanceRenderer"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="text-align: left;" colspan="2"><b>操作提示:</b></td>
					</tr>
					<tr>
						<td class="FieldInput" colspan="2"><label
							field="SJ_AMOUNT_ALL" renderer="sjAmountAllRenderer"></label></td>
					</tr>
					<tr>
						<td class="FieldInput" colspan="2"><label
							field="BJ_AMOUNT_ALL" renderer="bjAmountAllRenderer"></td>
					</tr>
					<tr>
						<td class="FieldInput" colspan="2"><label
							field="SH_AMOUNT_ALL" renderer="shAmountAllRenderer"></td>
					</tr>
					<tr id="townTr">
						<td class="FieldInput" colspan="2"><label id="townFill"/></td>
					</tr>
					<tr id="countryReqTr">
						<td class="FieldInput" colspan="2"><label id="countryReqFill"/></td>
					</tr>
					<tr id="countryTr">
						<td class="FieldInput" colspan="2"><label id="countryFill"/></td>
					</tr>
					<tr id="doleFundsTr">
						<td class="FieldInput" colspan="2"><label id="doleFundsFill"/></td>
					</tr>
					<tr id="doleDetailTr">
						<td class="FieldInput" colspan="2"><label id="doleDetailFill"/></td>
					</tr>

					<tr>
						<td class="FieldLabel" style="text-align: left;" colspan="2"><b>年度结转提示:</b></td>
					</tr>
					<tr>
						<td class="FieldInput" colspan="2">暂不需要年度结转！</td>
					</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>

		<next:Panel id="rightPanel" columnWidth="0.6" height="100%">
			<!--通知公告-->
			<next:GridPanel id="gridPanel" notSelectFirstRow="true"
				name="informGrid" width="100%" height="50%" dataset="notifyDataset"
				frame="true" autoScroll="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="edit" text="发放通知" handler="click_send" />
					<next:ToolBarItem xtype="tbseparator" />
					<next:ToolBarItem iconCls="add" text="查看" handler="click_view" />
					<next:ToolBarItem xtype="tbseparator" />
					<next:ToolBarItem iconCls="query" text="查询" handler="click_query" />
					<next:ToolBarItem xtype="tbseparator" />
					<next:ToolBarItem iconCls="remove" text="删除" handler="click_delete" />
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn width="30" />
					<next:CheckBoxColumn></next:CheckBoxColumn>
					<next:Column header="状态" field="BFLAG" width="50"
						renderer="cautionRender" align="center">
						<next:TextField />
					</next:Column>
					<next:Column header="标题" field="TITLE" width="360"
						renderer="titleRender">
						<next:TextField />
					</next:Column>
					<next:Column header="类别" field="INFORMTYPE" width="150"
						sortable="true">
						<next:ComboBox dataset="type" />
					</next:Column>
					<next:Column header="接收单位" field="RECEIVEMAN" width="120"
						sortable="true" renderer="receiveRenderer">
					</next:Column>
					<next:Column header="发送单位" field="SENDMAN" width="190"
						sortable="true">
						<next:ComboBox dataset="organDS" />
					</next:Column>
					<next:Column header="发送人" field="SENDMANID" width="100"
						sortable="true">
						<next:TextField />
					</next:Column>
					<next:Column header="时间" field="SENDTIME" width="140"
						sortable="true">
						<next:DateField />
					</next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="notifyDataset" />
				</next:BottomBar>
			</next:GridPanel>

			<!--论坛-->
			<next:Panel id="advPanel" width="100%" height="50%" title="论坛">
				<next:Html>
					<iframe id="disMainTown" name="disMainTown"
						src="../comm/bbs/pubPostMain.jsp" frameborder="no" border="0"
						marginwidth="0" marginheight="0" scrolling="no"
						allowtransparency="yes" width="100%" height="100%"> </iframe>
				</next:Html>
			</next:Panel>
		</next:Panel>
	</next:ColumnLayout>
</next:ViewPort>
<!-- 弹出添加窗口 -->
<next:Window id="organize" name="organizeWin" title="收件箱查询"
	resizable="false" width="300" lazyRender="false" height="150"
	closeAction="hide" autoScroll="false">
	<next:Buttons>
		<next:ToolButton text="查询" handler="query"></next:ToolButton>
		<next:ToolButton text="关闭" handler="undoit"></next:ToolButton>
	</next:Buttons>

	<next:Html>
		<form id="informcfg" method="post" onsubmit="return false">
		<table id="table0"  border="0">
			<tr>
				<td align="center" ><label>标题：</label></td>
				<td >
				    <input type="text" id="titlequery" name="titlequery"
					   title="标题" size="30"/>
				</td>
		    </tr>

		    <tr>
				<td align="center" ><label>发送人：</label></td>
				<td >
				    <input type="text" id="sendmanIdquery"
					   title="发送人" size="30"/>
				</td>
		    </tr>
		</table>
		</form>
	</next:Html>
</next:Window>
</body>
</html>