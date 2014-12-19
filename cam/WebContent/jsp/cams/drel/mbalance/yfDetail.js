var currentJsp;
var organCode;
function init(){
    var ds=L5.DatasetMgr.lookup("ds");
    if(bptType!="null"){
    	ds.setParameter("bptType",bptType);
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
	ds.load();
}

//返回方法
function back() {	
	if(currentJsp="dom"){
		var url='jsp/cams/drel/mbalance/samMBalanceReportByDomBpt.jsp';
		var text = '一站结算住院结算报表';
		L5.forward(url,text);
		return;	
	}else if(currentJsp="hom"){
		var url='jsp/cams/drel/mbalance/samMBalanceReportByHosBpt.jsp';
		var text = '一站结算住院结算报表';
		L5.forward(url,text);
		return;	
	}
}