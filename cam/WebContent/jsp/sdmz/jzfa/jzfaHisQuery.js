/**
*
*初始化 根据救助类型过滤查询
*
*/
function init() {
	
}
// 执行查询 设置参数过滤
/*******************************救助历史信息查询S**********************************************************/
function query() {
    var assistedName = document.getElementById("assistedName").value;//救助对象名称
    var assistedIdCard = document.getElementById("assistedIdCard").value;//救助对象身份证
    var assistedOrganName = document.getElementById("assistedOrganName").value;//救助单位名称
    var planBegin = document.getElementById("planBegin").value;//受助日期S
    var planEnd = document.getElementById("planEnd").value;//受助日期T
    var lrrqQ = document.getElementById("lrrqQ").value;//录入日起S 
    var lrrqZ = document.getElementById("lrrqZ").value;//录入日起T
    var planType = document.getElementById("planType").value;//救助类型
    if(assistedName==""||assistedIdCard==""){
    	if(assistedName==""){
    		alert("请输入查询救助对象的姓名！");
    		return;
    	}
        if(assistedIdCard==""){
    		alert("请输入查询救助对象的身份证！");
    		return;
    	}
    	return;
    }
    var familyDataset =L5.DatasetMgr.lookup("familyDataset");
	var personDataset =L5.DatasetMgr.lookup("personDataset");
	var otherPersonDataset =L5.DatasetMgr.lookup("otherPersonDataset");
    familyDataset.setParameter("assistedName",assistedName);
    familyDataset.setParameter("assistedIdCard",assistedIdCard);
    familyDataset.setParameter("assistedOrganName",assistedOrganName);
    familyDataset.setParameter("planBegin",planBegin);
    familyDataset.setParameter("planEnd",planEnd);
    familyDataset.setParameter("lrrqQ",lrrqQ);
    familyDataset.setParameter("lrrqZ",lrrqZ);
    familyDataset.setParameter("planType",planType);
    familyDataset.load();
    //查询本人的救助历史信息-传入参数
    personDataset.setParameter("assistedName",assistedName);
    personDataset.setParameter("assistedIdCard",assistedIdCard);
    personDataset.setParameter("assistedOrganName",assistedOrganName);
    personDataset.setParameter("planBegin",planBegin);
    personDataset.setParameter("planEnd",planEnd);
    personDataset.setParameter("lrrqQ",lrrqQ);
    personDataset.setParameter("lrrqZ",lrrqZ);
    personDataset.setParameter("planType",planType);
    personDataset.load();
    //查询家庭的其他成员救助历史信息-传入参数
    otherPersonDataset.setParameter("assistedName",assistedName);
    otherPersonDataset.setParameter("assistedIdCard",assistedIdCard);
    otherPersonDataset.setParameter("assistedOrganName",assistedOrganName);
    otherPersonDataset.setParameter("planBegin",planBegin);
    otherPersonDataset.setParameter("planEnd",planEnd);
    otherPersonDataset.setParameter("lrrqQ",lrrqQ);
    otherPersonDataset.setParameter("lrrqZ",lrrqZ);
    otherPersonDataset.setParameter("planType",planType);
    otherPersonDataset.load();
    //var url = "jzfaHisDetail.jsp?assistedName="+assistedName+"&assistedIdCard="+assistedIdCard+"&assistedOrganName="+assistedOrganName+"&planBegin="+planBegin+"&planEnd="+planEnd+"&lrrqQ="+lrrqQ+"&lrrqZ="+lrrqZ;
    // openWindow(url);
}
/**********************************救助历史信息查询T********************************************/
function openWindow(url){
        var width = screen.width-200;
		var height = screen.height-200;

		var win =window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");

		if (win == null) {
			return;
		}
}