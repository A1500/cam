
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
	<%
	response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");  
	response.setHeader("Cache-Control", "no-store,no-cache,must-revalidate");  
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
	response.setHeader("Pragma", "no-cache");  
	%>
		<title>电子文档修改</title>
		<next:ScriptManager/>
		<script>
			var electronicId='<%=request.getParameter("electronicId")%>';
			var fileId='<%=request.getParameter("fileId")%>';
	
		</script>
		<script type="text/javascript" src="fileupdate.js"></script>
		
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.bptelectronicfile.cmd.BptUploadfileQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.bptelectronicfile.dao.BptUploadfile"></model:record>
	</model:dataset>
</model:datasets>
	

<next:EditGridPanel id="editGridPanel" name="bptuploadfileGrid" width="100%" stripeRows="true" height="400" dataset="ds" title="电子文档信息">
	<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>					
			<next:ToolBarItem iconCls="save"  text="保存" handler="save" />			
			<next:ToolBarItem symbol="&nbsp;&nbsp;&nbsp;" ></next:ToolBarItem>	
			
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	     
		<next:Column id="fileId" header="FILE_ID" field="fileId" width="80" hidden="true">			
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="fileName" header="文件名" field="fileName" width="150"  >			
			<next:TextField  />
		</next:Column>
	
		<next:Column id="fileType" header="FILE_TYPE" field="fileType" width="1" hidden="true">			
			<next:TextField  />
		</next:Column>
	
		<next:Column id="fileMess" header="FILE_MESS" field="fileMess" width="1" hidden="true">			
			<next:TextField  />
		</next:Column>
	
		<next:Column id="filePath" header="FILE_PATH" field="filePath" width="1" hidden="true">			
			<next:TextField  />
		</next:Column>
	
		<next:Column id="files" header="FILES" field="files" width="80" hidden="true">			
			<next:TextField  />
		</next:Column>
	
		<next:Column id="rangeFlag" header="RANGE_FLAG" field="rangeFlag" width="1" hidden="true">			
			<next:TextField  />
		</next:Column>
	<next:Column id="fileOper" header="FILE_OPER" field="fileOper" width="1" hidden="true">			
			<next:TextField  />
		</next:Column>
	
		<next:Column id="fileNumber" header="FILE_NUMBER" field="fileNumber" width="1" hidden="true">			
			<next:NumberField  />
		</next:Column>
	
		<next:Column id="fileTime" header="FILE_TIME" field="fileTime" width="1" hidden="true">			
			<next:TextField  />
		</next:Column>
		<next:Column id="viewOrder" header="展示顺序" field="viewOrder" width="80" >			
			<next:NumberField  />
		</next:Column>
	
		
			
	</next:Columns>
	</next:EditGridPanel>
</body>
</html>
