package com.inspur.cams.welfare.prosthesis.apply.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.RecordSet;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.welfare.prosthesis.apply.domain.IFitWorkerQueryDomain;

public class FitWorkerQueryCmd extends BaseAjaxCommand{
	private IFitWorkerQueryDomain fitWorkerQueryDomain = ScaComponentFactory
	.getService(IFitWorkerQueryDomain.class, "fitWorkerQueryDomain/fitWorkerQueryDomain");
	
	//查询职工合计信息
	public DataSet queryFitWorkerSum(){
		ParameterSet pset = getParameterSet();
		DataSet ds= fitWorkerQueryDomain.queryFitWorkerSum(pset);
		if(ds.getCount() > 0) {
			RecordSet rs=ds.getRecordSet();
			setReturn("totalNum", rs.get(0).get("TOTAL_NUM"));
			setReturn("disNum", rs.get(0).get("DIS_NUM"));
			setReturn("noProNum", rs.get(0).get("NO_PRO_NUM"));
			setReturn("proNum", rs.get(0).get("PRO_NUM"));
		}
		
		return ds;
	}
}
