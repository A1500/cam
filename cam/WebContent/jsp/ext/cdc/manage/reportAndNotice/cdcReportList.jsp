<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<html>
	<head>
		<title>申报</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="cdcReportList.js"></script>
		<script language="javascript">
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

	<model:dataset id="cdcNoticeDataset" cmd="com.inspur.cams.cdc.base.cmd.CdcNoticeInfoQueryCmd" method="queryReport"  pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcNoticeInfo"/>
	</model:dataset>
	<!-- 通知通告类型 -->
	<model:dataset id="noticeType" enumName="CDC.NOTICE_TYPE" autoLoad="true"
		global="true"></model:dataset>
	<!-- 发布状态 -->
	<model:dataset id="reportFlag" enumName="CDC.REPORT_FLAG" autoLoad="true"
		global="true"></model:dataset>
</model:datasets>
<next:Panel  name="form" width="100%" border="0" autoScroll="true" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 98%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >
								<td class="FieldLabel">主题：</td>
								<td class="FieldInput"><input type="text"  id="name" class="TextEditor" title="主题"  /></td>	
								
								<td class="FieldLabel">发布单位：</td>
								<td class="FieldInput">
									<input type="text"  id="organArea" class="TextEditor" title="发布单位"  />
								</td>
							</tr>
							<tr>	
								
							
								<td class="FieldLabel" nowrap="nowrap">创建时间：</td>
								<td class="FieldInput">
									<input type="text"  id="createTime" class="TextEditor" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly">
								</td>
								
								<td class="FieldInput" colspan="2">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<button onclick="query()">查 询</button>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<button onclick="reset()">重 置</button></td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="baseinfopeopleGrid" width="100%" stripeRows="true" height="98%" autoScroll="true"  dataset="cdcNoticeDataset" title="申报材料信息" notSelectFirstRow="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem text="查看" iconCls="detail" handler="detail"/>
				</next:TopBar>
			
				<next:Columns>
				    <next:RowNumberColumn header="序号" width="40"/>
				    <next:RadioBoxColumn></next:RadioBoxColumn>
				    		
					<next:Column id="name" header="主题" field="NAME" width="200">
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="flag" header="发布状态" field="FLAG" hidden="true" dataset="reportFlag" width="100">
						<next:TextField allowBlank="false" />
					</next:Column>
				
					<next:Column id="organName" header="发布单位名称" field="ORGAN_NAME"  width="100"  >
						<next:TextField allowBlank="false" />
					</next:Column>
			
					<next:Column id="createTime" header="创建时间" field="CREATE_TIME" width="100"  >
						<next:TextField allowBlank="false" />
					</next:Column>
				</next:Columns>
				
				<next:BottomBar>
					<next:PagingToolBar  dataset="cdcNoticeDataset"/>
				</next:BottomBar>
				
			</next:GridPanel>
</body>
</html>
