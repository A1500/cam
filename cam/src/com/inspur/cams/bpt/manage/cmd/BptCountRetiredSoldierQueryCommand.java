package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.base.dao.IBptCountRetiredSoldierDao;
import com.inspur.cams.bpt.base.dao.IBptPeopleDemobilizedDao;
import com.inspur.cams.bpt.base.dao.jdbc.BptCountRetiredSoldierDao;
import com.inspur.cams.bpt.base.data.BptCountRetiredSoldier;
import com.inspur.cams.bpt.base.domain.IBptApplyIntoprovinceDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;

/**
 * @title:BptCountRetiredSoldierQueryCommand
 * @description:
 * @author:
 * @since:2011-08-04
 * @version:1.0
*/
public class BptCountRetiredSoldierQueryCommand extends BaseQueryCommand{
	IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,
	"bptGroupDomain/bptGroupDomain");
	BptCountRetiredSoldierDao dao = (BptCountRetiredSoldierDao) DaoFactory
	.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptCountRetiredSoldierDao");
	
	/**
	 * 获得【外省优抚人员抚恤关系迁入我省】服务接口
	 */
	private IBptApplyIntoprovinceDomain bptApplyIntoprovinceService = ScaComponentFactory
			.getService(IBptApplyIntoprovinceDomain.class,
					"BptApplyIntoprovinceDomain/BptApplyIntoprovinceDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<BptCountRetiredSoldier> dao = (EntityDao<BptCountRetiredSoldier>) DaoFactory
				.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptCountRetiredSoldierDao");
		return dao.query(pset);
	}
	
	public DataSet queryCountretiredSoldier(){
		ParameterSet pset = getParameterSet();
		BptCountRetiredSoldierDao soldierDao = (BptCountRetiredSoldierDao) DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptCountRetiredSoldierDao");
		
        return soldierDao.queryCountretiredSoldier(pset);
	}
	/**
	 * 查询60周岁以上退役士兵信息和相应的优抚人员信息[用于明细查看页面，需接受peopleId参数]
	 */       
	public DataSet queryBptRetiredSoldier(){
		ParameterSet pset = new ParameterSet();
		ParameterSet pset1 = getParameterSet();
        String peopleId = (String)pset1.getParameter("peopleId");
		pset.setParameter("PEOPLE_ID@=", peopleId);
		
		DataSet retiredSoldier = dao.query(pset);
		DataSet bptPeoleDataSet = service.queryBptPeople(pset);
		
		
		retiredSoldier.addField("workAbilityCode");
		retiredSoldier.addField("accountName");
		retiredSoldier.addField("accountCode");
		retiredSoldier.addField("bank");
		retiredSoldier.addField("oldLonelyFlag");
		
		Record rd1=new Record();
		if(retiredSoldier.getCount()>0)
		{
		rd1 = retiredSoldier.getRecord(0);
		Record rd2 = bptPeoleDataSet.getRecord(0);
		
		
	
		rd1.set("bank", rd2.get("bank"));
		rd1.set("accountName", rd2.get("accountName"));
		rd1.set("accountCode", rd2.get("accountCode"));
		rd1.set("oldLonelyFlag", rd2.get("oldLonelyFlag"));
		rd1.set("workAbilityCode", rd2.get("workAbilityCode"));
		}
	   return new DataSet(rd1);
   }
	/**
	 * 查询60周岁以上退役士兵信息和相应的迁入优抚人员信息[用于明细查看页面，需接受peopleId参数]
	 */       
	public DataSet queryIngoingBptRetiredSoldier(){
		DataSet  ds =queryBptRetiredSoldier();
		String applyId = (String)getParameter("applyId");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("APPLY_ID", applyId);
		DataSet ads=bptApplyIntoprovinceService.query(pset);
		if(ds.getCount()>0&&ads.getCount()>0){
			Record r = ds.getRecord(0);
			Record r2= ads.getRecord(0);
			r.set("ingoingAddress", r2.get("ingoingAddress"));
			r.set("allowanceMonth", r2.get("allowanceMonth"));
			r.set("ingoingCode", r2.get("ingoingCode"));
			r.set("ingoingReason", r2.get("ingoingReason"));
			r.set("serviceType", r2.get("serviceType"));
			r.set("applyId", r2.get("applyId"));
		}
		return ds;
   }
	
	/**
	 * 查询60周岁以上退役士兵信息和相应的优抚人员信息[用于明细查看页面，需接受peopleId参数](数据采集)
	 */       
	public DataSet queryBptRetiredSoldierCollection(){
		DataSet  ds =queryBptRetiredSoldier();
		ParameterSet pset = getParameterSet();
		String peopleId = (String)pset.getParameter("peopleId");
		pset.clear();
		pset.setParameter("PEOPLE_ID@=", peopleId);
		DataSet pds = service.queryPeople(pset);
		if(ds.getCount()>0){
			Record rd = ds.getRecord(0);
			if(pds.getCount()>0){
				rd.set("pretiredNo", (String)pds.getRecord(0).get("retiredNo"));
				rd.set("retiredStateCode", (String)pds.getRecord(0).get("retiredStateCode"));
			}
		}
		return ds;
		
	}
}
