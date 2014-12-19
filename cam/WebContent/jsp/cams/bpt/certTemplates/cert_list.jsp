<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<% 
	String organCode = BspUtil.getOrganCode();
%>
<html>
	<head><style>a{TEXT-DECORATION:none}</style>
		<title>优抚打证模板列表</title>
		<next:ScriptManager></next:ScriptManager>
	</head>
<body>

<model:datasets>
	<model:dataset id="certTemplates" cmd="com.inspur.cams.bpt.manage.cmd.BptCertTemplatesQueryCommand" method="query"  global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptCertTemplates">
		</model:record>
	</model:dataset>
	
	<!-- 业务类型 -->
	<model:dataset id="SERVICETYPE" enumName="BPT.CERTTYPE" autoLoad="true" global="true"/>
</model:datasets>

<next:Window id="addNewDemobilizedGrantObject" title="修改打证模板" resizable="false" width="600" height="100"  closeAction="hide" modal="true">
	<next:Panel>
	<next:Html>
		<form onsubmit="return false" id="form_content" dataset="certTemplates" style="width: 99%; height: 100%;" class="L5form">
			<table  border="1" width="100%" >
			<tr>  
				<td width="12%" nowrap="nowrap" class="FieldLabel">模板文件：</td>
				<td width="78%" nowrap="nowrap" class="FieldInput">
				<input style="width:450px;" type="file" id="filename" name="filename" title="文件名"  /></td>	
				
				<td width="10%" nowrap="nowrap" align="center"><button onclick="upload()">上传</button></td>
			</tr>
			</table>
		</form>
	</next:Html>
	</next:Panel>
</next:Window>
<next:GridPanel id="certGridPanel" name="certGridPanel" stripeRows="true" width="100%" height="100%"  dataset="certTemplates"  >
			<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	    			<next:CheckBoxColumn></next:CheckBoxColumn>
					<next:Column id="serviceType" header="业务类型" field="serviceType"   dataset="SERVICETYPE" width="20%">
						<next:TextField allowBlank="false" />
					</next:Column>
					<next:Column id="fileName" header="模板文件名" field="fileName" width="50%" renderer="cert_click">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="modTime" header="修改时间" field="modTime" align="center" width="15%" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="operation" header="操作" field="fileId" renderer="operation" align="center" width="10%" >
						<next:TextField allowBlank="false"/>
					</next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar  dataset="certTemplates"/>
				</next:BottomBar>
			</next:GridPanel>
			<input type="hidden"  id="updatefileId" value=""/>
</body>

<script language="javascript"  type="text/javascript" >

	function init() {
		var certTemplates = L5.DatasetMgr.lookup("certTemplates");
		certTemplates.load();
		L5.QuickTips.init();
	}	
	
	
	function upload() {
		var filename = document.getElementById("filename").value;
		if(filename == null || filename == "") {
			L5.Msg.alert("提示","请选择上传的文件");
			return false;
		}
		var lastIndex = filename.lastIndexOf(".");
		var suffFileName = filename.substring(lastIndex+1);// 取得模板后缀名
		if(suffFileName != "doc" && suffFileName != "docx") {
			L5.Msg.alert("提示","上传文件格式不正确");
			return false;
		}
	
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCertTemplatesCommand");
		command.setParameter("suffFileName",suffFileName);
		command.setParameter("fileId",document.getElementById("updatefileId").value);
		command.setForm("form_content");
		command.execute("insert");
		
		command.afterExecute=function(){
			if (!command.error) {  
				L5.Msg.alert('提示',"数据保存成功!");
				L5.getCmp('addNewDemobilizedGrantObject').hide();
				init();
			}else{  
				L5.Msg.alert('提示',command.error);
			}
		}  
	}
	
	function cert_click(value, cellmeta, record) {
		var path = record.get("filePath"); 
		var isdefault = record.get("isDefault");
		var func = 'javascript:downloadFile("' + path + '","'+value+'","'+isdefault+'")';
		var str = "<a href='"+func+"'>" + value + "</a>";
		return str;
	}
	
	function downloadFile(path,filename,isdefault) {
		if(isdefault == "0") {
			var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCertTemplatesCommand");
			command.setParameter("filePath",path);
			command.execute("ifexeit");
			var exist = command.getReturn("exist");
			if(exist) {
				filename = escape(encodeURIComponent(filename));
				window.location=L5.webPath+"/fileDownload?filePath="+path + "&fileName="+filename;
			} else {
				L5.Msg.alert("提示","文件不存在！");
			}
		} else if(isdefault == "1") {
			filename = escape(encodeURIComponent(filename));
				window.location=L5.webPath+"/fileDownload?filePath="+path + "&fileName="+filename + "&project=1"; //模板路径在项目中
		}
	}
	
	
	function operation(value) {
		var func = 'javascript:uploadById("' + value + '")';
		var str = "<a href='"+func+"'>" + '保存' + "</a>"; 
		return str;
	} 
	
	function uploadById(id) {
	     document.getElementById("updatefileId").value = id;
		 var s = L5.getCmp('addNewDemobilizedGrantObject');
		 s.show();
	}
	   
	
</script>
</html>