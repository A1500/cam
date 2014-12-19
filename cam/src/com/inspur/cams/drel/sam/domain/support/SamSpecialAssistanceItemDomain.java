package com.inspur.cams.drel.sam.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.drel.config.assistance.data.SamAssistanceClass;
import com.inspur.cams.drel.sam.dao.ISamSpecialAssistanceItemDao;
import com.inspur.cams.drel.sam.data.SamSpecialAssistanceItem;
import com.inspur.cams.drel.sam.domain.ISamSpecialAssistanceItemDomain;


/**
 * @title:ISamSpecialAssistanceItemDomain
 * @description:
 * @author douyn
 * @since:2012-05-17
 * @version:1.0
*/
public class SamSpecialAssistanceItemDomain implements ISamSpecialAssistanceItemDomain{
	@Reference
	private ISamSpecialAssistanceItemDao samSpecialAssistanceItemDao;

	public DataSet query(ParameterSet pset) {
		DataSet ds = samSpecialAssistanceItemDao.query(pset);
		return ds;
	}

	public DataSet queryById(String id) {
		DataSet ds = new DataSet();
		SamSpecialAssistanceItem item = samSpecialAssistanceItemDao.get(id);
		if(item != null){
			ds.addRecord(item);
		}
		return ds;
	}

	public void save(SamSpecialAssistanceItem item) {
		String itemId=item.getItemId();
		if(itemId==null||"".equals(itemId)){
			item.setItemId(IdHelp.getUUID32());
			item.setAreaCode(BspUtil.getOrganCode());
			item.setRegPeople(BspUtil.getEmpOrgan().getOrganName());
			item.setRegOrgan(BspUtil.getOrganName());
			item.setRegTime(DateUtil.getTime());
			samSpecialAssistanceItemDao.insert(item);
		} else {
			samSpecialAssistanceItemDao.update(item);
		}
	}

	public void update(SamSpecialAssistanceItem item) {
		samSpecialAssistanceItemDao.update(item);
	}
	
}
