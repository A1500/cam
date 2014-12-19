<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
<head>
<%

	String nameValue=request.getParameter("name");
	String flag=request.getParameter("flag");
	if(flag == null){
		flag="";
	}
	String name="";
	if("accept".equals(nameValue)){
		name="受理";
	}else if("check".equals(nameValue)){
		name="审核";
	}else if("audit".equals(nameValue)){
		name="审批";
	}
%>
<title>新申请待办</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
<script type="text/javascript" src="../../print/samApplyPrint.js"></script>
<script type="text/javascript">
var time1 = '';
    <%
    String organArea=BspUtil.getCorpOrgan().getOrganCode();
	String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
    %>
	var organArea='<%=organArea%>';
	var organName='<%=organName%>';
	var nameValue='<%=nameValue%>';
	var flag='<%=flag%>';
	var assistanceType="01";
	var applyIds ='';
	var assignmentIds='';
	function init(){
		query();
		document.getElementById("lrdwmc").value=organName;
		document.getElementById("lrdwId").value=organArea;
	}
	
	//测试
	function exportTest(){
		var grid = L5.getCmp('daiBanGridPanel');
		var sm = grid.getSelectionModel();
		var records=sm.getSelections();
		var applyIds="";
		for(var i =0; i<records.length; i++){
			applyIds+=records[i].get("APPLY_ID")+",";
		}
		var url = "../../../export/exportInfo.jsp?applyIds="+applyIds;
		var width = "800";
	    var height = "200";
	    //var width = screen.availWidth;
	    //var height = screen.availHeight;
		var returnValue = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
		if(true || returnValue) {
			//reQuery();
		}
	}
	
	//测试
	function exportXml(){
		var grid = L5.getCmp('daiBanGridPanel');
		var sm = grid.getSelectionModel();
		var records=sm.getSelections();
		var applyIds="";
		if(records&&records.length==1){
			for(var i =0; i<records.length; i++){
				applyIds+=records[i].get("APPLY_ID")+",";
			}
			//exportDataSet.setParameter("applyIds",applyIds);
			//exportDataSet.load();
			
			var command = new L5.Command("com.inspur.cams.drel.comm.service.cmd.EnsureWebserviceCmd");
			command.setParameter("applyIds",applyIds);
			command.execute("queryExport");
			if (!command.error) {
				L5.Msg.alert("提示","导出成功！",function(){
					query();
				});		
			}else{
				L5.Msg.alert('提示',"导出时出现错误！"+command.error);
			}
		}else{
			L5.Msg.alert("提示","请选择一条记录！");
		}
	}
	
	
	//新增业务
	function newApply(){
		var width = screen.width-100;
	    var height = screen.height-140;
		var url='samCityInsert.jsp?method=insert&applyId=&name='+nameValue+"&hrefFlg="+getCurrent();
		window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	}
	//办理						
	function handle(){
		var grid = L5.getCmp('daiBanGridPanel');
		var sm = grid.getSelectionModel();
		var records=sm.getSelections();
		if(records&&records.length==1){
			var width = screen.width-100;
		    var height = screen.height-140;
		    
		    var curActivityId = records[0].get("CUR_ACTIVITY_ID");
			if(curActivityId != nameValue){
				L5.Msg.alert("警告","此业务因乡镇（街道）操作时出现问题！请联系维护人员！");
				return;
			}
		    
		    if(nameValue=="accept" || ( records[0].get('ACCEPT_DEPT_ID') == records[0].get('CHECK_DEPT_ID')&& flag=='1' ) ){
				var url='samCityInsert.jsp?method=update&name='+nameValue+'&applyId='+records[0].get('APPLY_ID')+'&assignmentId='+records[0].get('ID')+"&hrefFlg="+getCurrent();
		    }else{
		  	  var url='samCityDetail.jsp?method=handle&name='+nameValue+'&applyId='+records[0].get('APPLY_ID')+'&assignmentId='+records[0].get('ID')+"&hrefFlg="+getCurrent();
		    }
			window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
		
		}else{
			L5.Msg.alert("提示","请选择一条记录！");
		}
	}
	//批量审批
	function batchHandle(){
		var grid = L5.getCmp('daiBanGridPanel');
		var sm = grid.getSelectionModel();
		var records=sm.getSelections();
		applyIds='';
		assignmentIds="";
		if(records&&records.length > 0){
			for(var i =0; i<records.length; i++){
				var curActivityId = records[i].get("CUR_ACTIVITY_ID");
				if(curActivityId != nameValue){
					L5.Msg.alert("警告","户主姓名为"+records[i].get("FAMILY_NAME")+"的业务因乡镇（街道）操作时出现问题！请联系维护人员！");
					return;
				}
				applyIds += records[i].get('APPLY_ID') +';';
				assignmentIds += records[i].get('ID') +';';
			}
			var width = screen.width-300;
			var height = screen.height-300;
		  	var url='../../batchApp/samBatchHandleAuditApply.jsp?method=handle&assistanceType='+assistanceType+'&hrefFlg='+getCurrent();
			window.showModalDialog(url, window, "scroll:no;status:no;resizable=no;location=no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
		
		}else{
			L5.Msg.alert("提示","请至少选择一条记录！");
		}
	}
	
	//批量审批
	function batchInsert(){
		var grid = L5.getCmp('daiBanGridPanel');
		var sm = grid.getSelectionModel();
		var records=sm.getSelections();
		applyIds='';
		assignmentIds="";
		if(records&&records.length > 0){
			for(var i =0; i<records.length; i++){
				var curActivityId = records[i].get("CUR_ACTIVITY_ID");
				if(curActivityId != nameValue){
					L5.Msg.alert("警告","户主姓名为"+records[i].get("FAMILY_NAME")+"的业务因乡镇（街道）操作时出现问题！请联系维护人员！");
					return;
				}
				applyIds += records[i].get('APPLY_ID') +';';
				assignmentIds += records[i].get('ID') +';';
			}
			var width = screen.width-300;
			var height = screen.height-300;
		  	var url='../../batchApp/samBatchInsertNotNull.jsp?assistanceType='+assistanceType+'&hrefFlg='+getCurrent();
			window.showModalDialog(url, window, "scroll:no;status:no;resizable=no;location=no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
		
		}else{
			L5.Msg.alert("提示","请至少选择一条记录！");
		}
	}
	
	//删除
	function removeApply(){
		var grid = L5.getCmp('daiBanGridPanel');
		var sm = grid.getSelectionModel();
		var records=sm.getSelections();
		if(records&&records.length==1){
		    if(nameValue=="accept" || ( records[0].get('ACCEPT_DEPT_ID') == records[0].get('CHECK_DEPT_ID')&& flag=='1' ) ){
			  	L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
					if(sta=="yes"){
						var command = new L5.Command("com.inspur.cams.drel.sam.cmd.SamApplyInfoCmd");
						command.setParameter("APPLY_ID",records[0].get('APPLY_ID'));
						command.execute("deleteSamApply");
						if (!command.error) {
							L5.Msg.alert("提示","删除成功！",function(){
								query();
							});		
						}else{
							L5.Msg.alert('提示',"删除时出现错误！"+command.error);
						}
					}
					else{
						return;
					}
				});	
		    }else{
		    	L5.Msg.alert("提示","没有权限删除此条数据！");
		    }
		}else{
			L5.Msg.alert("提示","请选择一条记录！");
		}
	}
	//查询
	function query(){
	   var lrdwId=document.getElementById("lrdwId").value;
	    if(""==lrdwId){
	    	lrdwId=organArea;
	    }
		var regDateStart=document.getElementById("regDateStart").value;
		var regDateEnd=document.getElementById("regDateEnd").value;
		var familyName=document.getElementById("familyName").value;
		var idCard=document.getElementById("idCard").value;
		var mysetwhere="FAMILY_NAME:"+familyName+"&FAMILY_CARD_NO:"+idCard+"&DOMICILE_CODE:"+lrdwId+"&APPLY_DATE:"+regDateStart+"-"+regDateEnd;
		applyDataSet.setParameter("mysetwhere",mysetwhere);
		applyDataSet.load();
		noReclick(applyDataSet,"queryId");
		

		if (regDateStart > regDateEnd) {
			alert("开始日期不能大于结束日期，请重新输入！");
			regDateStart.focus();
			return false;
	     }
	}
	/**
	 * 选择属地行政区划窗口
	 */
	function func_ForDomicileSelect() {
		var revalue = window.showModalDialog(
				L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
						+ organArea + "&organName="
						+ escape(encodeURIComponent(organName)), "",
				"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if (revalue != "" && revalue != undefined) {
			var list = revalue.split(";");
			document.getElementById("lrdwId").value = list[0];
			document.getElementById("lrdwmc").value = list[1];
		}
	}
	//获取当前时间
	function getCurrent(){
		
		return (new Date()).getTime();
	}
	
	//导出数据
	function exportExcel(){
		
		  var dataset = L5.DatasetMgr.lookup("applyDataSet");
		    if(dataset.getCount()<1){
		        L5.Msg.alert("提示","没有要导出的信息！");
		        return;
		    }
		  
		    
	        var startCursor = dataset.pageInfo.startCursor;
	        dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	        dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	        dataset.baseParams["limitExcel"]=dataset.getTotalCount();  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为dataset.getTotalCount()

		    var filename="城市低保_新申请_待办_"+"<%=name%>";
		    var class_path = "com.inspur.cams.drel.funds.release.cmd.SamReleaseCSVCommand";
		    var gridObj = L5.getCmp("daiBanGridPanel");
		    L5.grid2excel(dataset,gridObj,filename,class_path);
	}
	
	function showEnsureInfo(){
		var grid = L5.getCmp('daiBanGridPanel');
		var sm = grid.getSelectionModel();
		var records=sm.getSelections();
		if(records.length==1){
			if(records[0].get("ENSURE_ID")==""){
				L5.Msg.alert("提示","核对信息未反馈！");
				return;
			}
			var applyId=records[0].get("APPLY_ID");
			var url = "../../../comm/ensureInfo/ensureToClientDetail.jsp?applyId="+applyId;
			var width = "1200";
		    var height = "300";
		    //var width = screen.availWidth;
		    //var height = screen.availHeight;
			var returnValue = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
			if(true || returnValue) {
				//reQuery();
			}
		}else{
			L5.Msg.alert("提示","请选择一条记录！");
		}
	}
	
	function getCheckFlg(value,a,rec)
	{
		//var imagePath=L5.webPath+"/jsp/workflow/tasklist/images/";
	//	var image="";
	var str="";
	if(value=="")
	{
		str="未反馈";
	}
	else{
		str="已反馈";
	}
	
		return str;
	}
	
	
