<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<html>
	<head>
		<title>通知</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="cdcNoticeNList.js"></script>
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

	<model:dataset id="cdcNoticeDataset" cmd="com.inspur.cams.cdc.base.cmd.CdcNoticeInfoQueryCmd" method="queryMyNotice"  pageSize="20">
	</model:dataset>
	<!-- 通知通告类型 -->
	<model:dataset id="noticeType" enumName="CDC.NOTICE_TYPE" autoLoad="true"
		global="true"></model:dataset>
	<!-- 是否下发 -->
	<model:dataset id="reportFlag" enumName="COMM.YESORNO" autoLoad="true"
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
								
								<td class="FieldLabel" nowrap="nowrap">是否下发：</td>
								<td class="FieldInput">
									<select id="noticeFlag"> 
											<option dataset="reportFlag"></option>
									</select>
								</td>
							</tr>
							<tr>	
								<td class="FieldLabel" nowrap="nowrap">创建时间：</td>
								<td class="FieldInput">
									<input type="text"  id="createTime" class="TextEditor" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/>
								</td>
								
								<td class="FieldInput" colspan="2">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<button onclick="queryN()">查 询</button>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<button onclick="reset()">重 置</button></td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="editGridPanel" name="baseinfopeopleGrid" width="100%" stripeRows="true" height="98%" autoScroll="true"  dataset="cdcNoticeDataset" title="通知通告信息" notSelectFirstRow="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem text="下发通知" iconCls="upload" handler="report" />
					<next:ToolBarItem text="增加通知" iconCls="add" handler="insertNotice" />
					<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
					<next:ToolBarItem text="通知查看情况" iconCls="view" handler="checkView"/>
					<next:ToolBarItem text="查看" iconCls="detail" handler="detail"/>
					<next:ToolBarItem text="删除" iconCls="delete" handler="del"/>
				</next:TopBar>
			
				<next:Columns>
				    <next:RowNumberColumn header="序号" width="40"/>
				    <next:RadioBoxColumn></next:RadioBoxColumn>
				    		
					<next:Column id="noticeType" header="通知通告类型" field="NOTICE_TYPE" hidden="true" dataset="noticeType" width="100" >
						<next:TextField allowBlank="false" />
					</next:Column>
			
					<next:Column id="name" header="主题" field="NAME" width="200">
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="flag" header="是否下发" field="FLAG" dataset="reportFlag" width="100">
						<next:TextField allowBlank="false" />
					</next:Column>
				
					<next:Column id="organName" header="发布单位名称" field="ORGAN_NAME" width="100"  >
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
