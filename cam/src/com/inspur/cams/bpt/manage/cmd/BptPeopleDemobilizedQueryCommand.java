package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.bpt.base.dao.IBptPeopleDemobilizedDao;
import com.inspur.cams.bpt.base.domain.IBptPeopleDemobilizedDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;

/**
 * @title:BptPeopleDemobilizedQueryCommand
 * @description:
 * @author:
 * @since:2011-05-20
 * @version:1.0
*/
public class BptPeopleDemobilizedQueryCommand extends BaseQueryCommand{

	IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,
	"bptGroupDomain/bptGroupDomain");
	
	/**  
	 * 在乡复员军人服务接口
	 */
	IBptPeopleDemobilizedDomain demobilizedService = ScaComponentFactory.getService(IBptPeopleDemobilizedDomain.class,
	"bptPeopleDemobilizedDomain/bptPeopleDemobilizedDomain");
	

	/**
	 * 查询在乡复员军人信息和相应的优抚人员信息
	 */            
	public DataSet queryDemobilizedPeople(){
		ParameterSet pset = getParameterSet();
		IBptPeopleDemobilizedDao demobilizedDao = (IBptPeopleDemobilizedDao) DaoFactory
        .getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPeopleDemobilizedDao");
		
        return demobilizedDao.queryDemobilizedPeople(pset);
	}
	/**
	 * 查询未提交的在乡复员军人
	 */
	public DataSet queryUnCimDemPeo(){
		ParameterSet pset = getParameterSet();
		return demobilizedService.queryUnCimDemPeo(pset);
	}
	
	/**
	 * 查询在乡复员军人信息和相应的优抚人员信息[用于明细查看页面，需接受peopleId参数]
	 */            
	public DataSet queryDemobilizedBptPeople(){
		
		ParameterSet pset = getParameterSet();
		
		String peopleId = (String)pset.getParameter("peopleId");
		pset.setParameter("PEOPLE_ID@=", peopleId);
		pset.remove("peopleId");
		
		DataSet demobilizedDataSet = demobilizedService.query(pset);
		DataSet bptPeoleDataSet = service.queryBptPeople(pset);
		DataSet peopleDataset = service.queryPeople(pset);
		
		demobilizedDataSet.addField("disabilityTypeCode");
		demobilizedDataSet.addField("dependantTypeCode");
		demobilizedDataSet.addField("redaTypeCode");
		demobilizedDataSet.addField("warTypeCode");
		demobilizedDataSet.addField("bank");
		demobilizedDataSet.addField("accountName");
		demobilizedDataSet.addField("accountCode");
		demobilizedDataSet.addField("insanityFlag");
		demobilizedDataSet.addField("oldLonelyFlag");
		demobilizedDataSet.addField("orphanFlag");
		demobilizedDataSet.addField("workAbilityCode");
		demobilizedDataSet.addField("workAbilityDescribe");
		demobilizedDataSet.addField("viabilityCode");
		demobilizedDataSet.addField("supportPattern");
		demobilizedDataSet.addField("jobStatusDescribe");
		
		demobilizedDataSet.addField("demobilizedStateCode");
		demobilizedDataSet.addField("demobilizedNo");
		
		Record rd1=new Record();
		if(demobilizedDataSet.getCount()>0)
		{
		rd1 = demobilizedDataSet.getRecord(0);
		Record rd2 = bptPeoleDataSet.getRecord(0);
		Record rd3 = peopleDataset.getRecord(0);
		rd1.set("disabilityTypeCode", rd2.get("disabilityTypeCode"));
		rd1.set("dependantTypeCode", rd2.get("dependantTypeCode"));
		rd1.set("redaTypeCode", rd2.get("redaTypeCode"));
		rd1.set("warTypeCode", rd2.get("warTypeCode"));
		rd1.set("bank", rd2.get("bank"));
		rd1.set("accountName", rd2.get("accountName"));
		rd1.set("accountCode", rd2.get("accountCode"));
		rd1.set("insanityFlag", rd2.get("insanityFlag"));
		rd1.set("oldLonelyFlag", rd2.get("oldLonelyFlag"));
		rd1.set("orphanFlag", rd2.get("orphanFlag"));
		rd1.set("workAbilityCode", rd2.get("workAbilityCode"));
		rd1.set("workAbilityDescribe", rd2.get("workAbilityDescribe"));
		rd1.set("viabilityCode", rd2.get("viabilityCode"));
		rd1.set("supportPattern", rd2.get("supportPattern"));
		rd1.set("jobStatusDescribe", rd2.get("jobStatusDescribe"));
		
		rd1.set("demobilizedStateCode", rd3.get("demobilizedStateCode"));
		rd1.set("demobilizedNo", rd3.get("demobilizedNo"));
		}
		return new DataSet(rd1);
	}
	/**
	 * 查询未提交的在乡复员换证军人
	 */
	public DataSet queryChangedemo(){
		ParameterSet pset = getParameterSet();
		return demobilizedService.queryChangedemo(pset);
	}
	/**
	 * 查询在乡人员为提交换证补证人员IdCard
	 */
	public DataSet queryDemobilizedBptPeopleGetIdCard(){
		ParameterSet pset = getParameterSet();
		return demobilizedService.queryDemobilizedBptPeopleGetIdCard(pset);
	}
	/**
	 * 查询未提交的外省迁入在乡复员军人人员
	 */
	public DataSet queryDemoProv(){
		ParameterSet pset = getParameterSet();
		return demobilizedService.queryDemoProv(pset);
	}
	/**
	 * 查询带病回乡人员IdCard
	 */
	public DataSet queryDemobilizedIllBptPeopleGetIdCard(){
		ParameterSet pset = getParameterSet();
		return demobilizedService.queryDemobilizedIllBptPeopleGetIdCard(pset);
	}
}
