package com.inspur.cams.bpt.manage.cmd;


import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.base.domain.IBptApplyIntoprovinceDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleMartyrOffspringDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;


/**
 * @title:BptPeopleMartyrOffspringQueryCommand
 * @description: 部分烈士（错杀被平反人员）子女 查询
 * @author:
 * @since:
 * @version:
*/
public class BptPeopleMartyrOffspringQueryCommand extends BaseQueryCommand{
	
	private IBptPeopleDomain bptPeopleService = ScaComponentFactory.getService(IBptPeopleDomain.class,"bptPeopleDomain/bptPeopleDomain");	
	private IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,"bptGroupDomain/bptGroupDomain");
	/**
	 * 获得【外省优抚人员抚恤关系迁入我省】服务接口
	 */
	private IBptApplyIntoprovinceDomain bptApplyIntoprovinceService = ScaComponentFactory
			.getService(IBptApplyIntoprovinceDomain.class,
					"BptApplyIntoprovinceDomain/BptApplyIntoprovinceDomain");
	public DataSet queryMartyrOffspring(){
		IBptPeopleMartyrOffspringDomain martyrOffspringDomain = (IBptPeopleMartyrOffspringDomain)ScaComponentFactory.getService(IBptPeopleMartyrOffspringDomain.class, "bptPeopleMartyrOffspringDomain/bptPeopleMartyrOffspringDomain");
		ParameterSet pset = getParameterSet();
		return martyrOffspringDomain.queryMartyrOffspring(pset);
	}
	/**
	 * 查询部分烈士（错杀被平反人员）子女 修改信息
	 * @return
	 */
	public DataSet getMartyrOffsprinInfor(){
		IBptPeopleMartyrOffspringDomain martyrOffspringDomain = (IBptPeopleMartyrOffspringDomain)ScaComponentFactory.getService(IBptPeopleMartyrOffspringDomain.class, "bptPeopleMartyrOffspringDomain/bptPeopleMartyrOffspringDomain");
		String peopleId = (String)getParameter("peopleId");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("PEOPLE_ID", peopleId);
		DataSet ds = martyrOffspringDomain.query(pset);
		Record rd = new Record();
		if(ds.getCount()>0){
			rd = ds.getRecord(0);
			DataSet ds1 = bptPeopleService.query(pset);
			
			
			if(ds1.getCount()>0){
				Record rd1 = (Record)bptPeopleService.query(pset).getRecord(0);
				rd.set("oldLonelyFlag", (String)rd1.get("oldLonelyFlag"));
				rd.set("orphanFlag", (String)rd1.get("orphanFlag"));
				rd.set("workAbilityCode", (String)rd1.get("workAbilityCode"));
				rd.set("viabilityCode", (String)rd1.get("viabilityCode"));
				rd.set("supportPattern", (String)rd1.get("supportPattern"));
				rd.set("bank", (String)rd1.get("bank"));
				rd.set("accountName", (String)rd1.get("accountName"));
				rd.set("accountCode", (String)rd1.get("accountCode"));
				
			}
		}
		DataSet resultDs = new DataSet(rd);
		return resultDs;
	}
	
	/**
	 * 查询部分烈士（错杀被平反人员）子女 修改信息(信息采集)
	 * @return
	 */
	public DataSet getMartyrOffsprinInforCollection(){
		IBptPeopleMartyrOffspringDomain martyrOffspringDomain = (IBptPeopleMartyrOffspringDomain)ScaComponentFactory.getService(IBptPeopleMartyrOffspringDomain.class, "bptPeopleMartyrOffspringDomain/bptPeopleMartyrOffspringDomain");
		String peopleId = (String)getParameter("peopleId");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("PEOPLE_ID", peopleId);
		DataSet ds = martyrOffspringDomain.query(pset);
		Record rd = new Record();
		if(ds.getCount()>0){
			rd = ds.getRecord(0);
			DataSet ds1 = bptPeopleService.query(pset);
			DataSet pds = service.queryPeople(pset);
			if(ds1.getCount()>0){
				Record rd1 = (Record)bptPeopleService.query(pset).getRecord(0);
				rd.set("oldLonelyFlag", (String)rd1.get("oldLonelyFlag"));
				rd.set("orphanFlag", (String)rd1.get("orphanFlag"));
				rd.set("workAbilityCode", (String)rd1.get("workAbilityCode"));
				rd.set("viabilityCode", (String)rd1.get("viabilityCode"));
				rd.set("supportPattern", (String)rd1.get("supportPattern"));
				rd.set("bank", (String)rd1.get("bank"));
				rd.set("accountName", (String)rd1.get("accountName"));
				rd.set("accountCode", (String)rd1.get("accountCode"));
				if(pds.getCount()>0){
					rd.set("martyrOffspringStateCode", (String)pds.getRecord(0).get("martyrOffspringStateCode"));
					rd.set("martyrOffspringNo", (String)pds.getRecord(0).get("martyrOffspringNo"));
				}
			}
		}
		DataSet resultDs = new DataSet(rd);
		return resultDs;
	}
	
	public DataSet getMartyrOffsprinInforUpdate (){
		DataSet ds =getMartyrOffsprinInfor();
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

}
