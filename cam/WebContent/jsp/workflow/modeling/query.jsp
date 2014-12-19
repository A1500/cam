<%@page import="org.loushang.workflow.util.WfPageBtnDefApi"%>
<%@page import="org.loushang.sca.ScaComponentFactory"%>
<%@page	import="org.loushang.workflow.processdefinition.procdefpagebuttondef.domain.IProcDefPageButtonDefDomain"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="org.loushang.next.data.ParameterSet"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="java.util.List"%>
<%@page import="java.net.URLDecoder" %>

<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="org.loushang.workflow.util.bsp.WfStru"%>
<%@page import="org.loushang.workflow.util.bsp.BspUtil"%>
<%
WfStru rootStru = BspUtil.getInstance().getTopMember("00"); 
String rootStruId = rootStru.getStruId();
String displaySourceTypes=request.getParameter("displaySourceTypes");
%>

<html>
<head>
<title>流程定义查询</title>
<next:ScriptManager></next:ScriptManager>
<script language="javascript" type="text/javascript">
			//通过下面的一行代码为js中的updateOrganPro传参数组织机构根节点
		     var rootStruId = '<%=rootStruId%>';
		     var displaySourceTypes='<%=displaySourceTypes%>';
		 	 //查询条件面板打开合并函数
			 function collapse(element){
				var fieldsetParent=L5.get(element).findParent("fieldset");
				if(element.expand==null||element.expand==true){	
					fieldsetParent.getElementsByTagName("div")[0].style.display="none";
					element.src = '<%=SkinUtils.getImage(request,"groupbox_expand.gif")%>';
					element.expand=false;
				}else{
					fieldsetParent.getElementsByTagName("div")[0].style.display="";
					element.src = "<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>";
					element.expand =true;
				}
			}
			//设置查询结果Grid中”是否发布“一列的显示内容，后台数据用0,1表示，在此用否，是表示
			//该函数根据后台的值，如果是0则显示否；如果是1则显示是
			//参数为列名
			function setText(rec)
			{
			   	if(rec=="1"){
			   		return "是";
			   	}else{
			   		return "否";
			   	}
			}
			//流程版本
			function setProcVersionText(rec)
			{
				if(rec=="1"){
			   		return "旧版本";
			   	}else{
			   		return "新版本";
			   	}

			}
			//修改流程的所属单位
			function updateOwnOrgan() {
				var selected = L5.getCmp('userGridPanel').getSelectionModel().getSelections();
				if(selected.length!=1)
				{
					L5.Msg.alert("提示：","请选择一项!");
					
					return;
				}
				var id = selected[0].get("id");
				
				var url=L5.webPath+"/jsp/public/help/help.jsp?helpCode=bsp_organhelp&organType=1&showOrganType=1&rootId=rootId&isCheckBox=0&returnValueType=array"
				url = url + "&organId=" + selected[0].get("organId");
				var returnValue = showModalDialog(url, window,"scroll:no;status:no;dialogWidth:500px;dialogHeight:400px");
				if(returnValue != null && Object.prototype.toString.apply(returnValue) === '[object Array]'){
				if (returnValue[0].length==0) {
					return;
				}
				var organId = returnValue[0][0];
				var organName = returnValue[0][1];
				var cmd = new L5.Command("org.loushang.workflow.modeling.definition.cmd.ProcessDefinitionModelingCmd");
				cmd.setParameter("organId", organId);
				cmd.setParameter("procDefUniqueId", id);
				cmd.execute("updateOrgan");
				if (!cmd.error) {
					var procDefDataset = L5.DatasetMgr.lookup("procDefDataset");
					procDefDataset.reload();
					L5.Msg.alert("提示：", "修改所属单位成功！");
				} else {
					L5.Msg.alert("提示：", cmd.error);
				}
				}
			}
			
			// 流程定义查询页面按钮配置
			function insertNewProcessDef(element) {
				var url = "jsp/workflow/modeling/forinsert.jsp?";
				var temp = element.id.split(";");
				// 插件类型
				var pluginType = temp[0];
				// 是否需要设置流程类型
				var needSetProcType = temp[1];
				url = url + "sourceType=" + pluginType+ "&isFullScreen=true";
				// 流程类型
				var processType;
				if (needSetProcType == "1") {
					// 需要设置流程类型（弹出流程类型设置页面）
					var processTypeurl = "../processtype/queryhelp.jsp";
					var win = showModalDialog(processTypeurl, window,
							"scroll:yes;status:no;dialogWidth:500px;dialogHeight:450px");
					if (win == null) {
						return;
					}
					processType = win[0];
				}
				if (processType != null && processType != "") {
					url = url + "&processType=" + processType;
				}
				url+="&displaySourceTypes="+displaySourceTypes;
				var text = '流程定义基本信息';
				L5.forward(url, text);
			}
			
			// 修改流程定义
			function updateProcessDef() {
				var procDefName = document.getElementById("procDefName").value;
				var version = document.getElementById("version").value;
				
				var userGridPanel = L5.getCmp("userGridPanel");
				var selecteds = userGridPanel.getSelectionModel().getSelections();
				if (selecteds.length != 1) {
					L5.Msg.alert("提示：","请选择一条您要修改的记录");
					return false;
				}
				var url = 'jsp/workflow/modeling/forupdate.jsp?id='
						+ selecteds[0].get("id")+'&procDefName='+procDefName+'&version='+version;
				var isRelease = selecteds[0].get("isRelease");
				var sourceType = selecteds[0].get("sourceType");
				var pluginPath = selecteds[0].get("pluginPath");
				var processType = selecteds[0].get("processType");
				url = url + "&sourceType=" + sourceType + "&isRelease=" + isRelease
						+ "&processType=" + processType + "&pluginPath=" + pluginPath;
				url = url + "&isFullScreen=true";
				var text = '流程定义';
				url+="&displaySourceTypes="+displaySourceTypes;
				url = encodeURI(encodeURI(url));
				L5.forward(url, text);
			}

			// 删除流程定义
			function del() {
				var userGrid = L5.getCmp('userGridPanel');
				var selected = userGrid.getSelectionModel().getSelections();
				if (selected.length < 1) {
					L5.Msg.alert("提示：","请选择要删除的记录！");
					return false;
				}
				for ( var i = 0; i < selected.length; i++) {
					if (selected[i].get("isRelease") == "1") {
						L5.Msg.alert("提示","“" + selected[i].get("procDefName") + "”已经发布，不能删除！");
						return false;
					}
				}
				var procDefDataset = L5.DatasetMgr.lookup("procDefDataset");
				L5.MessageBox.confirm('确定','确定要删除选中的记录吗？',
								function(state) {
									if (state == "yes") {
										var procDefIds = [];
										for ( var i = 0; i < selected.length; i++) {
											procDefIds[i] = selected[i].get("id");
										}
										var command = new L5.Command(
												"org.loushang.workflow.modeling.definition.cmd.ProcessDefinitionModelingCmd");
										command.setParameter("procDefIds", procDefIds);
										command.execute("delete");
										if (!command.error) {
											for ( var i = 0; i < selected.length; i++) {
												procDefDataset.remove(selected[i]);
											}
											L5.Msg.alert("提示：","删除成功！");
										} else {
											alert(command.error);
										}
									} else {
										return false;
									}
								});
			}
			
			// 导入流程定义
			function processImport() {
				var url = "jsp/workflow/modeling/forimport.jsp";
				L5.forward(url, "业务Web服务导入");
			}

			// 导出流程定义
			function processExport() {
				var userGrid = L5.getCmp('userGridPanel');
				var selected = userGrid.getSelectionModel().getSelections();
				if (selected.length < 1) {
					L5.Msg.alert("提示：","请选择要导出的记录");
					return false;
				}
				if (selected.length > 1) {
					L5.Msg.alert("提示：","请选择一条记录");
					return false;
				}
				var procDefDataset = L5.DatasetMgr.lookup("procDefDataset");
				L5.MessageBox.confirm('确定','确定要导出选中的记录吗？',
								function(state) {
									if (state == "yes") {
										var procModelDefUniqueId;
										procModelDefUniqueId = selected[0].get("id");
										var url = "command/dispatcher/org.loushang.workflow.modeling.exchange.cmd.ProcessDefExportCmd/exportProcDef";
										var url = url + "?procModelDefUniqueId="
												+ procModelDefUniqueId;
										L5.forward(url, "导出流程定义");
									} else {
										return false;
									}
								});
			}

			// 流程定义查询
			function query() {
				var procDefDataset = L5.DatasetMgr.lookup("procDefDataset");				
			    var procDefName = document.getElementById("procDefName").value;
				if(procDefName.indexOf("'")!=-1){
					  L5.Msg.alert("提示", "不接受单引号输入!");
					  return;
				}
				if (procDefName == "")
					procDefName = undefined;// 如果没有只就设为undifined对应java的null

				var version = document.getElementById("version").value;
				var isHistory = "";
				if (version != null && version == "newversion") {
					isHistory = "0";//
				} else if (version != null && version == "oldversion")
					isHistory = "1";//
				else {
					isHistory = undefined;
				}
				
				procDefDataset.setParameter("WF_PROCESS_DEF_MODELING.PROC_DEF_NAME@like",
						procDefName);// 设置参数值,用@分开的两段：前面是参数名,后面是比较符号
				procDefDataset.setParameter("WF_PROCESS_DEF_MODELING.IS_HISTORY@like",
						isHistory);
				if(displaySourceTypes!="null"&&displaySourceTypes.length>0)
				{
					procDefDataset.setParameter("WF_PROCESS_DEF_MODELING.SOURCE_TYPE@in",
							displaySourceTypes);
				}
			 			
				procDefDataset.load();
			}	
			
			// 修改流程类型
			function updateProcessType() {
				var userGridPanel = L5.getCmp("userGridPanel");
				var selecteds = userGridPanel.getSelectionModel().getSelections();
				if (selecteds.length != 1) {
					L5.Msg.alert("提示：","请选择一条您要修改的记录");
					return false;
				}
				var processDefUniqueId = selecteds[0].get("id");
				var processType = selecteds[0].get("processType");
				var processTypeurl = "../processtype/queryhelp.jsp";
				var win = showModalDialog(processTypeurl, window,
						"scroll:yes;status:no;dialogWidth:500px;dialogHeight:450px");
				if (win == null) {
					return;
				}
				processType = win[0];
				
				var command = new L5.Command(
					"org.loushang.workflow.modeling.definition.cmd.ProcessDefinitionModelingCmd");
				command.setParameter("processType",processType);
				command.setParameter("processDefUniqueId",processDefUniqueId);
				command.execute("updateProcessType");
				if (!command.error) {
					L5.Msg.alert("提示：","流程类型修改成功！");
				
					query();
				} else {
					alert(command.error);
				}
			}
			
			// 发布流程定义
			function release() {
				var userGridPanel = L5.getCmp("userGridPanel");
				var selecteds = userGridPanel.getSelectionModel().getSelections();
                if(selecteds.length==0){
                	L5.Msg.alert("提示：","请至少选择一项!");
                    return;
                    }
				var procDefUniqueIdsRelease = [];
				var releaseCount = 0;
				// 循环遍历选中的记录，并根据是否发布进行分类
				for (i = 0; i < selecteds.length; i++) {
					procDefUniqueIdsRelease[releaseCount++] = selecteds[i].get("id");
				}				
				var command = new L5.Command("org.loushang.workflow.modeling.definition.cmd.ProcessDefinitionModelingCmd");
				command.setParameter("procDefUniqueIds",procDefUniqueIdsRelease);
				command.execute("release");
				if (!command.error) {
					L5.Msg.alert("提示：","发布成功!");
					
					// 更新记录的状态
					query();
				} else {
					alert(command.error);
				}
			}
			
			function init() {
				var procDefDataset = L5.DatasetMgr.lookup("procDefDataset");
				<%
				Object procDefName=request.getParameter("procDefName");
				String version=(String)request.getParameter("version");
				if(procDefName!=null){
					procDefName = URLDecoder.decode((String)procDefName, "UTF-8");
				%>			    	
				    var version="<%=version%>";
				    var procDefName="<%=(String)procDefName%>";
				    document.getElementById("procDefName").value=procDefName;
				    document.getElementById("version").value=version;
					var isHistory = "";
					if (version != null && version == "newversion") {
						isHistory = "0";//
					} else if (version != null && version == "oldversion")
						isHistory = "1";//
					else {
						isHistory = undefined;
					}
					procDefDataset.setParameter("WF_PROCESS_DEF_MODELING.PROC_DEF_NAME@like",
							procDefName);// 设置参数值,用@分开的两段：前面是参数名,后面是比较符号
					procDefDataset.setParameter("WF_PROCESS_DEF_MODELING.IS_HISTORY@like",
							isHistory);
				<%
				}else{
			    %>
			    var procDefName = document.getElementById("procDefName").value;
				if(procDefName.indexOf("'")!=-1){
					  L5.Msg.alert("提示", "不接受单引号输入!");
					  return;
				}
				if (procDefName == "")
					procDefName = undefined;// 如果没有只就设为undifined对应java的null

				var version = document.getElementById("version").value;
				var isHistory = "";
				if (version != null && version == "newversion") {
					isHistory = "0";//
				} else if (version != null && version == "oldversion")
					isHistory = "1";//
				else {
					isHistory = undefined;
				}
				procDefDataset.setParameter("WF_PROCESS_DEF_MODELING.PROC_DEF_NAME@like",
						procDefName);// 设置参数值,用@分开的两段：前面是参数名,后面是比较符号
				procDefDataset.setParameter("WF_PROCESS_DEF_MODELING.IS_HISTORY@like",
						isHistory);

			    <%
				}
				%>	
				if(displaySourceTypes!="null"&&displaySourceTypes.length>0)
				{
					procDefDataset.setParameter("WF_PROCESS_DEF_MODELING.SOURCE_TYPE@in",
							displaySourceTypes);
				}			
				procDefDataset.load();
			}
						
		</script>