</script>
</head>
<body>

<model:datasets>
	<!-- 核对家庭信息 -->
	<model:dataset id="esureyFamilyDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyFamilyQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyFamily">
		</model:record>
	</model:dataset>
	<model:dataset id="printDS" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" method="queryDaiBan" global="true"  >
		<model:params>
			<model:param name="processType" value='samCity'></model:param>
			<model:param name="actDefName" value='<%=name%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 业务信息 -->
	<model:dataset id="applyDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" method="queryDaiBan" global="true"  pageSize="20" >
		<model:record>
			<model:field name="checkFlg"/>
		</model:record>
		<model:params>
			<model:param name="processType" value='samCity'></model:param>
			<model:param name="actDefName" value='<%=name%>'></model:param>
		</model:params>
	</model:dataset>
	
	<!-- 业务信息 test-->
	<model:dataset id="exportDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" method="queryExport" global="true"  pageSize="20" >
	</model:dataset>
</model:datasets>
			<next:Panel width="100%" height="100%">
				<next:Panel title="待办业务查询" width="100%" autoHeight="true" titleCollapse="true" collapsible="true"  >	
					<next:Html>			
							<form class="L5form">
								<table  border="1" width="100%">
									<tr>
									 	<td class="FieldLabel" style="width:10%">地区</td>
						                <td class="FieldInput" style="width:20%">
						                 <input type="text" id="lrdwmcquery" readonly name="lrdwmc" id="lrdwmc" value="<%=organName%>" style='width:80%'/>
									  <input type="text" style="display: none;"  name="lrdwId" id="lrdwId" value="<%=BspUtil.getCorpOrgan().getOrganCode()%>"/>
									  <img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="func_ForDomicileSelect()" />
						               
						               </td>
						                <td class="FieldLabel" style="width:10%">登记日期</td>
						                <td class="FieldInput" style="width:20%"><input type="text" id="regDateStart"  format="Y-m-d" onclick="LoushangDate(this)" style = "padding-right:20px;background:url('<%= SkinUtils.getImage(request, "default/rl.gif ") %> ') no-repeat scroll right center transparent; "/>
						                                                               
						                                                         
						                	至<input type="text" id="regDateEnd" format="Y-m-d" onclick="LoushangDate(this)" style = "padding-right:20px;background:url('<%= SkinUtils.getImage(request, "default/rl.gif ") %> ') no-repeat scroll right center transparent; "/>
						                	        
						                </td>
						                <td class="FieldButton" style="width:10%"><button style="width:100" id="queryId" onclick="query();">查询</button></td>
									</tr>
									<tr>
									 	<td class="FieldLabel" style="width:10%">户主姓名</td>
						                <td class="FieldInput" style="width:10%"><input type="text"  id="familyName" style='width:80%' maxlength="30"/></td>
						                <td class="FieldLabel" style="width:10%">身份证号码</td>
						                <td class="FieldInput" style="width:10%"><input type="text" id="idCard" style="width:79%" maxlength="18"/></td>
						                 <td class="FieldButton" style="width:10%"><button type="reset" style="width:100">重置</button></td>
									</tr>
								</table>
							</form>
					</next:Html>
				</next:Panel>
				 <next:GridPanel  clickToSelectedForChkSM="true"id="daiBanGridPanel" title="待办业务列表" dataset="applyDataSet" width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
					<next:TopBar>		
						<next:ToolBarItem symbol="->"></next:ToolBarItem>	
						<%
							if( "受理".equals(name) || "1".equals(flag) ){	%>	
							
								<next:ToolBarItem iconCls="add"  text="新增" handler="newApply"/>
							<%	if("审核".equals(name)){%>	
								
								<next:ToolBarItem iconCls="add"  text="批量填写审核信息" handler="batchInsert"/>
								<%
							}
						%>	
							<%
								
							}
						%>	
						<next:ToolBarItem iconCls="detail"  text="办理" handler="handle"/>
						<%
							if( "受理".equals(name) || "1".equals(flag) ){	%>	
							
								<next:ToolBarItem iconCls="remove"  text="删除" handler="removeApply"/>
							
							<%
								
							}else{
						%>	
							<%
								
							}
						%>	
						<%
						if( "审批".equals(name)){	%>	
							
								<next:ToolBarItem iconCls="detail"  text="批量审批" handler="batchHandle"/>
							
							<%
								
							}else{
						%>	
							<%
								
							}
						%>	
                        <next:ToolBarItem iconCls="print"  text="打印公示书" handler="printCityDaiBan"/>   
                         <next:ToolBarItem iconCls="export"  text="导出Excel至核对" handler="exportTest"/> 
                         <next:ToolBarItem iconCls="detail"  text="查看核对信息" handler="showEnsureInfo"/> 
                        <%-- <next:ToolBarItem iconCls="export"  text="导出Excel" handler="exportExcel"/>   --%>
                        <next:ToolBarItem iconCls="export"  text="在线接口至核对" handler="exportXml"/>   
					</next:TopBar>
					<next:Columns>
		   				<next:RowNumberColumn/>
		   				<next:CheckBoxColumn></next:CheckBoxColumn>
		   				<next:Column  header="街道（乡镇）" field="TOWM_NAME"  width="200"  ></next:Column>	
						<next:Column  header="社区（村）" field="DOMICILE_NAME"  width="200"  ></next:Column>							
				        <next:Column header="户主姓名" field="FAMILY_NAME" width="150" ></next:Column>
			        	<next:Column header="身份证号码" field="FAMILY_CARD_NO" width="150" ></next:Column>
						<next:Column header="登记日期" field="APPLY_DATE" width="150" ></next:Column>
						<next:Column header="当前环节" field="ACT_DEF_NAME" width="140" ></next:Column>
						<%
						 if("audit".equals(nameValue)){%>
						<next:Column header="核对状态" field="ENSURE_ID" width="140" renderer="getCheckFlg"></next:Column>
						 
						 <%
							}
							
						%>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="applyDataSet" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>

</body>

</html>