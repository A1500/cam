<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="java.net.URLDecoder"%>
<html>
	<head>
		<title>年检查询列表</title>
		<next:ScriptManager/>
<%	
	String searchYear=(String)request.getParameter("searchYear");
	if(searchYear == null){
		searchYear = "";
	}
	String searchTaskCode=request.getParameter("CheckStatus");
	if(searchTaskCode == null){
		searchTaskCode = "";
	}
%>	
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
			var searchYear='<%=searchYear%>';
			var searchTaskCode='<%=searchTaskCode%>';
			var year = '<%=Integer.parseInt(DateUtil.getYear())-1+""%>';
			
			function query(){
				var checkYear=document.getElementById('checkYear').value;
				var CheckStatus=document.getElementById('CheckStatus').value;
				var sorgKindS=document.getElementById('sorgKindS').value;
				if(checkYear == ''){
					L5.Msg.alert("提示","请输入所要汇总的年份！");
					return false;
				}
				ds.setParameter("CHECK_YEAR",checkYear);
				ds.setParameter("STATUS",CheckStatus);
				ds.setParameter("SORG_KIND",sorgKindS);
				ds.load();
				year=checkYear;
			}	
			function init(){
				document.getElementById('checkYear').value=searchYear;
				document.getElementById('CheckStatus').value=searchTaskCode;
				if(searchYear=="" && searchTaskCode==""){
					document.getElementById('checkYear').value=year;
					ds.setParameter("TASK_CODE","no");
				}else{
					ds.setParameter("check_Year",searchYear);
					ds.setParameter("Status",searchTaskCode);	
				}
				ds.load();
			}
			function summary(){
				var data = new L5.Map(); 
			    data.put("year",'<%=Integer.parseInt(DateUtil.getYear())-1+""%>');
				var url='jsp/cams/sorg/jxcheck/fund/summary/somFundJXCheckSummary.jsp';
			  	var text = '基金会年检汇总';
				L5.forward(url,text,data);
			}
			function summarySelect(){
				var panel=L5.getCmp("editGridPanel");
				var selecteds=panel.getSelectionModel().getSelections();
				if(selecteds.length < 1){
					L5.Msg.alert("提示","请至少选择一条数据进行汇总！");
					return false;
				}
				var taskCode="";
				for(var i=0;i<selecteds.length;i++){
					taskCode += selecteds[i].get('taskCode') + "," ;
				}
			    var data = new L5.Map(); 
			    data.put("taskCode",taskCode.substring(0, taskCode.lastIndexOf(',')));
			    data.put("year",year);
			     data.put("CheckStatus",document.getElementById('CheckStatus').value);
				var url='jsp/cams/sorg/jxcheck/fund/summary/somFundJXCheckSummary.jsp';
			  	var text = '基金会年检汇总';
				L5.forward(url,text,data);
			}
			var summaryTaskCode = "";
			function summaryGridAll(){
				var panel=L5.getCmp("editGridPanel");
				if(ds.getCount() == 0){
					L5.Msg.alert("提示","列表中没有数据！");
					return;
				}
				var checkYear=document.getElementById('checkYear').value;
				var CheckStatus=document.getElementById('CheckStatus').value;
				var sorgKindS=document.getElementById('sorgKindS').value;
				summaryDs.setParameter("CHECK_YEAR",checkYear);
				summaryDs.setParameter("STATUS",CheckStatus);
				summaryDs.setParameter("SORG_KIND",sorgKindS);
				summaryDs.load();
				summaryDs.on('load',summaryGridAllOnLoad);	
				
			}
			function summaryGridAllOnLoad(record){
					summaryDs.each(function(record, index){
						summaryTaskCode += record.get('taskCode') + "," ;
					});
					 var data = new L5.Map(); 
				    data.put("year",year);
				    data.put("ifGridAll","1");
				    data.put("CheckStatus",document.getElementById('CheckStatus').value);
				    data.put("sorgKind",document.getElementById('sorgKindS').value);
					var url='jsp/cams/sorg/jxcheck/fund/summary/somFundJXCheckSummary.jsp';
				  	var text = '社会团体年检汇总';
					L5.forward(url,text,data);
			}
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck"></model:record>
		<model:params>
			<model:param name="sorg_Type" value='J'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="summaryDs" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" method="queryNoPage" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck"></model:record>
		<model:params>
			<model:param name="sorg_Type" value='J'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织种类 -->
	<model:dataset id="sorgKind" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='dic_fund_kind'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="somCheckStatus" enumName="SOM.CHECK_STATUS" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 95%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >
								<td class="FieldLabel">年份:</td>
								<td class="FieldInput"><input type="text"  id="checkYear" title="年份"  /></td>	
								<td class="FieldLabel">年检状态:</td>
								<td class="FieldInput"><select id="CheckStatus"><option  dataset="somCheckStatus"></option></select></td>	
								<td class="FieldLabel">基金会类型:</td>
								<td class="FieldInput"><select id="sorgKindS"><option  dataset="sorgKind"></option></select></td>	
								
								<td class="FieldLabel"><button onclick="query()">查 询</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="somcheckGrid" width="100%" stripeRows="true" height="100%" dataset="ds" title="基金会年检列表" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="汇总列表中全部数据" iconCls="add" handler="summaryGridAll" />
		<next:ToolBarItem text="汇总选中数据" iconCls="add" handler="summarySelect" />
		<next:ToolBarItem text="汇总当年全部数据" iconCls="add" handler="summary" />
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	     
		<next:Column id="taskCode" header="task_code" field="taskCode" width="90" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="sorgCode" header="登记证号" field="sorgCode" width="150" >
			<next:TextField  />
		</next:Column>
		
		<next:Column id="cnName" header="社会组织名称" field="cnName" width="250" >
			<next:TextField  />
		</next:Column>
		<next:Column id="cnName" header="基金会类型" field="sorgKind" dataset="sorgKind" width="250" >
			<next:TextField  />
		</next:Column>
		<next:Column id="batchYear" header="年份" field="checkYear" width="150" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="status" header="年检状态" field="status" width="150" >
			<next:ComboBox dataset="somCheckStatus"/>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
			<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
