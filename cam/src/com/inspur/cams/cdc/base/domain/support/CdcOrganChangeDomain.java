package com.inspur.cams.cdc.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcOrganChangeDao;
import com.inspur.cams.cdc.base.data.CdcOrganChange;
import com.inspur.cams.cdc.base.domain.ICdcOrganChangeDomain;
import com.inspur.cams.comm.extuser.data.ComExtUser;
import com.inspur.cams.comm.extuser.domain.IComExtUserDomain;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 社区变更表domain
 * @author 
 * @date 2012-04-13
 */
public class CdcOrganChangeDomain implements ICdcOrganChangeDomain {

	@Reference
	private ICdcOrganChangeDao cdcOrganChangeDao;
	
	@Reference
	private IComExtUserDomain comExtUserDomain;

	/**
	 * 查询 社区变更表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcOrganChangeDao.query(pset);
	}

	/**
	 * 增加社区
	 * @param comExtUser
	 */
	public void add(ComExtUser comExtUser) {
		comExtUserDomain.insertComExtUser(comExtUser);
		
		CdcOrganChange cdcOrganChange = getCdcOrganChange(comExtUser);
		cdcOrganChange.setChangeType("X");
		cdcOrganChangeDao.insert(cdcOrganChange);
	}
	
	/**
	 * 变更社区
	 * @param comExtUser
	 */
	public void change(ComExtUser comExtUser) {
		comExtUserDomain.updateComExtUser(comExtUser);
		
		CdcOrganChange cdcOrganChange = getCdcOrganChange(comExtUser);
		cdcOrganChange.setChangeType("B");
		cdcOrganChangeDao.insert(cdcOrganChange);
	}
	
	/**
	 * 撤销社区
	 * @param comExtUser
	 */
	public void cancel(String userId) {
		ComExtUser comExtUser = comExtUserDomain.getComExtUser(userId);
		comExtUser.setInUse("0");
		comExtUserDomain.updateComExtUser(comExtUser);
		
		CdcOrganChange cdcOrganChange = getCdcOrganChange(comExtUser);
		cdcOrganChange.setChangeType("C");
		cdcOrganChangeDao.insert(cdcOrganChange);
	}

	/**
	 * 合并社区
	 * @param comExtUser
	 */
	public void merge(ComExtUser comExtUser, List<CdcOrganChange> cdcOrganChangeList) {
		// 合并成立的社区
		comExtUserDomain.insertComExtUser(comExtUser);
		
		CdcOrganChange buildCdcOrganChange = getCdcOrganChange(comExtUser);
		buildCdcOrganChange.setChangeType("X");
		buildCdcOrganChange.setIfMerge("1");
		StringBuffer content = new StringBuffer();
		content.append("由");
		
		for (int i = 0; i < cdcOrganChangeList.size(); i++) {
			CdcOrganChange cancelOrgan = (CdcOrganChange) cdcOrganChangeList.get(i);
			if (i != 0) {
				content.append(",");
			}
			content.append("[");
			content.append(cancelOrgan.getAreaCode());
			content.append("]");
			content.append(cancelOrgan.getAreaName());
			
			ComExtUser cancelComExtUser = comExtUserDomain.getComExtUser(cancelOrgan.getAreaCode());
			cancelComExtUser.setInUse("0");
			comExtUserDomain.updateComExtUser(cancelComExtUser);
			
			CdcOrganChange cancelCdcOrganChange = getCdcOrganChange(cancelComExtUser);
			cancelCdcOrganChange.setChangeType("C");
			cancelCdcOrganChange.setIfMerge("1");
			cancelCdcOrganChange.setMergeId(buildCdcOrganChange.getChangeId());
			cancelCdcOrganChange.setChangeContent("合并到[" + buildCdcOrganChange.getAreaCode() + "]" + buildCdcOrganChange.getAreaName());
			cdcOrganChangeDao.insert(cancelCdcOrganChange);
		}
		content.append("合并");
		buildCdcOrganChange.setChangeContent(content.toString());
		cdcOrganChangeDao.insert(buildCdcOrganChange);
	}
	
	private CdcOrganChange getCdcOrganChange(ComExtUser comExtUser) {
		CdcOrganChange cdcOrganChange = new CdcOrganChange();
		cdcOrganChange.setChangeId(IdHelp.getUUID32());
		cdcOrganChange.setChangeType("");
		cdcOrganChange.setIfMerge("0");
		cdcOrganChange.setMergeId("");
		cdcOrganChange.setAreaCode(comExtUser.getUserId());
		cdcOrganChange.setAreaName(comExtUser.getUserName());
		cdcOrganChange.setParentOrganCode(comExtUser.getOrganId());
		cdcOrganChange.setParentOrganName(comExtUser.getOrganName());
		cdcOrganChange.setCommunityType(comExtUser.getCommunityType());
		cdcOrganChange.setIfVillage(comExtUser.getIfVillage());
		cdcOrganChange.setChangeContent("");
		cdcOrganChange.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
		cdcOrganChange.setCreateOrgan(BspUtil.getCorpOrgan().getOrganName());
		cdcOrganChange.setCreateTime(DateUtil.getTime());
		return cdcOrganChange;
	}

	/**
	 * 获取 社区变更表
	 * @param pset
	 * @return
	 */
	public CdcOrganChange get(String changeId) {
		return cdcOrganChangeDao.get(changeId);
	}

	/**
	 * 增加 社区变更表
	 * @param cdcOrganChange
	 */
	public void insert(CdcOrganChange cdcOrganChange) {
		cdcOrganChangeDao.insert(cdcOrganChange);
	}
	
	/**
	 * 修改 社区变更表
	 * @param cdcOrganChange
	 */
	public void update(CdcOrganChange cdcOrganChange) {
		cdcOrganChangeDao.update(cdcOrganChange);
	}
	
	/**
	 * 删除 社区变更表
	 * @param changeId
	 */
	public void delete(String changeId) {
		cdcOrganChangeDao.delete(changeId);
	}

}