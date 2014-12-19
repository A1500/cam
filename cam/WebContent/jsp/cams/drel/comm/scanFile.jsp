<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script type="text/javascript">
   //var organCode = '<%=request.getParameter("organCode")%>' ;
   //var peopleId = '<%=request.getParameter("peopleId")%>' ;
   //var serviceType = '<%=request.getParameter("serviceType")%>' ;
   var applyId = '<%=request.getParameter("applyId")%>' ;
   var i=0;
   var fileName;
   var filePath='c:/cams';
   var fileType='jpg';
   var grabFlag="1";//1竖向，2,横向
  // var electronicId=
</script>
<%
	response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");  
	response.setHeader("Cache-Control", "no-store,no-cache,must-revalidate");  
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
	response.setHeader("Pragma", "no-cache");  
%>
<html>
	<head>
		<title>扫描文件</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="scanFile.js"></script>
		<script language="javascript">
		var vclose=false;
		window.onbeforeunload=winclose;
		var deb    = 0 ; //執行模式 0:無寫入執行log 1:寫入執行log		 				
		function  winclose()     
		{　　     
		       	//alert(vclose);
		       	if(vclose=="true")
		       	{	
		       		return;
		       	}
		       	Stop();  
		       	vclose="true";
		       	//alert(vclose);
		       	//opener.document.location.reload();
		}  		
		window.setTimeout("format('0 -90')",3000);				
			
		</script>
	</head>
	<model:datasets>
		<!-- 电子档案 -->
		<model:dataset id="filesScanDataset" cmd="com.inspur.cams.drel.sam.cmd.SamApplyFilesQueryCmd" global="true">
			<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyFiles">
				<model:field name="fileType" type="string" rule="require" />
				<model:field name="remarks" type="string" rule="length{500}" />
			</model:record>
		</model:dataset>
		<!-- 申请证明材料 -->
		<model:dataset id="fileTypeDataset" enumName="SAM_FILE_NAME" autoLoad="true" global="true"></model:dataset>
	</model:datasets>
<body onload="Start();" onunload="winclose();" > 

					<form style="width: 100%; height: 100%;" class="L5form" name="file" dataset='filesScanDataset'>
						<table  border="0" width="100%" align="center">
							<tr>
								<td colspan='3'>
								<table border="0" width="60%" align="center">
									<tr>
										<td class="FieldLabel" style="width: 10%">证明材料名称</td>
										<td class="FieldInput" style="width: 30%">
											<select id='fileType' field="fileType" name='证明材料名称' style="width: 97%">
												<option dataset="fileTypeDataset"></option>
											</select><label style='color:red'>*</label>
										</td>
									</tr>
									<tr>
										<td class="FieldLabel" style="width: 10%">备注</td>
										<td class="FieldInput" style="width: 30%">
											<textarea id='remarks' field="remarks" name='备注' style="width: 97%" rows='3'></textarea>
										</td>
									</tr>
								</table>
								</td>
							</tr>	
							<tr >
								<td colspan="1" nowrap="nowrap" align="center" id="td_dyp" style="display='none'">
								拍摄前画面：<br>
									<object classid='clsid:E34D8477-D713-4421-AB86-8C86C03EDF06' width=420 height=550 align="middle" id='VideoChannel'></object>								
								</td>	
								<td colspan="1" nowrap="nowrap" align="center" id="td_th" style="display='none'">
								拍摄前画面：<br>
									<object classid='clsid:1353A621-B179-454B-80A2-A68FF44DC266' width=420 height=550 align="middle" id='VideoTh' ></object>								
								</td>
								<td  nowrap="nowrap" align="center">			
								拍摄后预览：<br>			
									<OBJECT classid="clsid:BE09AB71-8C98-4B7A-B539-08E8F61D5453" codebase=L5.webPath+"/jsp/cams/btp/comm/video.CAB#version=1,0,22,0" width=420 height=560 align=center hspace=0 vspace=0 id='delbase64'></OBJECT>
								  </td>							
							</tr>						
							<tr align="center">
									<td colspan="3" align="center">
											选择文拍仪设备：<label><input type="radio" name="ModeGroup1" value="0" onclick="changeModel()">多易拍540</label>
													    <label><input name="ModeGroup1" type="radio" value="1" onclick="changeModel()">泰和</label>
													     <label><input name="ModeGroup1" type="radio" value="2" onclick="changeModel()">多易拍360</label>
								</td>
							</tr>
							<tr align="center">
								
								<td colspan="3" align="center">
									
									<input type="hidden" id="electronicId" />
									<input type="hidden"  value="" name="filecode">
														<button onclick="paizhao()">拍照并上传</button>
														<button onclick="paizhao1()">顺时针旋转90度拍照并上传</button>	
														<button onclick="closeScan()">关闭窗口</button>													
								</td>
							</tr>
						</table>
					</form>

</body>
</html>
