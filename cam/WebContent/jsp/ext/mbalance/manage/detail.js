
var assitanceType;
var domicileCode;
var organCode;
function init(){
    var ds=L5.DatasetMgr.lookup("ds");
    if(assitanceType!="null"){
    	ds.setParameter("assitanceType",assitanceType);
    }
    if(domicileCode!="null"){
    	ds.setParameter("domicileCode",domicileCode);
    }
    if(hospitalId!="null"){
    	ds.setParameter("hospitalId",hospitalId);
    }
    if(currentJsp!="null"){
    	ds.setParameter("currentJsp",currentJsp);
    }
    if(organCode!="null"){
    	ds.setParameter("organCode",organCode);
   	}
    if(beginTime!="undefined"){
   		ds.setParameter("beginTime",beginTime);
   	}
    if(endTime!="undefined"){
   		ds.setParameter("endTime",endTime);
   	}
    if(regId!="undefined"){
   		ds.setParameter("regId",regId);
   	}
	ds.load();
}

function back() {	
	
	if(assitanceType!="null"){
		var url='jsp/ext/mbalance/manage/samMBalanceReportByAssType.jsp';
		var text = '一站结算住院结算报表';
		L5.forward(url,text);	
		return;
	}
	if(domicileCode!="null"){
		var url='jsp/ext/mbalance/manage/samMBalanceReportByDom.jsp';
		var text = '一站结算住院结算报表';
		L5.forward(url,text);
		return;	
	}
	if(hospitalId!="null"){
		var url='jsp/ext/mbalance/manage/samMBalanceReportByDomBpt.jsp';
		var text = '一站结算住院结算报表';
		L5.forward(url,text);
		return;	
	}
}