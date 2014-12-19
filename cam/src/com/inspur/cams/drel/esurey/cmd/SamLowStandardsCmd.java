package com.inspur.cams.drel.esurey.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.esurey.data.SamLowStandards;
import com.inspur.cams.drel.esurey.domain.ISamLowStandardsDomain;

/**
 * @title:SamLowStandardsCommand
 * @description:
 * @author:
 * @since:2011-07-06
 * @version:1.0
*/
public class SamLowStandardsCmd extends BaseAjaxCommand{
	
	private ISamLowStandardsDomain service = 
			ScaComponentFactory.getService(ISamLowStandardsDomain.class,"SamLowStandardsDomain/SamLowStandardsDomain");
	
	public void insert() {
		Record record = (Record) getParameter("record");
		SamLowStandards dataBean=(SamLowStandards)record.toBean(SamLowStandards.class);
		dataBean.setModOrgan(BspUtil.getCorpOrganId());
		dataBean.setModPeople(BspUtil.getEmpOrganId());
		dataBean.setModTime(DateUtil.getTime());
		service.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SamLowStandards dataBean=(SamLowStandards)record.toBean(SamLowStandards.class);
		dataBean.setModOrgan(BspUtil.getCorpOrganId());
		dataBean.setModPeople(BspUtil.getEmpOrganId());
		dataBean.setModTime(DateUtil.getTime());
		service.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		service.batchDelete(delIds);
	}
	@Trans
	public void save() {
		Record record = (Record) getParameter("records");
		SamLowStandards dataBean = (SamLowStandards) record.toBean(SamLowStandards.class);
		
		String assitanceType = dataBean.getAssitanceType();
		String domicileCode = dataBean.getDomicileCode() ;
		String supportWay = dataBean.getSupportWay();
		
		ParameterSet pset = new ParameterSet();
		pset.setParameter("ASSITANCE_TYPE", assitanceType);
		pset.setParameter("DOMICILE_CODE", domicileCode);
		pset.setParameter("SUPPORT_WAY", supportWay);
		pset.setParameter("IN_USE","1");
		
		DataSet ds = service.query(pset);
		if(ds.getCount()> 0 ){
			for (int i = 0; i < ds.getCount(); i++) {
				SamLowStandards currentStandard = (SamLowStandards) ds.getRecord(i).toBean(SamLowStandards.class);
				currentStandard.setValidEndDate(DateUtil.getLastmonth(dataBean.getValidBeginDate()));
				currentStandard.setInUse("0");
				service.update(currentStandard);
			}
		}
		dataBean.setStandardsId(IdHelp.getUUID32());
		dataBean.setModOrgan(BspUtil.getCorpOrganId());
		dataBean.setModPeople(BspUtil.getEmpOrganId());
		dataBean.setModTime(DateUtil.getTime());
		service.insert(dataBean);
	}
	
	public void unUse(){
		String id=(String)getParameter("id");
		service.unUse(id);
	}
}
