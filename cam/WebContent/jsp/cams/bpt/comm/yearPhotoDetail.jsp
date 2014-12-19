<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ page import="com.inspur.cams.bpt.manage.cmd.BptYearPhotoCommand"%>
<%@ page import="org.loushang.next.data.DataSet"%>
<%
BptYearPhotoCommand command = new BptYearPhotoCommand();
String peopleId=(String)request.getParameter("peopleId");
DataSet ds  = command.getYearPhotosByPeopleId(peopleId);

%>
<html>
<head>
<title>查看人员基本信息</title>
<next:ScriptManager />
<script type="text/javascript" src="idCardReader.js"></script>
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
		</script>
</head>
<body>

    <next:Panel  height="100%" width="100%"  autoScroll="true" id="peopleTabPanel">
				<next:Html>
					
					<form id="yearPhotoForm" method="post" onsubmit="return false" style="padding: 5px;" >
					  <table border="0" width="98%">
					  <tr align="center">
					   <%for( int i= 0;i<ds.getCount();i++){ 
						  String photoId=(String)ds.getRecord(i).get("photoId");
						  String year=(String)ds.getRecord(i).get("year");
					    	 String photoTable = "COM_PHOTO";
					    	 if(photoId!=null && photoId.length()>0){
					    	 	photoTable = photoTable+"_"+photoId.substring(0,6);
					    	 } 
					  %>
							<td nowrap>
							<div id="RELATIONER_PHOTOC_IMG_DIV" style="width:0px;">
							<img name="RELATIONER_PHOTOC_IMG" width=270  src="<%=SkinUtils.getRootUrl(request) %>download?table=<%=photoTable %>&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='<%=photoId %>'" style="float:left"
								onerror="javascript:this.src='../dataCollection/comm/default.jpg'" alt="暂无图片" />
							
							<%=year %>
							</div>
							</td>
							<%if((i+1)%4==0){%>
							</tr><tr align="center">
							<%} else if(ds.getCount()==i+1){%>		
						 	</tr>
						 	<%} %>
						 <%} %>
                     </table>
					</form>
				 
				</next:Html>
		</next:Panel>
</body>
<script type="text/javascript">
	function init() {
	}

</script>
</html>
