package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcMailListDao;
import com.inspur.cams.cdc.base.data.CdcMailList;
import com.inspur.cams.cdc.base.domain.ICdcMailListDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 基层民主与社区建设通讯录domain
 * @author shgtch
 * @date 2012-3-1
 */
public class CdcMailListDomain implements ICdcMailListDomain {

	@Reference
	private ICdcMailListDao cdcMailListDao;
	
	/**
	 * 查询基层民主与社区建设通讯录
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcMailListDao.query(pset);
	}

	/**
	 * 增加基层民主与社区建设通讯录
	 * @param cdcMailList
	 */
	public void insert(CdcMailList cdcMailList) {
		cdcMailList.setListId(cdcMailList.getOrganCode() + IdHelp.getUUID32());
		cdcMailList.setCreateTime(DateUtil.getTime());
		cdcMailListDao.insert(cdcMailList);
	}
	
	/**
	 * 修改基层民主与社区建设通讯录
	 * @param cdcMailList
	 */
	public void update(CdcMailList cdcMailList) {
		cdcMailListDao.update(cdcMailList);
	}
	
	/**
	 * 删除基层民主与社区建设通讯录
	 * @param listId
	 */
	public void delete(String listId) {
		cdcMailListDao.delete(listId);
	}

	public DataSet queryList(ParameterSet pset) {
		return cdcMailListDao.queryList(pset);
	}
	
}