<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>经营性公墓申建审批流程</title>
<next:ScriptManager />
<script type="text/javascript" src="opinionHistory.js"></script>
<script language="javascript">
	 var organCode = '<%=BspUtil.getOrganCode()%>';
	 var organName = '<%=BspUtil.getOrganName()%>';
     var organType = '<%=BspUtil.getOrganType()%>';
     var cemeApplyId = '<%=request.getParameter("cemeApplyId")%>';
 	 //查询条件打开合并函数
	 function collapse(element){
		var fieldsetParent=L5.get(element).findParent("fieldset");
		if(element.expand==null||element.expand==true){
			fieldsetParent.getElementsByTagName("div")[0].style.display="none";
			element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
			element.expand=false;
		}else{
			fieldsetParent.getElementsByTagName("div")[0].style.display="";
			element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
			element.expand =true;
		}
	}
</script>
</head>
<body>
<model:datasets>
	<!-- 历史信息 -->
	<model:dataset id="hisDs" cmd="com.inspur.cams.fis.base.cmd.FisCemeCheckHistoryQueryCmd" method="queryOrder" global="true" >
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeCheckHistory"/>
	</model:dataset>
		<!-- 历史信息 -->
	<model:dataset id="historyBackup" cmd="com.inspur.cams.fis.base.cmd.FisCemeCheckHistoryQueryCmd" global="true" >
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeCheckHistory"/>
	</model:dataset>
		<!-- 1:同意,2:不同意,3:补齐补正 -->
	<model:dataset id="opinionPlus" enumName="FIS.CEMECRETE.OPINIONPLUS" autoLoad="true" global="true">
	</model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
<next:GridPanel id="cemePanel" name="fisCemeGrid" width="98%" stripeRows="true" height="500" dataset="hisDs" autoScroll="true" title="历史列表">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="detail" text="查看详细审核信息" handler="hisDetail"/>
		</next:TopBar>
		<next:Columns>
		    <next:RowNumberColumn width="30"/>
		    <next:RadioBoxColumn></next:RadioBoxColumn>
		    <next:Column id="firstTime" header="受理时间" field="FIRST_TIME" width="180" />		    
			<next:Column id="cemeApplyId" header="申建业务编码" field="CEME_APPLY_ID" width="180" />
			<next:Column id="firstUnit" header="受理单位编码" field="FIRST_UNIT_ID" width="180" />
			<next:Column id="firstUnit" header="受理单位" field="FIRST_UNIT" width="120" />
			<next:Column id="firstResult" header="审核结果" field="FIRST_RESULT" width="120" dataset="opinionPlus" />
			<next:Column id="firstOpinion" header="受理意见" field="FIRST_OPINION" width="180" />
			<next:TextField allowBlank="false" />
			
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="hisDs"/>
		</next:BottomBar>
	</next:GridPanel>
</next:Panel>
<next:Window id="cemeWin" title="公墓申建审批意见历史记录" width="800" height="500" autoHeight="true" resizable="false" closeAction="hide" modal="true">
	
<next:Panel title="公墓申建审批" width="100%" autoScroll="true">
       <next:Html>
		<form id="form" method="post" dataset="historyBackup" onsubmit="return false" style="padding: 5px;" class="L5form">
		<legend>单位受理意见</legend>
			<table width="100%">
						<tr>
							<td class="FieldLabel" style="width:25%" colspan="2">受理单位名称：</td>
							<td class="FieldInput" style="width:75%"><label type="text" field="firstUnit" style="width: 80%" maxlength="50" style="width:50%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" width="25%" colspan="2">受理结果：</td>
							<td class="FieldInput" style="width:75%"><label field="firstResult" style="width: 80%" dataset="opinionPlus"></td>	
												
						</tr>
						<tr>
							<td class="FieldLabel" rowspan="2" width="100px;">当<br>	前<br>单<br>位</td>
							<td class="FieldLabel" width="10%">受理时间</td>
							<td class="FieldInput"><label type="text" field="firstTime" style="width: 80%" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" width="10%">受理意见</td>
							<td class="FieldInput" colspan="3"><textarea  readonly="readonly"   rows="10"
								id="firstOpinion" field="firstOpinion" maxlength="1500"
								style="width: 80%"> </textarea></td>
						</tr>
				</table>
				
				</form>
		</next:Html>
	</next:Panel>			
</next:Window>

</body>
</html>