</head>
<body>

<model:datasets>
	<model:dataset pageSize="10" id="procDefDataset"
		cmd="org.loushang.workflow.modeling.definition.cmd.ProcessDefinitionModelingQueryCmd">
		<model:record excluding="xpdlContent,xmlContent"
			fromBean="org.loushang.workflow.modeling.definition.data.ProcessDefinitionModeling"></model:record>
	</model:dataset>
</model:datasets>

<model:datasets>
	<model:dataset pageSize="10" id="procDefDatasetList"
		cmd="org.loushang.workflow.processdefinition.procdefpagebuttondef.cmd.ProcDefPageButtonDefQueryCmd">
		<model:record excluding="xpdlContent,xmlContent"
			fromBean="org.loushang.workflow.processdefinition.procdefpagebuttondef.data.ProcDefPageButtonDef"></model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort>
  <next:BorderLayout>
	<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
	<next:Center>
	<next:Panel>
		<next:Panel width="100%" border="0"
			bodyStyle="padding-bottom:10px;padding-top:0px;">
			<next:Html>
				<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
					onclick="collapse(this);" /> </legend>
				<div class="GroupBoxDiv" style="width: 100%; height: 100%;">
				<form onsubmit="return false;" class="L5form">
				<table border="1" width="100%">
					<tr>
						<td class="FieldLabel">流程名称：</td>
						<td class="FieldInput"><input type="text" id="procDefName"
							class="TextEditor" title="流程名称" /></td>
						<td class="FieldLabel">流程版本：</td>
						<td class="FieldInput"><select type="text" value="newversion"
							id="version" class="TextEditor" title="流程版本">
							<option value="newversion">新版本</option>
							<option value="all">全部</option>
							<option value="oldversion">旧版本</option>
						</select></td>
						<td class="FieldButton" rowspan="2">
						<button onclick="query()">查询</button>
						</td>
					</tr>
				</table>
				</form>
				</div>
				</fieldset>
			</next:Html>
		</next:Panel>
		<next:GridPanel id="userGridPanel" name="userGridPanel" anchor="100%"
			width="100%" height="100%" dataset="procDefDataset"    
			title="流程定义列表" notSelectFirstRow="true">

			<next:Columns>
				<next:RowNumberColumn width="30" />
				<next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column id="id" header="内码" field="id" width="50" hidden="true">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column header="流程名称" field="procDefName" width="150">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column header="插件类型" field="sourceType" width="150" hidden="true">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column header="插件名称" field="pluginName" hidden="true">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column header="插件路径" field="pluginPath" hidden="true">
					<next:TextField allowBlank="false"/>
				</next:Column>
				<next:Column header="创建时间" field="createTime" width="150">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column header="流程类型" field="processType" width="150"
					hidden="true">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column header="流程类型名称" field="processTypeName" width="250">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column id="isHistory" header="流程版本" field="isHistory"
					renderer="setProcVersionText" width="100">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column id="isRelease" header="是否发布" field="isRelease"
					renderer="setText" width="100">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column header="所属单位名称" field="organName" width="100">
				</next:Column>
				<next:Column header="所属单位的组织ID" field="organId" hidden="true">
				</next:Column>
			</next:Columns>
			<next:TopBar>
				<% 

					DataSet ds=WfPageBtnDefApi.getProcDefPageButtonDef();
					for(int i=0;i<ds.getCount();i++)
					{ 
						Record record=ds.getRecord(i);
						String displayName=record.get("displayName").toString();
						String pluginType=record.get("pluginType").toString();
						String needSetProcType=record.get("needSetProcType").toString();
						String temp = pluginType + ";" + needSetProcType;
				%>
						<next:ToolBarItem iconCls="add" id="<%=temp %>" text="<%=displayName%>"	handler="insertNewProcessDef(this)"/>
				<% 
					}
				%>
				<next:ToolBarItem iconCls="add" text="修改流程定义" handler="updateProcessDef"/>
				<next:ToolBarItem iconCls="add" text="修改流程类型" handler="updateProcessType"/>
				<next:ToolBarItem iconCls="add" text="修改所属单位" handler="updateOwnOrgan"/>
				<next:ToolBarItem iconCls="delete" text="删除" handler="del" />
				<next:ToolBarItem iconCls="select" text="发布" handler="release" />
				<next:ToolBarItem iconCls="select" text="导入流程"
					handler="processImport" />
				<next:ToolBarItem iconCls="select" text="导出流程"
					handler="processExport" />
			</next:TopBar>
			<next:BottomBar>
				<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条"
					displayInfo="true" dataset="procDefDataset" />
			</next:BottomBar>
		</next:GridPanel>
	</next:Panel>
	</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
</html>