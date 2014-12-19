<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ page import="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleCommand"%>
<html>
<head>
<title>身份证照片查看</title>
<next:ScriptManager />
<%
	BptBaseinfoPeopleCommand command = new BptBaseinfoPeopleCommand();
	String photoId = command.findPhotoId(request.getParameter("peopleId"));
	String photoTable = "COM_PHOTO";
	if(photoId!=null && photoId.length()>0){
		photoTable = photoTable+"_"+photoId.substring(0,6);
	}

%>
</head>
<body>
<div align="center">
<img name="RELATIONER_PHOTOC_IMG" width=350 
	 src="<%=SkinUtils.getRootUrl(request) %>download?table=<%=photoTable %>&column=CARD_PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='<%=photoId %>'" align="top" onerror="javascript:this.src='NoPicture.png'" alt="暂无图片" />
</div>

</body>
</html>
