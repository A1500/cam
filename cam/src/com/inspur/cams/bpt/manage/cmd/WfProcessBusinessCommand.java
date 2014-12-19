package com.inspur.cams.bpt.manage.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.dao.jdbc.WfProcessBusinessDao;
import com.inspur.cams.bpt.base.data.WfProcessBusiness;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;

/**
 * @title:WfProcessBusinessCommand
 * @description:
 * @author:
 * @since:2011-06-07
 * @version:1.0
*/
public class WfProcessBusinessCommand extends BaseAjaxCommand{
	private WfProcessBusinessDao dao = (WfProcessBusinessDao) DaoFactory
			.getDao("com.inspur.cams.bpt.base.dao.jdbc.WfProcessBusinessDao");
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		WfProcessBusiness dataBean=(WfProcessBusiness)record.toBean(WfProcessBusiness.class);
		dao.insert(dataBean);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		WfProcessBusiness dataBean=(WfProcessBusiness)record.toBean(WfProcessBusiness.class);
		dao.update(dataBean);
	}
	@Trans
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	@Trans
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<WfProcessBusiness> list = new ArrayList<WfProcessBusiness>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			WfProcessBusiness dataBean = (WfProcessBusiness) records[i].toBean(WfProcessBusiness.class);
			list.add(dataBean);
		}
		// do save
		WfProcessBusinessDao dao = (WfProcessBusinessDao) DaoFactory
				.getDao("com.inspur.cams.bpt.base.dao.jdbc.WfProcessBusinessDao");
		dao.save(list);
	}
	public void querybasinessId() {
		ParameterSet pset = getParameterSet();
		String processId = (String)pset.getParameter("PROCESS_ID@=");
		DataSet baseInfoDataSet = WfProcessBusinessDao.getInstance().queryById(processId);
		String businessId=(String)baseInfoDataSet.getRecord(0).get("businessId");
		setReturn("businessId",businessId);
	}
	
	/**
	 * 查询业务类型
	 */
	public void queryBusinessType(){
		
		 //工作流信息的服务接口
		IWfProcessBusinessDomain processBusinessService = ScaComponentFactory.getService(IWfProcessBusinessDomain.class,
		"wfProcessBusinessDomain/wfProcessBusinessDomain");
		
		IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,"bptGroupDomain/bptGroupDomain");
		
		ParameterSet pset = getParameterSet();
		if(pset.containsKey("PROCESS_ID")){
			setReturn("businessType", processBusinessService.query(pset).getRecord(0).get("businessType").toString());
			setReturn("peopleId", processBusinessService.query(pset).getRecord(0).get("connectId").toString());
			String peopleId = processBusinessService.query(pset).getRecord(0).get("connectId").toString();
			pset.clear();
			pset.setParameter("PEOPLE_ID", peopleId);
			String familyId = service.queryPeople(pset).getRecord(0).get("familyId").toString();
			setReturn("familyId", familyId);
		}else if(pset.containsKey("assignmentId")){
			String assignmentId = (String)pset.getParameter("assignmentId");
			String processId = processBusinessService.getProcessId(assignmentId);
			pset.clear();
			pset.setParameter("PROCESS_ID", processId);
			setReturn("businessType", processBusinessService.query(pset).getRecord(0).get("businessType").toString());
			setReturn("peopleId", processBusinessService.query(pset).getRecord(0).get("connectId").toString());
			String peopleId = processBusinessService.query(pset).getRecord(0).get("connectId").toString();
			pset.clear();
			pset.setParameter("PEOPLE_ID", peopleId);
			String familyId = service.queryPeople(pset).getRecord(0).get("familyId").toString();
			setReturn("familyId", familyId);
		}
	}
	
	/**
	 * 验证流程是否为退回
	 */
	public void validateIfback() {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("BUSINESS_ID", getParameter("applyId"));
		DataSet ds = dao.query(pset);
		if(ds.getCount() != 0) {
			WfProcessBusiness wfprocessBusiness = (WfProcessBusiness)ds.getRecord(0).toBean(WfProcessBusiness.class);
			if("y".equals(wfprocessBusiness.getIfback())) {
				setReturn("ifback", true);
			} else {
				setReturn("ifback", false);
			}
		} else {
			setReturn("ifback", false);
		}
	}
}
