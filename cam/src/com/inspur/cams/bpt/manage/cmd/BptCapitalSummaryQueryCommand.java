package com.inspur.cams.bpt.manage.cmd;

import java.math.BigDecimal;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalSummaryDao;
import com.inspur.cams.bpt.capital.data.BptCapitalSummary;
import com.inspur.cams.bpt.capital.domain.IBptCapitalSummaryDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;

/**
 * @title:BptCapitalSummaryQueryCommand
 * @description: 资金发放汇总
 * @author:
 * @since:2011-05-28
 * @version:1.0
*/
public class BptCapitalSummaryQueryCommand extends BaseQueryCommand{
	private IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,"bptGroupDomain/bptGroupDomain");
	private IBptCapitalSummaryDomain capitalSummaryService = ScaComponentFactory.getService(IBptCapitalSummaryDomain.class,"bptCapitalSummaryDomain/bptCapitalSummaryDomain");
	
	public DataSet execute() {
		Double result = 0.0 ;
		ParameterSet pset = getParameterSet();
		BptCapitalSummaryDao dao = (BptCapitalSummaryDao) DaoFactory
				.getDao("com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalSummaryDao");
		DataSet ds =service.queryDataSetSummary(pset);
		for(int i = 0;i<ds.getCount();i++){
			BptCapitalSummary rd = (BptCapitalSummary) ds.getRecord(i).toBean(BptCapitalSummary.class);
			ParameterSet param =new ParameterSet();
			param.setParameter("counties", rd.getOrganCode());
			DataSet tempDs = dao.getCounties(param);
			ds.getRecord(i).set("organName",tempDs.getRecord(0).get("ORGAN_NAME").toString());
			result +=Double.valueOf(String.valueOf(rd.getGrantMonSum()));
		}
		BptCapitalSummary summary =new BptCapitalSummary();
		summary.setRegisterName("合计");
		summary.setRegisterType("");
		summary.setOrganCode("");
		summary.setRespectiveYears("");
		summary.setGrantMonSum(new BigDecimal(result));
		summary.setGrantFlag("");
		summary.setGrantDate("");
		summary.setGrantSureDate("");
		Record rd =new Record(summary);
		ds.getRecordSet().add(rd);
		return ds;
	}
	
	/**
	 * 查询经费发放信息
	 */
	public DataSet queryFundingGrant(){
		ParameterSet pset = getParameterSet();
		DataSet ds = capitalSummaryService.queryFundingGrant(pset);
		/*Double grantSum = 0.0;
		if(ds.getCount()>0){
			for(int i=0;i<ds.getCount();i++){
				grantSum += Double.parseDouble(ds.getRecord(i).get("grantMonSum").toString());
			}
		}
		Record rd = new Record();
		rd.set("registerType","汇总");
		rd.set("grantMonSum",String.valueOf(grantSum));
		ds.addRecord(rd);*/
		return ds;
	}
}
