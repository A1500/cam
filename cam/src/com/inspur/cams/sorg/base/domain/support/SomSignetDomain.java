package com.inspur.cams.sorg.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.dao.ISomSignetDao;
import com.inspur.cams.sorg.base.dao.ISomSignetDirectoryDao;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomSignet;
import com.inspur.cams.sorg.base.data.SomSignetDirectory;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomSignetDomain;
import com.inspur.cams.sorg.util.ApplyType;
import com.inspur.cams.sorg.util.SomIdHelp;

public class SomSignetDomain implements ISomSignetDomain {
	@Reference
	private ISomSignetDao somSignetDao;
	@Reference
	private ISomSignetDirectoryDao somSignetDirectoryDao;
	
	@Reference
	private ISomApplyDomain somApplyDomain;

	public DataSet query(ParameterSet pset) {
		return somSignetDao.query(pset);
	}

	/**
	 * 增加社会组织印章信息
	 * @param somSignet
	 */
	public void insert(SomSignet somSignet) {
		//把有效的印章备案状态改为历史
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID@=",somSignet.getSorgId());
		pset.setParameter("REG_STATUS@=","1");
		DataSet ds = query(pset);
		if(ds.getCount()>0){
			SomSignet bean = (SomSignet)(ds.getRecord(0).toBean(SomSignet.class));
			bean.setRegStatus("2");
			somSignetDao.update(bean);
		}
		//增加新的备案信息
		somSignet.setId(IdHelp.getUUID30());
		somSignet.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
		somSignet.setMorgName(BspUtil.getCorpOrgan().getOrganName());
		somSignet.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
		somSignet.setCreateTime(DateUtil.getTime());
		//somSignet.setRegPeople(BspUtil.getEmpOrgan().getOrganName());
		//somSignet.setRegDate(DateUtil.getDay());
		somSignet.setRegStatus("1");
		somSignetDao.insert(somSignet);
		dealSomSignetDirectory(somSignet);
		
		SomApply somApply = new SomApply();
		somApply.setTaskCode(somSignet.getTaskCode());
		somApply.setSorgId(somSignet.getSorgId());
		if(somSignet.getSorgType().equals("S")){
			somApply.setApplyType(ApplyType.SOM_GROUP_SIGNET_FILING);
		}
		if(somSignet.getSorgType().equals("M")){
			somApply.setApplyType(ApplyType.SOM_UNGOV_SIGNET_FILING);
		}
		if(somSignet.getSorgType().equals("J")){
			somApply.setApplyType(ApplyType.SOM_FUND_SIGNET_FILING);
		}
		somApply.setSorgType(somSignet.getSorgType());
		somApply.setIfFinish("1");
		somApply.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
		somApply.setAuditTime(DateUtil.getTime());
		somApplyDomain.insert(somApply);
	}

	/**
	 * 修改社会组织印章信息
	 * @param somSignet
	 */
	public void update(SomSignet somSignet) {
		somSignetDao.update(somSignet);
		dealSomSignetDirectory(somSignet);
	}
	public void del(String taskCode) {
		somSignetDao.del(taskCode);
	}

	private void dealSomSignetDirectory(SomSignet somSignet) {
		List<SomSignetDirectory> somSignetDirectoryList=somSignet.getSomSignetDirectoryList();
		for (int i = 0; i < somSignetDirectoryList.size(); i++) {
			SomSignetDirectory somSignetDirectory=somSignetDirectoryList.get(i);
			if (somSignetDirectory.getState() == Record.STATE_NEW) {
				somSignetDirectory.setId(somSignet.getId());
				somSignetDirectoryDao.insert(somSignetDirectory);
			} else if (somSignetDirectory.getState() == Record.STATE_MODIFIED) {
				somSignetDirectoryDao.update(somSignetDirectory);
			} else if (somSignetDirectory.getState() == Record.STATE_DELETED) {
				somSignetDirectoryDao.delete(somSignetDirectory.getId());
			}
		}
	}
}
